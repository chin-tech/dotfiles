// gomplate template file
// pandoc md to pdf through typst template
// this still a pandoc template, not typst script
// 文档模板中的字体选项

// emoji font: "Apple Color Emoji"(macos), "Segoe UI Emoji"(windows), "Noto Color Emoji"(not macos/windows)

// // for windows
// // fonts for emoji
// #let emmoji_fonts=("Segoe UI Emoji", "Noto Color Emoji",)
// #let mainfont = ("Segoe UI",)
// #let monofont = ("Consolas",)

// for macos\
// fonts for emoji
#let emmoji_fonts=( "Noto Color Emoji",)
#let mainfont = ("Hack Nerd Font",)
#let monofont = ("RobotoMono Nerd Font",)

// // for linux
// // fonts for emoji
// #let emmoji_fonts=("Noto Color Emoji",)
// #let mainfont = ("Menlo",)
// #let monofont = ("DejaVu Sans Mono")



// fonts defined
#let fonts=(
    normal: (
        // typst 0.12: typst 
        // normal font for whole doc
        font: (name: ( ..mainfont, "Libertinus Serif", ..emmoji_fonts))
    ),
    codeblock: (
        // mono font for code snippets
        font: (name: ( ..monofont, "DejaVu Sans Mono", ..emmoji_fonts)),
    ),
    math: (
        // typst built-in math font, New Computer Modern Math
        font: (name: ("New Computer Modern Math",  ..emmoji_fonts)),
    )
    
)


// 全文使用到的变量，如颜色
// 有引用到的变量均可放到本段

// colors in page except codeblock
#let theme=(
    accent: "#e6b450", 
    active_guide: "#6c738080", 
    background: "#10141c", 
    block_caret: "#e6b4504d", 
    caret: "#e6b450", 
    find_highlight: "#e6b450", 
    find_highlight_foreground: "#10141c", 
    foreground: "#bfbdb6", 
    guide: "#6c73804d", 
    gutter: "#10141c", 
    gutter_foreground: "#6c738099", 
    highlight: "#e6b45066", 
    inactive_selection: "#80b5ff26", 
    inactive_selection_border: "#80b5ff26", 
    invisibles: "#bfbdb64d", 
    line_diff_added: "#7fd962b3", 
    line_diff_deleted: "#f26d78b3", 
    line_diff_modified: "#73b8ffb3", 
    line_diff_width: "2", 
    line_highlight: "#161a24", 
    selection: "#3388ff40", 
    selection_border: "#3388ff40", 
    selection_border_width: "1", 
    selection_corner_radius: "4", 
    selection_corner_style: "round", 
    shadow: "#10141c4d", 
    shadow_width: "3", 
    stack_guide: "#6c738066", 
    )


// highlight theme used in codeblock
#let code-highlight=(
    active_guide: "#f5a97f80", 
    background: "#24273a", 
    bracket_contents_foreground: "#939ab780", 
    bracket_contents_options: "underline", 
    brackets_foreground: "#939ab780", 
    brackets_options: "underline", 
    caret: "#b8c0e0", 
    find_highlight: "#eed49f", 
    find_highlight_foreground: "#1e2030", 
    foreground: "#cad3f5", 
    gutter_foreground: "#939ab7", 
    gutter_foreground_highlight: "#a6da95", 
    invisibles: "#939ab766", 
    line_highlight: "#cad3f512", 
    selection: "#8087a266", 
    selection_border: "#24273a", 
    tags_options: "stippled_underline", 
    )

// globals config
#let globals=(
    normal: (
        // typst 0.12: typst 
        // normal font for whole doc
        // emoji font: "Apple Color Emoji"(macos), "Segoe UI Emoji"(windows), "Noto Color Emoji"(not macos/windows)
        // 
        font: fonts.normal.font,
        size: 14pt,
    ),
    codeblock: (
        // mono font for code snippets
        font: fonts.codeblock.font,
        size: 12em/14,
        theme: ( path: "themes/catppuccin-macchiato.tmTheme")
    ),
    math: (
        // typst built-in math font, New Computer Modern Math
        font: fonts.math.font,
        size: 1em,
    ),
    table: (
        border: (
            color: "#bfbdb6"
        )            
    ),
    figure: (
        numbering: (
            heading_numbers: false
        )
    )
    
)

// #let chaptercounter = counter("chapter")

// Document Element settings

// ref: https://imaginarytext.ca/posts/2024/pandoc-typst-tutorial/

// Pandoc/markdown HR treatment
// display as a blank white section break
// I bet you can figure out how to make it a different colour!

#let horizontalrule = [

  #block(spacing: 1em, inset: (5pt))[
    // #v(1pt)
    #line(start: ( 2 * 14pt,0%), end: (100%,0%), stroke: 1pt + rgb("#bfbdb6"))
    // #v(1pt) 
  ]

  #linebreak()
  #v(-1em)
]

// //////////
// page setting

// page margin
// page number
// header
// footer
// columns

// 
// Letter-size
 // width: 8.5in,
 // height: 11in,
 // margin: (left: 1.25in, top: 1.25in, right: 1.25in, bottom: 1.5in),

// paper: a4
// width: 595.28pt
// height: 841.89pt
// margin: top/bottom, 2.54, left/right: 3.18cm // 与 WPS 相同

