execute pathogen#infect()
syntax on
filetype plugin indent on
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }
set number
highlight LineNr term=bold cterm=NONE ctermfg=LightGrey ctermbg=NONE gui=NONE guifg=LightGrey guibg=NONE


"show invisibles
set list
set listchars=tab:»\ ,eol:¬

"Unmap the arrow keys
"no <down> <Nop>
"no <left> <Nop>
"no <right> <Nop>
"no <up> <Nop>

"ino <down> <Nop>
"ino <left> <Nop>
"ino <right> <Nop>
"ino <up> <Nop>
