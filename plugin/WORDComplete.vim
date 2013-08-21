" WORDComplete.vim: Insert mode completion that completes an entire sequence of
" non-blank characters.
"
" DEPENDENCIES:
"   - Requires Vim 7.0 or higher.
"   - WORDComplete.vim autoload script
"
" Copyright: (C) 2009-2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	006	03-Sep-2012	Add value "b" (other listed buffers) to the
"				plugin's 'complete' option offered by
"				CompleteHelper.vim 1.20.
"	005	20-Aug-2012	Split off functions into separate autoload
"				script and documentation into dedicated help
"				file.
"	004	08-Oct-2009	The match must start at the beginning of the
"				line or after whitespace, or else "kar" will
"				complete "karound" from "workaround". Only if no
"				matches are obtained in this way, a relaxed
"				search will offer matches starting anywhere, as
"				before.
"	003	07-Aug-2009	Using a map-expr instead of i_CTRL-O to set
"				'completefunc', as the temporary leave of insert
"				mode caused a later repeat via '.' to only
"				insert the completed fragment, not the entire
"				inserted text.
"	002	09-Jun-2009	Made mapping configurable.
"	001	30-May-2009	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_WORDComplete') || (v:version < 700)
    finish
endif
let g:loaded_WORDComplete = 1

"- configuration ---------------------------------------------------------------

if ! exists('g:WORDComplete_complete')
    let g:WORDComplete_complete = '.,w,b'
endif


"- mappings --------------------------------------------------------------------

inoremap <silent> <expr> <Plug>(WORDComplete) WORDComplete#Expr()
if ! hasmapto('<Plug>(WORDComplete)', 'i')
    imap <C-x><C-w> <Plug>(WORDComplete)
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