// flipped: // if true = flips to landscape format,   


  #set page(
    // page size
    paper: "a4",
    margin: (top: 1.5 * 14pt, bottom: 1.5 * 14pt, left: 14pt, right: 14pt),
    width: 300pt , 
    height: 650pt,
    // margin: (top: 2.54cm, bottom: 2.54cm, left: 2.54cm, right: 2.54cm),
    
    // page background
    fill: rgb("#10141c"),

// Header and Footer 
// 
    // header:  // A running head: document title
    //   locate(loc => {
    //     if counter(page).at(loc).first() > 1 [    // after page 1
    //        #set text(size: 11pt, style: "italic")
    //        #align(right)[#title]
    //     ]
    // }),
    // footer-descent: 30%, //30 is default
    // typst 0.12 : `locate` with callback function is deprecated, use a `context` expression instead
    footer:  // A running footer: page numbers
      context {
        let page_number = counter(page).get().first()
        show text: set text(style: "italic")
        if page_number > 0 [ // after page ?
          #align(right)[#page_number]
        ]
        // counter(page).display()

      }    
)

// body text

// unit:
// 1 毫米 = 2.83 磅， 1磅=1/72英寸，1英寸=21.4毫米
// 「八号」对应磅值5
// 「七号」对应磅值5.5
// 「小六」对应磅值6.5
// 「六号」对应磅值7.5
// 「小五」对应磅值9
// 「五号」对应磅值10.5
// 「小四」对应磅值12
// 「四号」对应磅值14
// 「小三」对应磅值15
// 「三号」对应磅值16
// 「小二」对应磅值18
// 「二号」对应磅值22
// 「小一」对应磅值24
// 「一号」对应磅值26
// 「小初」对应磅值36
// 「初号」对应磅值42

#set text(
 	font: globals.normal.font.name,
 	fallback: true, 
 	size: 14pt,
 	top-edge: "bounds",
 	bottom-edge: "bounds",
 	alternates: false,
 	weight: "light",
 )
#set text(fill: rgb( "#bfbdb6" ))

// 设计
// 正文: 段前 0 段后 10pt
// 正文文本: 段前 9pt 段后 9pt
// default block for whole doc
#set block(
	// inset: (top: 0.96 * 12pt, bottom: 0.96 * 12pt +10pt),
	spacing: 0em, // typst default 1.2em
	// above: 0.96*14pt, below: 0.96*14pt,
	//for testing
	// inset: (top: 0.96*14pt, bottom: 0.96*14pt),
    // fill: rgb("e6b450").darken(50%),
)


// 1. 将加粗和斜体字体，使用强调色

#show strong: it => {
	set text(
		fill: rgb( "aad94c" ).darken(15%) ,
		// fill: rgb( "aad94c") ,
		weight: "bold",
	)
	it
}

// 霞露文楷的字重只分: light/regular/bold，且效果不明显，没有斜体
#show emph: it => {
	set text(
		fill: rgb( "#e6b450" ).darken(15%),
		// fill: rgb("aad94c").lighten(10%),
		style: "italic",
		weight: "light",
	)
	underline()[#it]
}




// ALT PARAGRAPH STYLE, COMMENT PREV 6 LINES, and UNCOMMENT THESE:  
// #set par(
//    first-line-indent: 2em,
//    // hanging-indent: 2em,
//    // leading: 8pt, 
//    // justify: true,
//  )
// #set par(justify: false, leading: 1.5em, first-line-indent:2em )
#set par(first-line-indent: 2em,
    leading: 0.65em, // 行间距
    spacing: 1em, // 段间距
 ) 

// ⚠️ paragraphs as they are not considered blocks anymore


// solution 1:
// first-line-indent
// https://github.com/typst/typst/issues/311

#let indent_hack = it => {
        // show par: set block(spacing: 0em)
        // it; v(-1em); ""
        // // it
        // // [#v(0.05em, weak: true); ""]
        // // it;  parbreak()
        // it; parbreak()
        it
        v(0pt, weak: true); "" 
}

// #show heading: it => {
//     indent_hack(it)
//     v(0pt, weak: true); ""

// }
#show heading: indent_hack
#show list: indent_hack
#show enum: indent_hack
#show table: indent_hack
#show grid: indent_hack
#show rect: indent_hack
#show figure: indent_hack
#show terms: indent_hack
#show quote: indent_hack
#show math.equation.where(block: true): indent_hack
#show raw.where(block: true): indent_hack


// solution 2:

// #show: body => {
//   for (ie, elem) in body.children.enumerate() {
//     if elem.func() == text {
//       if ie > 0 and body.children.at(ie - 1).func() == parbreak {
//         h(2em)
//       }
//       elem
//     } else {
//       elem
//     }
//   }
// }

//  todo spacing
// list 


// HEADINGS
//
// spacing
// numbering
// font size/color/style


#set heading(numbering: "1.1.1.1.1.1.1.1.1.")
#show heading: set text(fill: rgb("#e6b450") )
#show heading: it => {
  it;parbreak();v(0.5* 14pt, weak: true)
}
#show heading.where( level: 1): it => {
  set text(size: 20pt)
  set block(above: 18pt, below: 4pt + 6pt) // default: 1.2 em
  it
  }
