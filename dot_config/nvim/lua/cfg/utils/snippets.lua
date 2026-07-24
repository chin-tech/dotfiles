return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*', -- use latest major v2
  build = 'make install_jsregexp', -- optional, for regex support

  config = function()
    local ls = require 'luasnip'

    -- shorthands
    local s = ls.snippet
    local sn = ls.snippet_node
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local r = ls.restore_node
    local l = require('luasnip.extras').lambda
    local rep = require('luasnip.extras').rep
    local p = require('luasnip.extras').partial
    local m = require('luasnip.extras').match
    local n = require('luasnip.extras').nonempty
    local dl = require('luasnip.extras').dynamic_lambda
    local fmt = require('luasnip.extras.fmt').fmt
    local fmta = require('luasnip.extras.fmt').fmta
    local types = require 'luasnip.util.types'
    local conds = require 'luasnip.extras.conditions'
    local conds_expand = require 'luasnip.extras.conditions.expand'

    local function td(text, desc, color)
      if color == nil then
        color = 'ErrorMsg'
      end
      return sn(1, i(1, text), {
        node_ext_opts = {
          active = {
            virt_text = { { '  ' .. desc, color } },
            -- virt_text_pos = 'eol', -- show at end of line (works on recent LuaSnip)
          },
        },
      })
    end

    -- setup
    ls.setup {
      keep_roots = true,
      link_roots = true,
      link_children = true,
      update_events = 'TextChanged,TextChangedI',
      delete_check_events = 'TextChanged',
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '●', 'DiffText' } },
            hl_mode = 'combine',
          },
        },
        [types.insertNode] = {
          active = {
            virt_text = { { '●', 'ErrorMsg' } },
            hl_mode = 'combine',
          },
        },
      },
    }

    vim.keymap.set({ 'i', 's' }, '<C-j>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true })

    -- Previous choice (optional)
    vim.keymap.set({ 'i', 's' }, '<C-k>', function()
      if ls.choice_active() then
        ls.change_choice(-1)
      end
    end, { silent = true })

    -- You can drop your actual snippet definitions below
    -- e.g.
    -- ls.add_snippets("lua", {
    --   s("req", fmt("local {} = require('{}')", { i(1, "mod"), rep(1) })),
    -- })
    --
    -- ===== CVSS 3.1 base score (accurate) =====
    local function round_up_1dp(x)
      if not x then
        return ''
      end
      return (math.ceil(x * 10 + 1e-9)) / 10
    end

    local function severity_from_score(s)
      if s == 0 then
        return 'None'
      end
      if s <= 3.9 then
        return 'Low'
      end
      if s <= 6.9 then
        return 'Medium'
      end
      if s <= 8.9 then
        return 'High'
      end
      return 'Critical'
    end

    -- expects a table of metric short codes (strings), returns numeric score
    local function cvss31_score_from_metrics(m)
      -- m: { AV=, AC=, PR=, UI=, S=, C=, I=, A= }
      local AV = { N = 0.85, A = 0.62, L = 0.55, P = 0.20 }
      local AC = { L = 0.77, H = 0.44 }
      local UI = { N = 0.85, R = 0.62 }
      local CIA = { N = 0.00, L = 0.22, H = 0.56 }

      local S = m.S or 'U'
      local PR_U = { N = 0.85, L = 0.62, H = 0.27 }
      local PR_C = { N = 0.85, L = 0.68, H = 0.50 }
      local PR = (S == 'U') and PR_U or PR_C

      local av = AV[m.AV] or 0
      local ac = AC[m.AC] or 0
      local pr = PR[m.PR] or 0
      local ui = UI[m.UI] or 0
      local c = CIA[m.C] or 0
      local i_ = CIA[m.I] or 0
      local a = CIA[m.A] or 0

      local exploitability = 8.22 * av * ac * pr * ui
      local impact = 1.0 - ((1.0 - c) * (1.0 - i_) * (1.0 - a))

      if impact <= 0 then
        return 0.0
      end

      local impact_sub
      if S == 'U' then
        impact_sub = 6.42 * impact
      else
        impact_sub = 7.52 * (impact - 0.029) - 3.25 * ((impact - 0.02) ^ 15)
      end

      local base
      if S == 'U' then
        base = math.min(impact_sub + exploitability, 10.0)
      else
        base = math.min(1.08 * (impact_sub + exploitability), 10.0)
      end

      return round_up_1dp(base)
    end

    -- Build a metrics table from the current choices and return a snippet node with "score (Severity)"
    local function score_dyn(args)
      -- args is an array of arrays; each args[k][1] is the chosen text for node k
      local metrics = {
        AV = args[1][1],
        AC = args[2][1],
        PR = args[3][1],
        UI = args[4][1],
        S = args[5][1],
        C = args[6][1],
        I = args[7][1],
        A = args[8][1],
      }
      local score = cvss31_score_from_metrics(metrics)
      local sev = severity_from_score(score)
      return sn(nil, t(string.format('%.1f (%s)', score, sev)))
    end

    local function ext_nodes(desc, color)
      if color == nil then
        color = 'ErrorMsg'
      end
      return {
        ext_opts = {
          [types.choiceNode] = {
            virt_text = { desc, color },
            hl_mode = 'combine',
          },
        },
      }
    end

    ls.add_snippets('markdown', {
      s(
        ';finding',
        fmta(
          [[
#### <title>
CVSS <score> CVSS:3.1/AV:<av>/AC:<ac>/PR:<pr>/UI:<ui>/S:<s>/C:<c>/I:<i>/A:<a>

**What does this mean?**

- 

**Why does this matter?**

- 

**How was this exploited?**

<details>

**How is this fixed?**


**References**

]],
          {
            title = i(1, 'Finding title'),
            score = d(10, score_dyn, { 2, 3, 4, 5, 6, 7, 8, 9 }),
            av = c(2, {
              td('N', '[Attack Vector] Network: exploitable remotely'),
              td('A', '[Attack Vector] Adjacent: same L2 segment/subnet'),
              td('L', '[Attack Vector] Local: requires local session'),
              td('P', '[Attack Vector] Physical: needs physical access'),
            }),
            ac = c(3, {
              td('L', '[Attack Complexity] Low: no special conditions'),
              td('H', '[Attack Complexity] High: specific/uncommon conditions'),
            }),
            pr = c(4, {
              td('N', '[Privs Required] None: no prior access required'),
              td('L', '[Privs Required] Low: basic/limited privileges'),
              td('H', '[Privs Required] High: admin/privileged access'),
            }),
            ui = c(5, {
              td('N', '[User Interaction] None: no user interaction'),
              td('R', '[User Interaction] Required: victim must act'),
            }),
            s = c(6, {
              td('U', '[Scope] Unchanged: same security scope'),
              td('C', '[Scope] Changed: crosses trust boundary'),
            }),
            c = c(7, {
              td('N', '[Confidentiality Impacted] None: no data disclosure'),
              td('L', '[Confidentiality Impacted] Low: limited disclosure'),
              td('H', '[Confidentiality Impacted] High: complete disclosure'),
            }),
            i = c(8, {
              td('N', '[Integrity Impact] None: no data modification'),
              td('L', '[Integrity Impact] Low: limited modification'),
              td('H', '[Integrity Impact] High: total compromise'),
            }),
            a = c(9, {
              td('N', '[Availability Impact] None: no availability impact'),
              td('L', '[Availability Impact] Low: degraded/partial outage'),
              td('H', '[Availability Impact] High: full DoS/shutdown'),
            }),
            details = i(11, ' '),
          }
        )
      ),
    })
  end,
}
