" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='woohoo'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:woohoo_bold')
  let g:woohoo_bold=1
endif
if !exists('g:woohoo_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:woohoo_italic=1
  else
    let g:woohoo_italic=0
  endif
endif
if !exists('g:woohoo_undercurl')
  let g:woohoo_undercurl=1
endif
if !exists('g:woohoo_underline')
  let g:woohoo_underline=1
endif
if !exists('g:woohoo_inverse')
  let g:woohoo_inverse=1
endif

if !exists('g:woohoo_guisp_fallback') || index(['fg', 'bg'], g:woohoo_guisp_fallback) == -1
  let g:woohoo_guisp_fallback='NONE'
endif

if !exists('g:woohoo_improved_strings')
  let g:woohoo_improved_strings=0
endif

if !exists('g:woohoo_improved_warnings')
  let g:woohoo_improved_warnings=0
endif

if !exists('g:woohoo_termcolors')
  let g:woohoo_termcolors=256
endif

if !exists('g:woohoo_invert_indent_guides')
  let g:woohoo_invert_indent_guides=0
endif

if exists('g:woohoo_contrast')
  echo 'g:woohoo_contrast is deprecated; use g:woohoo_contrast_light and g:woohoo_contrast_dark instead'
endif

if !exists('g:woohoo_contrast_dark')
  let g:woohoo_contrast_dark='medium'
endif

if !exists('g:woohoo_contrast_light')
  let g:woohoo_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
let s:gb.dark0       = ['#282828', 235]     " 40-40-40
let s:gb.dark0_soft  = ['#32302f', 236]     " 50-48-47
let s:gb.dark1       = ['#3c3836', 237]     " 60-56-54
let s:gb.dark2       = ['#504945', 239]     " 80-73-69
let s:gb.dark3       = ['#665c54', 241]     " 102-92-84
let s:gb.dark4       = ['#7c6f64', 243]     " 124-111-100
let s:gb.dark4_256   = ['#7c6f64', 243]     " 124-111-100

let s:gb.gray_245    = ['#928374', 245]     " 146-131-116
let s:gb.gray_244    = ['#928374', 244]     " 146-131-116

let s:gb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
let s:gb.light0      = ['#fbf1c7', 229]     " 253-244-193
let s:gb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
let s:gb.light1      = ['#ebdbb2', 223]     " 235-219-178
let s:gb.light2      = ['#d5c4a1', 250]     " 213-196-161
let s:gb.light3      = ['#bdae93', 248]     " 189-174-147
let s:gb.light4      = ['#a89984', 246]     " 168-153-132
let s:gb.light4_256  = ['#a89984', 246]     " 168-153-132

let s:gb.bright_red     = ['#fb4934', 167]     " 251-73-52
let s:gb.bright_green   = ['#b8bb26', 142]     " 184-187-38
let s:gb.bright_yellow  = ['#fabd2f', 214]     " 250-189-47
let s:gb.bright_blue    = ['#83a598', 109]     " 131-165-152
let s:gb.bright_purple  = ['#d3869b', 175]     " 211-134-155
let s:gb.bright_aqua    = ['#8ec07c', 108]     " 142-192-124
let s:gb.bright_orange  = ['#fe8019', 208]     " 254-128-25

let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#458588', 66]      " 69-133-136
let s:gb.neutral_purple = ['#b16286', 132]     " 177-98-134
let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:gb.faded_blue     = ['#076678', 24]      " 7-102-120
let s:gb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:woohoo_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:woohoo_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:woohoo_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:woohoo_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:woohoo_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:woohoo_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:woohoo_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:woohoo_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:woohoo_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:woohoo_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:woohoo_hls_cursor')
  let s:hls_cursor = get(s:gb, g:woohoo_hls_cursor)
endif

let s:number_column = s:none
if exists('g:woohoo_number_column')
  let s:number_column = get(s:gb, g:woohoo_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:woohoo_sign_column')
    let s:sign_column = get(s:gb, g:woohoo_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:woohoo_color_column')
  let s:color_column = get(s:gb, g:woohoo_color_column)
endif

let s:vert_split = s:bg0
if exists('g:woohoo_vert_split')
  let s:vert_split = get(s:gb, g:woohoo_vert_split)
endif

let s:invert_signs = ''
if exists('g:woohoo_invert_signs')
  if g:woohoo_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:woohoo_invert_selection')
  if g:woohoo_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:woohoo_invert_tabline')
  if g:woohoo_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:woohoo_italicize_comments')
  if g:woohoo_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:woohoo_italicize_strings')
  if g:woohoo_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:woohoo_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:woohoo_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Woohoo Hi Groups: {{{

" memoize common hi groups
call s:HL('WoohooFg0', s:fg0)
call s:HL('WoohooFg1', s:fg1)
call s:HL('WoohooFg2', s:fg2)
call s:HL('WoohooFg3', s:fg3)
call s:HL('WoohooFg4', s:fg4)
call s:HL('WoohooGray', s:gray)
call s:HL('WoohooBg0', s:bg0)
call s:HL('WoohooBg1', s:bg1)
call s:HL('WoohooBg2', s:bg2)
call s:HL('WoohooBg3', s:bg3)
call s:HL('WoohooBg4', s:bg4)

call s:HL('WoohooRed', s:red)
call s:HL('WoohooRedBold', s:red, s:none, s:bold)
call s:HL('WoohooGreen', s:green)
call s:HL('WoohooGreenBold', s:green, s:none, s:bold)
call s:HL('WoohooYellow', s:yellow)
call s:HL('WoohooYellowBold', s:yellow, s:none, s:bold)
call s:HL('WoohooBlue', s:blue)
call s:HL('WoohooBlueBold', s:blue, s:none, s:bold)
call s:HL('WoohooPurple', s:purple)
call s:HL('WoohooPurpleBold', s:purple, s:none, s:bold)
call s:HL('WoohooAqua', s:aqua)
call s:HL('WoohooAquaBold', s:aqua, s:none, s:bold)
call s:HL('WoohooOrange', s:orange)
call s:HL('WoohooOrangeBold', s:orange, s:none, s:bold)

call s:HL('WoohooRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('WoohooGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('WoohooYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('WoohooBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('WoohooPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('WoohooAquaSign', s:aqua, s:sign_column, s:invert_signs)
call s:HL('WoohooOrangeSign', s:orange, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText WoohooBg2
hi! link SpecialKey WoohooBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory WoohooGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title WoohooGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg WoohooYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg WoohooYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question WoohooOrangeBold
" Warning messages
hi! link WarningMsg WoohooRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:woohoo_improved_strings == 0
  hi! link Special WoohooOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement WoohooRed
" if, then, else, endif, swicth, etc.
hi! link Conditional WoohooRed
" for, do, while, etc.
hi! link Repeat WoohooRed
" case, default, etc.
hi! link Label WoohooRed
" try, catch, throw
hi! link Exception WoohooRed
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword WoohooRed

" Variable name
hi! link Identifier WoohooBlue
" Function name
hi! link Function WoohooGreenBold

" Generic preprocessor
hi! link PreProc WoohooAqua
" Preprocessor #include
hi! link Include WoohooAqua
" Preprocessor #define
hi! link Define WoohooAqua
" Same as Define
hi! link Macro WoohooAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit WoohooAqua

" Generic constant
hi! link Constant WoohooPurple
" Character constant: 'c', '/n'
hi! link Character WoohooPurple
" String constant: "this is a string"
if g:woohoo_improved_strings == 0
  call s:HL('String',  s:green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean WoohooPurple
" Number constant: 234, 0xff
hi! link Number WoohooPurple
" Floating point constant: 2.3e10
hi! link Float WoohooPurple

" Generic type
hi! link Type WoohooYellow
" static, register, volatile, etc
hi! link StorageClass WoohooOrange
" struct, union, enum, etc.
hi! link Structure WoohooAqua
" typedef
hi! link Typedef WoohooYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:woohoo_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:woohoo_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd WoohooGreenSign
hi! link GitGutterChange WoohooAquaSign
hi! link GitGutterDelete WoohooRedSign
hi! link GitGutterChangeDelete WoohooAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile WoohooGreen
hi! link gitcommitDiscardedFile WoohooRed

" }}}
" Signify: {{{

hi! link SignifySignAdd WoohooGreenSign
hi! link SignifySignChange WoohooAquaSign
hi! link SignifySignDelete WoohooRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign WoohooRedSign
hi! link SyntasticWarningSign WoohooYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   WoohooBlueSign
hi! link SignatureMarkerText WoohooPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl WoohooBlueSign
hi! link ShowMarksHLu WoohooBlueSign
hi! link ShowMarksHLo WoohooBlueSign
hi! link ShowMarksHLm WoohooBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch WoohooYellow
hi! link CtrlPNoEntries WoohooRed
hi! link CtrlPPrtBase WoohooBg2
hi! link CtrlPPrtCursor WoohooBlue
hi! link CtrlPLinePre WoohooBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket WoohooFg3
hi! link StartifyFile WoohooFg1
hi! link StartifyNumber WoohooBlue
hi! link StartifyPath WoohooGray
hi! link StartifySlash WoohooGray
hi! link StartifySection WoohooYellow
hi! link StartifySpecial WoohooBg2
hi! link StartifyHeader WoohooOrange
hi! link StartifyFooter WoohooBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign WoohooRedSign
hi! link ALEWarningSign WoohooYellowSign
hi! link ALEInfoSign WoohooBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail WoohooAqua
hi! link DirvishArg WoohooYellow

" }}}
" Netrw: {{{

hi! link netrwDir WoohooAqua
hi! link netrwClassify WoohooAqua
hi! link netrwLink WoohooGray
hi! link netrwSymLink WoohooFg1
hi! link netrwExe WoohooYellow
hi! link netrwComment WoohooGray
hi! link netrwList WoohooBlue
hi! link netrwHelpCmd WoohooAqua
hi! link netrwCmdSep WoohooFg3
hi! link netrwVersion WoohooGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir WoohooAqua
hi! link NERDTreeDirSlash WoohooAqua

hi! link NERDTreeOpenable WoohooOrange
hi! link NERDTreeClosable WoohooOrange

hi! link NERDTreeFile WoohooFg1
hi! link NERDTreeExecFile WoohooYellow

hi! link NERDTreeUp WoohooGray
hi! link NERDTreeCWD WoohooGreen
hi! link NERDTreeHelp WoohooFg1

hi! link NERDTreeToggleOn WoohooGreen
hi! link NERDTreeToggleOff WoohooRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign WoohooRedSign
hi! link CocWarningSign WoohooOrangeSign
hi! link CocInfoSign WoohooYellowSign
hi! link CocHintSign WoohooBlueSign
hi! link CocErrorFloat WoohooRed
hi! link CocWarningFloat WoohooOrange
hi! link CocInfoFloat WoohooYellow
hi! link CocHintFloat WoohooBlue
hi! link CocDiagnosticsError WoohooRed
hi! link CocDiagnosticsWarning WoohooOrange
hi! link CocDiagnosticsInfo WoohooYellow
hi! link CocDiagnosticsHint WoohooBlue

hi! link CocSelectedText WoohooRed
hi! link CocCodeLens WoohooGray

call s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:red)
call s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:orange)
call s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:yellow)
call s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:blue)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded WoohooGreen
hi! link diffRemoved WoohooRed
hi! link diffChanged WoohooAqua

hi! link diffFile WoohooOrange
hi! link diffNewFile WoohooYellow

hi! link diffLine WoohooBlue

" }}}
" Html: {{{

hi! link htmlTag WoohooBlue
hi! link htmlEndTag WoohooBlue

hi! link htmlTagName WoohooAquaBold
hi! link htmlArg WoohooAqua

hi! link htmlScriptTag WoohooPurple
hi! link htmlTagN WoohooFg1
hi! link htmlSpecialTagName WoohooAquaBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar WoohooOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag WoohooBlue
hi! link xmlEndTag WoohooBlue
hi! link xmlTagName WoohooBlue
hi! link xmlEqual WoohooBlue
hi! link docbkKeyword WoohooAquaBold

hi! link xmlDocTypeDecl WoohooGray
hi! link xmlDocTypeKeyword WoohooPurple
hi! link xmlCdataStart WoohooGray
hi! link xmlCdataCdata WoohooPurple
hi! link dtdFunction WoohooGray
hi! link dtdTagName WoohooPurple

hi! link xmlAttrib WoohooAqua
hi! link xmlProcessingDelim WoohooGray
hi! link dtdParamEntityPunct WoohooGray
hi! link dtdParamEntityDPunct WoohooGray
hi! link xmlAttribPunct WoohooGray

hi! link xmlEntity WoohooOrange
hi! link xmlEntityPunct WoohooOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation WoohooOrange
hi! link vimBracket WoohooOrange
hi! link vimMapModKey WoohooOrange
hi! link vimFuncSID WoohooFg3
hi! link vimSetSep WoohooFg3
hi! link vimSep WoohooFg3
hi! link vimContinue WoohooFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword WoohooBlue
hi! link clojureCond WoohooOrange
hi! link clojureSpecial WoohooOrange
hi! link clojureDefine WoohooOrange

hi! link clojureFunc WoohooYellow
hi! link clojureRepeat WoohooYellow
hi! link clojureCharacter WoohooAqua
hi! link clojureStringEscape WoohooAqua
hi! link clojureException WoohooRed

hi! link clojureRegexp WoohooAqua
hi! link clojureRegexpEscape WoohooAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen WoohooFg3
hi! link clojureAnonArg WoohooYellow
hi! link clojureVariable WoohooBlue
hi! link clojureMacro WoohooOrange

hi! link clojureMeta WoohooYellow
hi! link clojureDeref WoohooYellow
hi! link clojureQuote WoohooYellow
hi! link clojureUnquote WoohooYellow

" }}}
" C: {{{

hi! link cOperator WoohooPurple
hi! link cStructure WoohooOrange

" }}}
" Python: {{{

hi! link pythonBuiltin WoohooOrange
hi! link pythonBuiltinObj WoohooOrange
hi! link pythonBuiltinFunc WoohooOrange
hi! link pythonFunction WoohooAqua
hi! link pythonDecorator WoohooRed
hi! link pythonInclude WoohooBlue
hi! link pythonImport WoohooBlue
hi! link pythonRun WoohooBlue
hi! link pythonCoding WoohooBlue
hi! link pythonOperator WoohooRed
hi! link pythonException WoohooRed
hi! link pythonExceptions WoohooPurple
hi! link pythonBoolean WoohooPurple
hi! link pythonDot WoohooFg3
hi! link pythonConditional WoohooRed
hi! link pythonRepeat WoohooRed
hi! link pythonDottedName WoohooGreenBold

" }}}
" CSS: {{{

hi! link cssBraces WoohooBlue
hi! link cssFunctionName WoohooYellow
hi! link cssIdentifier WoohooOrange
hi! link cssClassName WoohooGreen
hi! link cssColor WoohooBlue
hi! link cssSelectorOp WoohooBlue
hi! link cssSelectorOp2 WoohooBlue
hi! link cssImportant WoohooGreen
hi! link cssVendor WoohooFg1

hi! link cssTextProp WoohooAqua
hi! link cssAnimationProp WoohooAqua
hi! link cssUIProp WoohooYellow
hi! link cssTransformProp WoohooAqua
hi! link cssTransitionProp WoohooAqua
hi! link cssPrintProp WoohooAqua
hi! link cssPositioningProp WoohooYellow
hi! link cssBoxProp WoohooAqua
hi! link cssFontDescriptorProp WoohooAqua
hi! link cssFlexibleBoxProp WoohooAqua
hi! link cssBorderOutlineProp WoohooAqua
hi! link cssBackgroundProp WoohooAqua
hi! link cssMarginProp WoohooAqua
hi! link cssListProp WoohooAqua
hi! link cssTableProp WoohooAqua
hi! link cssFontProp WoohooAqua
hi! link cssPaddingProp WoohooAqua
hi! link cssDimensionProp WoohooAqua
hi! link cssRenderProp WoohooAqua
hi! link cssColorProp WoohooAqua
hi! link cssGeneratedContentProp WoohooAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces WoohooFg1
hi! link javaScriptFunction WoohooAqua
hi! link javaScriptIdentifier WoohooRed
hi! link javaScriptMember WoohooBlue
hi! link javaScriptNumber WoohooPurple
hi! link javaScriptNull WoohooPurple
hi! link javaScriptParens WoohooFg3

" }}}
" YAJS: {{{

hi! link javascriptImport WoohooAqua
hi! link javascriptExport WoohooAqua
hi! link javascriptClassKeyword WoohooAqua
hi! link javascriptClassExtends WoohooAqua
hi! link javascriptDefault WoohooAqua

hi! link javascriptClassName WoohooYellow
hi! link javascriptClassSuperName WoohooYellow
hi! link javascriptGlobal WoohooYellow

hi! link javascriptEndColons WoohooFg1
hi! link javascriptFuncArg WoohooFg1
hi! link javascriptGlobalMethod WoohooFg1
hi! link javascriptNodeGlobal WoohooFg1
hi! link javascriptBOMWindowProp WoohooFg1
hi! link javascriptArrayMethod WoohooFg1
hi! link javascriptArrayStaticMethod WoohooFg1
hi! link javascriptCacheMethod WoohooFg1
hi! link javascriptDateMethod WoohooFg1
hi! link javascriptMathStaticMethod WoohooFg1

" hi! link javascriptProp WoohooFg1
hi! link javascriptURLUtilsProp WoohooFg1
hi! link javascriptBOMNavigatorProp WoohooFg1
hi! link javascriptDOMDocMethod WoohooFg1
hi! link javascriptDOMDocProp WoohooFg1
hi! link javascriptBOMLocationMethod WoohooFg1
hi! link javascriptBOMWindowMethod WoohooFg1
hi! link javascriptStringMethod WoohooFg1

hi! link javascriptVariable WoohooOrange
" hi! link javascriptVariable WoohooRed
" hi! link javascriptIdentifier WoohooOrange
" hi! link javascriptClassSuper WoohooOrange
hi! link javascriptIdentifier WoohooOrange
hi! link javascriptClassSuper WoohooOrange

" hi! link javascriptFuncKeyword WoohooOrange
" hi! link javascriptAsyncFunc WoohooOrange
hi! link javascriptFuncKeyword WoohooAqua
hi! link javascriptAsyncFunc WoohooAqua
hi! link javascriptClassStatic WoohooOrange

hi! link javascriptOperator WoohooRed
hi! link javascriptForOperator WoohooRed
hi! link javascriptYield WoohooRed
hi! link javascriptExceptions WoohooRed
hi! link javascriptMessage WoohooRed

hi! link javascriptTemplateSB WoohooAqua
hi! link javascriptTemplateSubstitution WoohooFg1

" hi! link javascriptLabel WoohooBlue
" hi! link javascriptObjectLabel WoohooBlue
" hi! link javascriptPropertyName WoohooBlue
hi! link javascriptLabel WoohooFg1
hi! link javascriptObjectLabel WoohooFg1
hi! link javascriptPropertyName WoohooFg1

hi! link javascriptLogicSymbols WoohooFg1
hi! link javascriptArrowFunc WoohooYellow

hi! link javascriptDocParamName WoohooFg4
hi! link javascriptDocTags WoohooFg4
hi! link javascriptDocNotation WoohooFg4
hi! link javascriptDocParamType WoohooFg4
hi! link javascriptDocNamedParamType WoohooFg4

hi! link javascriptBrackets WoohooFg1
hi! link javascriptDOMElemAttrs WoohooFg1
hi! link javascriptDOMEventMethod WoohooFg1
hi! link javascriptDOMNodeMethod WoohooFg1
hi! link javascriptDOMStorageMethod WoohooFg1
hi! link javascriptHeadersMethod WoohooFg1

hi! link javascriptAsyncFuncKeyword WoohooRed
hi! link javascriptAwaitFuncKeyword WoohooRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword WoohooAqua
hi! link jsExtendsKeyword WoohooAqua
hi! link jsExportDefault WoohooAqua
hi! link jsTemplateBraces WoohooAqua
hi! link jsGlobalNodeObjects WoohooFg1
hi! link jsGlobalObjects WoohooFg1
hi! link jsFunction WoohooAqua
hi! link jsFuncParens WoohooFg3
hi! link jsParens WoohooFg3
hi! link jsNull WoohooPurple
hi! link jsUndefined WoohooPurple
hi! link jsClassDefinition WoohooYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved WoohooAqua
hi! link typeScriptLabel WoohooAqua
hi! link typeScriptFuncKeyword WoohooAqua
hi! link typeScriptIdentifier WoohooOrange
hi! link typeScriptBraces WoohooFg1
hi! link typeScriptEndColons WoohooFg1
hi! link typeScriptDOMObjects WoohooFg1
hi! link typeScriptAjaxMethods WoohooFg1
hi! link typeScriptLogicSymbols WoohooFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects WoohooFg1
hi! link typeScriptParens WoohooFg3
hi! link typeScriptOpSymbols WoohooFg3
hi! link typeScriptHtmlElemProperties WoohooFg1
hi! link typeScriptNull WoohooPurple
hi! link typeScriptInterpolationDelimiter WoohooAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword WoohooAqua
hi! link purescriptModuleName WoohooFg1
hi! link purescriptWhere WoohooAqua
hi! link purescriptDelimiter WoohooFg4
hi! link purescriptType WoohooFg1
hi! link purescriptImportKeyword WoohooAqua
hi! link purescriptHidingKeyword WoohooAqua
hi! link purescriptAsKeyword WoohooAqua
hi! link purescriptStructure WoohooAqua
hi! link purescriptOperator WoohooBlue

hi! link purescriptTypeVar WoohooFg1
hi! link purescriptConstructor WoohooFg1
hi! link purescriptFunction WoohooFg1
hi! link purescriptConditional WoohooOrange
hi! link purescriptBacktick WoohooOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp WoohooFg3
hi! link coffeeSpecialOp WoohooFg3
hi! link coffeeCurly WoohooOrange
hi! link coffeeParen WoohooFg3
hi! link coffeeBracket WoohooOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter WoohooGreen
hi! link rubyInterpolationDelimiter WoohooAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier WoohooRed
hi! link objcDirective WoohooBlue

" }}}
" Go: {{{

hi! link goDirective WoohooAqua
hi! link goConstants WoohooPurple
hi! link goDeclaration WoohooRed
hi! link goDeclType WoohooBlue
hi! link goBuiltins WoohooOrange

" }}}
" Lua: {{{

hi! link luaIn WoohooRed
hi! link luaFunction WoohooAqua
hi! link luaTable WoohooOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp WoohooFg3
hi! link moonExtendedOp WoohooFg3
hi! link moonFunction WoohooFg3
hi! link moonObject WoohooYellow

" }}}
" Java: {{{

hi! link javaAnnotation WoohooBlue
hi! link javaDocTags WoohooAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen WoohooFg3
hi! link javaParen1 WoohooFg3
hi! link javaParen2 WoohooFg3
hi! link javaParen3 WoohooFg3
hi! link javaParen4 WoohooFg3
hi! link javaParen5 WoohooFg3
hi! link javaOperator WoohooOrange

hi! link javaVarArg WoohooGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter WoohooGreen
hi! link elixirInterpolationDelimiter WoohooAqua

hi! link elixirModuleDeclaration WoohooYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition WoohooFg1
hi! link scalaCaseFollowing WoohooFg1
hi! link scalaCapitalWord WoohooFg1
hi! link scalaTypeExtension WoohooFg1

hi! link scalaKeyword WoohooRed
hi! link scalaKeywordModifier WoohooRed

hi! link scalaSpecial WoohooAqua
hi! link scalaOperator WoohooFg1

hi! link scalaTypeDeclaration WoohooYellow
hi! link scalaTypeTypePostDeclaration WoohooYellow

hi! link scalaInstanceDeclaration WoohooFg1
hi! link scalaInterpolation WoohooAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 WoohooGreenBold
hi! link markdownH2 WoohooGreenBold
hi! link markdownH3 WoohooYellowBold
hi! link markdownH4 WoohooYellowBold
hi! link markdownH5 WoohooYellow
hi! link markdownH6 WoohooYellow

hi! link markdownCode WoohooAqua
hi! link markdownCodeBlock WoohooAqua
hi! link markdownCodeDelimiter WoohooAqua

hi! link markdownBlockquote WoohooGray
hi! link markdownListMarker WoohooGray
hi! link markdownOrderedListMarker WoohooGray
hi! link markdownRule WoohooGray
hi! link markdownHeadingRule WoohooGray

hi! link markdownUrlDelimiter WoohooFg3
hi! link markdownLinkDelimiter WoohooFg3
hi! link markdownLinkTextDelimiter WoohooFg3

hi! link markdownHeadingDelimiter WoohooOrange
hi! link markdownUrl WoohooPurple
hi! link markdownUrlTitleDelimiter WoohooGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType WoohooYellow
" hi! link haskellOperators WoohooOrange
" hi! link haskellConditional WoohooAqua
" hi! link haskellLet WoohooOrange
"
hi! link haskellType WoohooFg1
hi! link haskellIdentifier WoohooFg1
hi! link haskellSeparator WoohooFg1
hi! link haskellDelimiter WoohooFg4
hi! link haskellOperators WoohooBlue
"
hi! link haskellBacktick WoohooOrange
hi! link haskellStatement WoohooOrange
hi! link haskellConditional WoohooOrange

hi! link haskellLet WoohooAqua
hi! link haskellDefault WoohooAqua
hi! link haskellWhere WoohooAqua
hi! link haskellBottom WoohooAqua
hi! link haskellBlockKeywords WoohooAqua
hi! link haskellImportKeywords WoohooAqua
hi! link haskellDeclKeyword WoohooAqua
hi! link haskellDeriving WoohooAqua
hi! link haskellAssocType WoohooAqua

hi! link haskellNumber WoohooPurple
hi! link haskellPragma WoohooPurple

hi! link haskellString WoohooGreen
hi! link haskellChar WoohooGreen

" }}}
" Json: {{{

hi! link jsonKeyword WoohooGreen
hi! link jsonQuote WoohooGreen
hi! link jsonBraces WoohooFg1
hi! link jsonString WoohooFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! WoohooHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! WoohooHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