#show heading.where( level: 2): it => {
  set text(size: 16pt)
  set block(above: 8pt + 9pt, below: 4pt + 6pt)
  it
}
#show heading.where( level: 3): it => {
  set text(size: 1em)
  set block(above: 8pt + 9pt, below: 4pt + 6pt)
  it
}
#show heading.where( level: 4): it => {
  set text(size: 1em)
  set block(above: 2pt + 9pt, below: 1pt + 6pt)
  it
}
#show heading.where( level: 5): it => {
  set text(size: 1em)
  set block(above: 2pt + 9pt, below: 1pt + 6pt)
  it
}
#show heading.where( level: 6): it => {
  set text(size: 1em)
  set block(above: 1pt + 9pt, below: 0pt + 6pt)
  it
}

#show heading.where( level: 7): it => {
  set text(size: 1em)
  set block(above: 1pt + 9pt, below: 0pt + 6pt)
  it
}

#show heading.where( level: 8): it => {
  set text(size: 1em)
  set block(above: 1pt + 9pt, below: 0pt + 6pt)
  it
}

#show heading.where( level: 9): it => {
  set text(size: 1em)
  set block(above: 1pt + 9pt, below: 0pt + 6pt)
  it
}
// // HEADINGS
// //
//   show heading: set text(hyphenate: false)

//   show heading.where(level: 1
//     ):  it => align(center, block(above:0pt, below: 18pt, width: 100% )[
//         #v(72pt) // space above on new pages
//         #set par(leading: 12pt)
//         #set text(weight: "regular", style: "normal", size: 20pt)
//         #block(it.body) 
//       ])
//   // Pagebreak whenever we get a first-level heading:    
//      show heading.where(level: 1): it => { colbreak(weak: true); it }
    
//   show heading.where(level: 2
//     ): it => align(center, block(above: 36pt, below: 18pt, width: 80%)[
//         #set text(weight: "regular", size: 14pt)
//         #block(it.body) 
//       ])

//   show heading.where(level: 3
//     ): it => align(center, block(above: 12pt, below: 12pt)[
//         #set text(weight: "regular" , size: 11pt, tracking: 0.5pt)
//         #block(smallcaps[#it.body]) 
//       ])

//   show heading.where(level: 4   // Right-justified attributions
//     ): it => align(right, block(above: 7pt, below: 7pt, )[
//         #set text(weight: "regular", size: 11pt)
//         #block(it.body) 
//       ])



// Block quotations
// typst: 0.12
// default: 
// 1. font: italic, auto indent
// 2. block: pad(left: 1rem, right: 1rem)
#set quote(block: true)
// #show quote: set pad (x: 2em)   // L&R margins
// // #show quote: set pad(left: 2em)   // L&R margins
// #show quote: set par(leading: 8pt)
// #show quote: set text(style: "italic")

#show quote: it => {

  // set pad(left: 2em)
  // indent: 2em of body text
  // set pad(left: 2 * 12pt) 
  // v(-1em)

  /////////////////
  // typst 0.12 Quote
  // Quote come with body block within quote block
  // put a stylic rect as container for background and border custemizatioi
  show box: set pad(left: 2 * 14pt, right: 0pt)
  set text(
    size: 12em/14,
    fill:  rgb("#bfbdb6"),
    style: "italic", // 五号
  ) 
  let block-content=box.with(
    fill: rgb("#10141c").lighten(4%),
    width: 100%,
    radius: 4pt,
    inset: (left: 4pt + 9pt, rest: 9pt),  // inset on left side plus stork width 
    outset: (left: -2 * 14pt, rest: 0pt), // negative out set aglin quote's left padding
    stroke: (left: 4pt + rgb("e6b450")),
    )
  block-content(it)


  // layout 函数，让 paragraph.typst 对 quote 设置的 缩进不产生作用
  // 除非设置在 layout 之后，也即是本函数之后
  // v(0.3em, weak: true); "" 
}

// textmate theme file
#set raw(theme: globals.codeblock.theme.path)

// https://typst.app/docs/reference/text/raw/
// Display inline code in a small box
// that retains the correct baseline.
// #show raw.where(block: false): box.with(
//   // fill: luma(240),
//   fill: rgb("#1d2433"),
//   inset: (x: 3pt, y: 0pt),
//   outset: (y: 3pt),
//   radius: 2pt,
// )

#show raw.where(block: false): it => box(
  // fill: luma(240),
  fill: rgb( code-highlight.background ),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
  text(
    // font: globals.codeblock.font.name ,
    fallback: true,
    fill: rgb( code-highlight.foreground ),
    size: 12em/14,
    it)
)

// Display block code in a larger block
// with more padding.
#show raw.where(block: true): it => {
  // incase text line too long
  // 当示例代码中的行过长时，`+`、`-`、`英文字母也可折行`
  // typst 默认按单词、中西文、空格自动折行，`+`、`-` 均被视为连接符
  // sym.zws (the Unicode Zero Width Space) 
  // error: maximum grouping depth exceeded
  // show regex("[\w\+_]"): it => it + sym.zws
  show regex("[\+_\-]"): it => it + sym.zws

  set text(
    // font: globals.codeblock.font.name,
    fallback: true ,
    // when no syntax
    fill: rgb( code-highlight.foreground ),
    size: 12em/14,
  )
  set block(
    width: 100%,
    fill: rgb( code-highlight.background ),
    inset: 9pt,
    radius: 4pt,
    // above: 0pt, below: 0pt
    spacing: 1em,
  )
  it
}


