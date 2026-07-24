-- Save this file as: ~/.config/nvim/lua/plugins/win_compile.lua

return {
  dir = vim.fn.stdpath 'config',
  name = 'win_compile',

  keys = {
    { '<leader>wc', ':WinCompile<CR>', desc = 'Remote Windows Compile', silent = true },
  },

  config = function()
    local win_user = 'Administrator'
    local win_host = 'cw1'
    local lin_root = vim.fn.expand '~/programming/windows'
    local win_root = 'c:\\penbuild\\linuxbuilders\\'
    local default_compile_cmd = 'msbuild'

    local function get_compile_command()
      local project_root = vim.fs.dirname(vim.fs.find('.compilecommand', { upward = true })[1])
      if project_root then
        local file_path = project_root .. '/.compilecommand'
        local file = io.open(file_path, 'r')
        if file then
          local content = file:read '*l'
          file:close()
          if content and content ~= '' then
            return content:gsub('\r', '')
          end
        end
      end
      return default_compile_cmd
    end

    vim.api.nvim_create_user_command('WinCompile', function()
      local cur_dir = vim.fn.getcwd()

      if not string.find(cur_dir, lin_root, 1, true) then
        vim.api.nvim_err_writeln '❌ Not inside the ~/programming/windows/ tree!'
        return
      end
      local relative_path = string.sub(cur_dir, string.len(lin_root) + 2)
      local win_relative = string.gsub(relative_path, '/', '\\')
      local win_project_dir = win_root .. win_relative

      local compile_cmd = get_compile_command()
      local ssh_cmd = string.format("ssh %s@%s 'cd %s; %s'", win_user, win_host, win_project_dir, compile_cmd)

      local width = math.floor(vim.o.columns * 0.8)
      local height = math.floor(vim.o.lines * 0.8)
      local col = math.floor((vim.o.columns - width) / 2)
      local row = math.floor((vim.o.lines - height) / 2)

      local buf = vim.api.nvim_create_buf(false, true)
      local win_opts = {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'rounded',
        title = ' Remote Build Output ',
        title_pos = 'center',
      }

      local win = vim.api.nvim_open_win(buf, true, win_opts)

      -- Modern Way: Use jobstart with 'term = true' inside the current buffer
      vim.fn.jobstart(ssh_cmd, {
        term = true, -- Emulates a pseudo-terminal session inside the buffer
        on_exit = function(_, exit_code)
          vim.bo[buf].modifiable = true
          if exit_code == 0 then
            vim.api.nvim_buf_set_lines(buf, -1, -1, false, { '', '✨ Process finished successfully!' })
          else
            vim.api.nvim_buf_set_lines(buf, -1, -1, false, { '', '❌ Process exited with code ' .. exit_code })
          end
          vim.bo[buf].modifiable = false
        end,
      })

      vim.cmd 'startinsert'

      vim.keymap.set('n', 'q', function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end, { buffer = buf, silent = true, desc = 'Close build window' })

      vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = buf, silent = true })
    end, {})
  end,
}
