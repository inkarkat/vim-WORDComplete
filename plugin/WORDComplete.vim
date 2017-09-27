" WORDComplete.vim: Insert mode completion that completes an entire sequence of
" non-blank characters.
"
" DEPENDENCIES:
"   - Requires Vim 7.0 or higher.
"   - WORDComplete.vim autoload script
"
" Copyright: (C) 2009-2017 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_WORDComplete') || (v:version < 700)
    finish
endif
let g:loaded_WORDComplete = 1

"- mappings --------------------------------------------------------------------

inoremap <silent> <expr> <Plug>(WORDComplete) WORDComplete#Expr()
nnoremap <silent> <expr> <SID>(WORDComplete) WORDComplete#Selected()
" Note: Must leave selection first; cannot do that inside the expression mapping
" because the visual selection marks haven't been set there yet.
vnoremap <silent> <script> <Plug>(WORDComplete) <C-\><C-n><SID>(WORDComplete)

if ! hasmapto('<Plug>(WORDComplete)', 'i')
    imap <C-x><C-w> <Plug>(WORDComplete)
endif
if ! hasmapto('<Plug>(WORDComplete)', 'v')
    vmap <C-x><C-w> <Plug>(WORDComplete)
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