// // Code snippets:
// //
//   show raw: set block(inset: (left: 2em, top: 0.5em, right: 1em, bottom: 0.5em ))
//   show raw: set text(fill: rgb("#116611"), size: 9pt) //green


// Term List

// term:
// description: spacing: below 10pt

#set terms(spacing: 1em)

#show terms: it => {
	set block(above: 1em, below: 1em, inset: (top: 0pt, bottom: 0pt))
	it
}

#show link: underline.with(stroke: gradient.linear(..color.map.rainbow))
#show link: set text(fill: rgb("95e6cb"))

// //
// caption
// 1. common caption
// 2. figure caption
// 3. table caption

// // 
// caption
// caption is not standalone.
// only some rule below to follow
// * aligment: center
// * font size: 10.5pt
// * font style: normal
// * spacing: (above: 0,below: 6pt)

// //
// figure caption
//
// figure caption customized in file figure.typst


// //
// table caption
// table with caption should be putted into figure
// https://typst.app/docs/reference/model/table/



// [normaltable]
// id = "TableNormal"
// name = "Normal Table"
// halign = "left"
// # 200/0.28 厘米，wps 中正好与正文对齐
// indent = 'w:w="200"'
// border.left = 'w:val="none" w:color="auto" w:sz="0" w:space="0"'
// border.right = 'w:val="none" w:color="auto" w:sz="0" w:space="0"'
// border.top = 'w:val="single" w:color="1f2430" w:sz="12" w:space="0" '
// border.bottom = 'w:val="single" w:color="1f2430" w:sz="12" w:space="0"'
// border.insideh = 'w:val="single" w:color="1f2430" w:sz="4" w:space="0"'
// border.insidev = 'w:val="single" w:color="1f2430" w:sz="4" w:space="0"'

#let table_border_color = rgb( globals.table.border.color )

#show table: it => {
    // set block(
    //     // fill: white.darken(40%), // for testing
    //     // inset: (top: 1em), // for spacing
    // )
	// set table(
    // 	// inset: 1.8pt + 0.5em,// won't work? setting table.cell(inset) instead
    //   	align: horizon,
	// )

	// ⚠️ if table wrap in a figure with block setting, inset will be effected? dnot know why
  	set table.cell(inset: (x: 1.8pt + 0.5em, y:1.8pt + 0.5em))
	// override table border setting
	// set table.cell(stroke: table_border_color + 0.5pt )

  	// header
  	// panodc has simple table feature that may not has header

  	let header = it.children.first()
  	let has_header = true
  	if header.func() != table.header {
    	has_header = false
  	}
  	/*
  	this won't work
	if has_header {
		show table.cell.where(y: 0): strong
	}
	it 
  	*/
  	if has_header {
  		show table.cell.where(y: 0): set align(horizon)
  		show table.cell.where(y: 0): strong
    	// has to do this
    	it
  	} else {
    	it
  	}
}

// table cell border
// ？下面的设置不能与上达的 #show table rule 合并成一个函数
 #show table: set table(
	align: horizon,
    stroke: (x, y) => { 
	    let hline = (bottom: 0.5pt + table_border_color)
	    if y == 0 {
	      hline = (top: 0.5pt + table_border_color, bottom: 1.25pt + table_border_color)
	    }
	    
	    let vline = (left: 0.5pt + table_border_color)
	    if x == 0 {
	      vline = none
	    } 
	    vline + hline
  }
)


// Images and figures:
//

// #set image(width: 5.25in, fit: "contain")
#set image(width: auto, fit: "contain")
#show image: it => {
  // use bottom inset for spacing
  // set block(
  //   above: 0pt, below: 0pt, inset: (top: 12pt, bottom: 0pt),
  //   fill: yellow.darken(80%),
  // )
  align(center, it)
}

#show figure.caption: it => {
  // use bottom inset for spacing
  // caption nolonger with block
  set box(
    // above: 0pt, below: 0pt, 
    inset: (top: 6pt, bottom: 6pt),
    // fill:  rgb("10141c").lighten(20%) // for testing
  )
  set text(
    size: 12em/14, // 五号
    style: "italic"
    ) 
  box(it)
}


#set figure(
  gap: 0.5em,
  // supplement: none,
)
// #show figure: 

#show figure: it => {
  // use bottom inset for spacing
  let spacing_below = 0pt
  if  it.caption != none and it.caption != "" {
    spacing_below = 6pt // caption bottom inset
  } else {
    spacing_below = 0pt // image bottom inset
  }
  // ⚠️ block  will effect table
  set block(above: 12pt, below: spacing_below,
    // inset: (top: 12pt, bottom: spacing_below),
    // fill: rgb("10141c").lighten(50%) // for testing
  )
  it
}
#show figure.where(
  kind: image
): it => {
  // let size = 2in
  let size = measure(it.body)
  let image_width = size.width

  if (page.width < 480pt) {
    // when small screen
    image_width = auto
  } else {

    if (image_width > 11cm ) {
      // image_width = page_width * 0.7
      image_width = 11cm
     
    }
  }


  set image(width: image_width , fit: "contain")
  it

}


// https://github.com/typst/typst/issues/1057#issuecomment-1895569178
// // Set appropriate rules for heading
// #set heading(numbering: "1.")
// // Separator between first level heading and figure
// // number (for example Figure 1.1)
// #let sep = ".";
// // Making " — " as a separator between type of the caption and
// // caption itself (for example: Table 1 — Some table)
// #set figure.caption(separator: " — ");

// // This code update figure counter after all first level heading
// #show heading: head => {
//     if head.level == 1 {
//         counter(figure.where(kind: table)).update(0);
//         counter(figure.where(kind: image)).update(0);
//     }
//     head
// }

// // Figure function try to place whole table into
// // one page, so this #show command fix it
// #show figure.where(kind: table): fig => {
//     align(left, strong(fig.caption))
//     align(left, fig.body)
// }

// // This code update figure.caption printing
// #show figure.caption: cap => {
//     let head_num = locate(loc => {
//         // Find heading number
//         let num = counter(heading).at(loc).first();
//         // Find numbering pattern
//         let pattern = query(
//             selector(heading.where(level: 1)).before(loc),
//             loc,
//         ).last()
//          .numbering;
//         // Fix number accoding to the pattern with removing last
//         // char if necessary (for example if pattern is "1.")
//         numbering(pattern, num).trim(regex("\W|_"), at: end)
//     });
//     // Fix figure number accoding to the pattern with removing last
//     // char if necessary (for example if pattern is "1.")
//     let fig_num = locate(loc => {
//         numbering(cap.numbering, cap.counter.at(loc).first())
//             .trim(regex("\W|_"), at: end)
//     });
//     let c = cap.supplement + " " + head_num + sep + fig_num + cap.separator + cap.body;
//     [#c]
// }


// // This code update reference printing
// #show ref: it => {
//     let el = it.element
//     if el != none and el.func() == figure {
//         let loc = el.location();
//         // Find heading number
//         let head_num = counter(heading).at(loc).first();
//         // Find numbering pattern
//         let pattern = query(
//             selector(heading.where(level: 1)).before(loc),
//             loc,
//         ).last()
//          .numbering;
//         // Fix head number accoding to the pattern with removing last
//         // char if necessary (for example if pattern is "1.")
//         let head_num = numbering(pattern, head_num)
//             .trim(regex("\W|_"), at: end);
//         // Fix figure number accoding to the pattern with removing last
//         // char if necessary (for example if pattern is "1.")
//         let fig_num = numbering(el.numbering, el.counter.at(loc).first())
//             .trim(regex("\W|_"), at: end);
//         // Make a link with checking if we have customized supplement
//         // or not
//         if it.citation.supplement != none {
//             link(loc, [#it.citation.supplement #head_num#sep#fig_num])
//         } else {
//             link(loc, [#el.supplement #head_num#sep#fig_num])
//         }
//     } else {
//         // Other references as usual.
//         it
//     }
// }



// only indent the whole ordered list /numbered list block
// not the children list
#set enum(indent: 2em)
// when enum centered, the enum item still left-aglined
#show enum.item: set align(left)
#show enum: it => {
  set block(above: 1em)
  set list(indent: 0em)
  set enum(indent: 0em)
  it
}
#set list(indent: 2em)
// when list centered, the enum item still left-aglined
#show list.item: set align(left)
#show list: it => {
  set block(above: 1em)

  set list(indent: 0em)
  set enum(indent: 0em)
  it
}

// 在表格中，列表不缩进
#show table: set list(indent: 0em)
#show table: set enum(indent: 0em)

// 在 terms 中，若只有列表，则不缩进

#let noother_elements_except_list_or_enum(children) = {
  let ret = true
  for (idx, ele) in children.enumerate() {
    if ele.func() not in (([ ]).func(), enum.item, list.item, parbreak, linebreak) {
      ret = false
      break
    }
  }
  ret
}

#show terms.item: it => {

  let is_only_list_or_enum = noother_elements_except_list_or_enum(it.description.body.fields().children)
  
  if is_only_list_or_enum == true {
    set enum(indent: 0em)
    set list(indent: 0em)
    it
  } else {
    it
  }
}
#show quote: it => {
  let is_only_list_or_enum = noother_elements_except_list_or_enum(it.body.children)

  if is_only_list_or_enum == true {
    set enum(indent: 0em)
    set list(indent: 0em)
    it
  } else {
    it
  }
}


// blocktext.indent = 'w:firstLine="0" w:left="480" w:right="480"'
// Footnote formatting
//
#set footnote.entry(
    indent: 0em,
    gap: 10pt,
    separator: line(length: 30%, stroke:0.5pt + rgb("#bfbdb6")),
)

#show footnote.entry: set text(
  size: 12pt, 
  weight: 200,
)


#show math.equation: it => {
  set text(
	// font: globals.math.font.name,
	size: 1em, 
	style: "italic",
	fallback: true, 
	alternates: false)

  set block(
    // fill: yellow.darken(40%), // for testing
    inset: (top: 1em),
    breakable: true
  )
  it
}


#let alerts = (
  // github alerts
  // https://docs.github.com/zh/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts
  "Note": (icon: "📝", color: rgb("e6b450")),
  "Tip": (icon: "ℹ️", color: rgb("c2d94c")),
  "Important": (icon: "❗️", color: rgb("39bae6")),
  "Warning": (icon: "⚠️", color: rgb("ff8f40")),
  "Caution": (icon: "🚧", color: rgb("f07178")),

  // typst gentel-clues
  // https://github.com/jomaway/typst-gentle-clues
  // Idea,Abstract,Question,Info
  // Example, Experiment, Task, Error,
  // Warning, Success, Tip, Conclusion,
  // Memorize, Ouote, Goal, Notification,
  // Code,Danger

  "Idea": (icon: "💡", color: rgb("39bae6")),
  "Error": (icon: "❌", color: rgb("ff3333")),
  "Success": (icon: "✅", color: rgb("c2d94c")),
  "Goal": (icon: "🏁", color: rgb("95e6cb")),
  "Notification": (icon: "📣", color: rgb("39bae6")),

)
#let alert-bag = block.with(
  stroke: 0pt,
  fill: rgb("e6b450"),
  outset: 0pt,
  spacing: 0pt,
  radius: (
    top-left: 4pt,
    bottom-left: 0pt,
    top-right: 5%,
    bottom-right: 100%,
),
)
// noother_elements_except_list_or_enum 在 list.typst 中有定义
// #let noother_elements_except_list_or_enum(children) = {
//   let ret = true
//   for (idx, ele) in children.enumerate() {
//     if ele.func() not in (([ ]).func(), enum.item, list.item, parbreak, linebreak) {
//       ret = false
//       break
//     }
//   }
//   ret
// }
#let callout(title: "Callout", title-color: white, body-color: white, icon: none, body) = {
    // Header Part
    let title_font_color = rgb("10141c")
    let title_font_size = 12em/14
    let content_font_size = 12em/14 // same as blockquote
    let alert_type = alerts.at(title, default: (icon: "😊"))
    let title_icon = alert_type.at("icon", default: "📝")
    let alert_color = alert_type.at("color", default: rgb("e6b450")) //.lighten(30%) //.opacify(-40%)

    let header-block = alert-bag(     
            fill: alert_color,
            inset: 4pt,
    )[
      #text(weight: "bold", size: title_font_size, fill: title_font_color)[#title_icon #title]
    ]
  // Content-Box

    let is_only_list_or_enum = noother_elements_except_list_or_enum(body.children)
    let content-block= block(
      breakable: true,
      width: 100%,
      // fill: body-color,
      spacing: 0pt,
      outset: 0pt,
      inset: 8pt,
      // radius: (
      //   top-left: 0pt,
      //   bottom-left: 0pt,
      //   top-right: 5pt,
      //   rest: 2pt
      // ),
      above: 0pt,
      // stroke: 1pt + rgb("e6b450"),
    )[ 
        #if is_only_list_or_enum {
          set enum(indent: 0em)
          set list(indent: 0em)
          text(size: content_font_size, body)
        } else {
          text(size: content_font_size, body)
        }
        // is_only_list_or_enum = #is_only_list_or_enum
    ]

    box(
      width: 100%,
      // fill: none,
      stroke: 0.5pt + alert_color,
      radius: 4pt,
      inset: 0pt,
    )[  #header-block  #content-block ]

  // styled(child: sequence())
  // block(
  //   // fill: fill,
  //   width: 100%,
  //   inset: 8pt,
  //   )[
  //     #text(title-color)[#icon #title]
  //     #linebreak()
  //     #text(body-color)[
  //       #body
  //     ]
  //   ]

  // block(title)
  // block(body)
  // block()
  // block(fill: fill)[ #title, #linebreak()
  //  #box(body), #parbreak()
  // ]
}
#let title-case(somestring: "") = {
  lower(somestring).replace(regex("^\w"), m=>{
    // repr(m)
    upper(m.text)
  }, count: 1)
}
#show block: bl => {

  if bl.body == auto {
    
    return bl
  }

  let is_alert = false
  let content_body = ();
  let title_block = block();

  // title block in block
  // bl.body
  // alert/callout: block(block(title), content)
  // title block: child[1] = block(body: sequence([ ], [TITLE], parbreak()))

  if bl.body == none or bl.body.func() == text {
    return bl.body
  }

  // styled(child: sequence()) when block(...)[
  //   = ...
  // ]
  if bl.body.has("children") == false {
    return bl
  }

  // 
  let title_block = bl.body.children.at(1)
  if title_block.func() == block{
    // todo, maybe not robust, body.children?
    let title = title_block.body.children.at(1)

    // real part of alerts
    if upper(title.text) in alerts.keys().map(upper) {
      is_alert = true
      // content body start from 2 to the end of bl.body.children
      // let content_body = bl.body.children.slice(2)
      let content_body = bl.body.children.slice(2)
      // [#title, #content_body]
      // callout(content_body)
      // 
      // return [callout, #title, #content]

      return callout(title: title-case(somestring: title.text), content_body.join())
    } 
  }

  // other block
  if is_alert == false {
    bl
  }
}

// extentent github alerts
// and fix pandoc markdown/markdown_mmd
// gitub alerts: note, tip, Important, Warning, Caution
// extra: idea, error, Success, goal, Notification
/*
pandoc -fgfm github alert to typst:
```
#block[
#block[
Note

]
This note format from pandoc
]
```

pandoc -fmarkdown+hard_line_breaks to typst:
```
#quote(block: true)[
\[!idea\] \
This is idea
]
```

pandoc -fmarkdown to typst:
```
#quote(block: true)[
\[!idea\] This is idea
]
```
*/

// https://github.com/typst/typst/issues/2196#issuecomment-1728135476
#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}
#show quote.where(block: true): it => {
  let children = it.body.children
  let title = ""
  if children.len() > 4 {
    title = to-string(children.slice(0, count: 4).join())
  }
  // check callout
  // [#capture]
  let capture = title.match(regex("\[!(\w+)\]"))
  // [capture: #capture]
  if capture != none {
    let left = children.slice(4)
    if left.at(0) == [ ] {
      left = left.slice(1)
    }
    if left.at(0) == linebreak() {
      left = left.slice(1)
    }
    // [#capture, #title, #children.slice(7), #left]
    [#block[
      #block[
        #capture.captures.join()
      ]
      #left.join()
      ]
      ]
  } else {
    it
  }
}


// orginal: pandoc template.typst
// ============================================

// HERE'S THE DOCUMENT LAYOUT

#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}


#let title_rule(
  title: none,
  subtitle: none,
) = {
// name = "Title"
// spacing = 'w:after="80" w:line="240" w:lineRule="auto"'
// halign = "center"
// font.size = 56/20pt
// text tracking -0.02cm
  if title != none {
    align(center)[
      #block(
        inset: (top: 1.44 * 14pt, bottom: 1.44 * 14pt),
        // height: 1em,
        below: 4pt,
        above: 0pt,
      )[
        #text(weight: "medium",
         size: 24pt,
         tracking: -0.02cm,
         fill: rgb("#e6b450") 
        )[#title]
        #(if subtitle != none {
          // font.size = 28
          // text.tracking 0.03cm
          parbreak()
          text(
            weight: "medium",
            size: 1em,
            tracking: 0.03cm,
          )[#subtitle]
        })
      ]]
  }
}

#let authors_rule(
  authors: (),
) = {
  // font: based on body text
  // align: center
  // set block(
  //   above: 0pt, below: 10pt
  // )
  if authors != none and authors != () {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      // row-gutter: 1.5em,
      inset: 1.8pt + 0.5em,
      align: center + horizon,
      ..authors.map(author => 
        align(center)[
            #if author.at("name", default: "") != "" {author.name; linebreak()}
            #if author.at("affiliation", default: "") != "" {author.affiliation ; linebreak()}
            #if author.at("email", default: "") != "" {author.email ; linebreak() }
        ]
      )
    )
  }
}

#let date_in_title_rule(
  date: none,
) = {
  // font: based on body text
  // align: center

  if date != none {
    align(center)[
      #block()[
        #date
      ]
    ]
  }
}
#let print_pagesize = () => {
  // context {
  //   [#(width: page.width, height: page.height, margin: page.margin)
  //   ]
  // }
}
#let ajust_paper = (paper: "a4", it) => {
  if paper != none {
    set page(paper: paper)
    it
  } else {
    it
  }
}
#let ajust_pagesize = (paper: "a4", pagesize: (:), it) => {
  if "width" in pagesize.keys() and "height" in pagesize.keys() {
  set page(width: pagesize.width, height: pagesize.height)
    it
    print_pagesize()
    return
  }
  if "width" in pagesize.keys() and "height" not in pagesize.keys() {
    set page(width: pagesize.width, )
    it
    print_pagesize()
    return
  }
  if "width" not in pagesize.keys() and "height" in pagesize.keys() {
    set page(height: pagesize.height, )
    it
    print_pagesize()
    return
  }
  if "width" not in pagesize.keys() and "height" not in pagesize.keys() {
    if paper != none {
      set page(paper: paper)
      it
      print_pagesize()
    } else {
      set page(width: 300pt, height: 650pt, )
      it
      print_pagesize()
    } 
    return
  }
}
#let whole_doc(
  title: none,
  subtitle: none,
  keywords: (),
  authors: (), // IF NOT IN YAML
  date: datetime.today().display(),  // IF NOT IN YAML
  abstract: none,
  cols: 1,
  // margin: (x: 1.25in, y: 1.25in),
  // paper: "us-letter",
  lang: "en",
  region: "US",
  paper: none,
  margin: (:),
  pagesize: (:),
  font: (),
  monofont: (),
  mathfont: (),
  fontsize: 14pt,
  sectionnumbering: none,
  pagenumbering: none,
  figurenumberingwithheadingnumbers: none,
  figuresupplement: auto,
  doc,
) = {

// Document Element settings

  // set document meta data
  // not rendered within the document
  set document(
    title: title,
    author: authors.map(author => content-to-string(author.name)),
    keywords: keywords,
    // date: date
  )


  // front matter arguments overwrite 
  let auto_height = if "height" in pagesize.keys() and pagesize.height == auto { true } else {false}

  // outline rules
  // when page auto height, hides outline
  set outline(indent: 1em)
  show outline: it => {
    show outline.entry: e => {
      if e.level == 1 {
          v(1em, weak: true)
          set text(1.1em)
          e
        } else {
          set text(0.9em)
          e
        } 
    }

    if not auto_height {
      it
      [
        #pagebreak(weak: true)
        <before-body>
      ]
      counter(page).update(1)
    }
  }
  let disable_page_numbering = {
    pagenumbering in ( "disable", "none")
  }
  set page(
    // when page auto height, no page number
    // // ignored when explicit footer
    // numbering: if auto_height { none } else { pagenumbering },
    footer: context {
      if not auto_height and not disable_page_numbering{
        // if has outline, no page number before body
        // body begin when lable <before-body>
        let loc = selector(<before-body>).after(here())
        let list=  query(loc)
        if list == () {
          show text: set text(style: "italic")
          if pagenumbering != none {align(right)[#counter(page).display(pagenumbering)]}
        }
      }
    },
    footer-descent: 0em,
    // naess of authors and date in page1 header if no title
    header: context {
      let loc = here()
      // in header 
      // doesn't get number `1` again even counter(page).update(1)
      if loc.page() == 1 and title == none{
        let names = authors.map(author=> author.name).join(",")

        show text: set text(style: "italic", size: 0.8em)
        align(right)[
          #if names != none { names + "  " }  #date
        ]
      }
    },
    header-ascent: 0em,
    margin: margin,
    columns: cols,
    )
  show: it => ajust_paper(paper: paper, it)
  show: it => ajust_pagesize(paper: paper, pagesize: pagesize, it)
  // context {
  //   [#(width: page.width, height: page.height, margin: page.margin)]
  // }
  // set par()
  
  // frontmatter: fonts
  set text(
    lang: lang, region: region,
    font: font + globals.normal.font.name,
    size: fontsize
    )
  show raw: set text(font: monofont + globals.codeblock.font.name)
  show math.equation: set text(font: mathfont + globals.math.font.name)

  // frontmatter: heading
  let disable_heading_numbering = {
    sectionnumbering in ( "disable", "none")
  }
  set heading(
    numbering: if disable_heading_numbering {none} else {sectionnumbering },
    hanging-indent: if disable_heading_numbering { 1pt } else {auto},
  )

  // settings figure caption
  show heading: it => {
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: raw)).update(0)
      counter(figure.where(kind: image)).update(0)
    it
  }
  // disable figure supplement when frontmatter `figure.supplement: disable or none`
  set figure(supplement: figuresupplement)
  set figure(numbering: nums => {
    if figuresupplement == none {return} 
    // when disable_heading_numbering is false, 
    // figure numbering come with heading numbers, by condition below:
    // 1. explicit  `figurenumberingwithheadingnumbers` is `true` or, 
    // 2. figurenumberingwithheadingnumbers is none and globals.figure.numbering.heading_nums is `true`
    let condition = (figurenumberingwithheadingnumbers == true or figurenumberingwithheadingnumbers == none and globals.figure.numbering.heading_numbers == true) and disable_heading_numbering == false
    
    if condition == true {
      let heading_nums = counter(heading).display().trim(regex("\W|_"), at: end)
      [#heading_nums - #nums]
    } else {
      nums
    }
  })

  title_rule(title: title, subtitle: subtitle)
  if title != none { 
    authors_rule(authors: authors)
    date_in_title_rule(date: date) 
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }
  
  // THIS IS THE ACTUAL BODY:

  v(0.3em, weak: true); "" 

  doc
}




#show figure.where(
  kind: table
): set figure.caption(position: $if(table-caption-position)$$table-caption-position$$else$top$endif$)

#show figure.where(
  kind: image
): set figure.caption(position: $if(figure-caption-position)$$figure-caption-position$$else$bottom$endif$)

$if(smartquote)$
$else$
#set smartquote(enabled: false)

$endif$
$for(header-includes)$
$header-includes$

$endfor$
// `whole_doc` definded in document.typst

#show: doc => whole_doc(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
// authors
$if(author)$
  authors: (
$for(author)$
$if(author.name)$
    ( name: [$author.name$],
      affiliation: [$author.affiliation$],
      email: [$author.email$] ),
$else$
    ( name: [$author$],
      affiliation: "",
      email: "" ),
$endif$
$endfor$
    ),
$endif$
// keywords, date, abstract
$if(keywords)$
  keywords: ($for(keywords)$"$keywords$",$endfor$),
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(papersize)$
  paper: "$papersize$",
$endif$
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(pagesize)$
  pagesize: ($for(pagesize/pairs)$$pagesize.key$: $pagesize.value$,$endfor$),
$endif$
$if(mainfont)$
  font: (
$for(mainfont)$
    "$mainfont$",
$endfor$
    ),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(monofont)$
  monofont: (
$for(monofont)$
    "$monofont$",
$endfor$
    ),
$endif$
$if(mathfont)$
  mathfont: (
$for(mathfont)$
    "$mathfont$",
$endfor$
    ),
$endif$
  sectionnumbering: $if(section-numbering)$"$section-numbering$"$else$"1.1.1.1.1.1.1.1.1."$endif$,
  pagenumbering: $if(page-numbering)$"$page-numbering$"$else$none$endif$,
  figurenumberingwithheadingnumbers: $if(figure.numbering.heading_numbers)$true$else$if "$figure.numbering.heading_numbers$" in ("none", "disable") { false }$endif$,
$if(figure.supplement)$
  figuresupplement: if "$figure.supplement$" in ("disable", "none") { none } else { auto },
$endif$
  cols: $if(columns)$$columns$$else$1$endif$,
  doc,
)

$for(include-before)$
$include-before$

$endfor$
$if(toc)$
// outline will hiden when page height is auto
#outline(
$if(toc-title)$
  title: if "$toc-title$" == "none" { none } else { "$toc-title$" },
$else$
  title: auto,
$endif$
  depth: $toc-depth$
);
$endif$

$body$

$if(citations)$
$if(csl)$

#set bibliography(style: "$csl$")
$elseif(bibliographystyle)$

#set bibliography(style: "$bibliographystyle$")
$endif$
$if(bibliography)$

#bibliography($for(bibliography)$"$bibliography$"$sep$,$endfor$)
$endif$
$endif$
$for(include-after)$

$include-after$
$endfor$