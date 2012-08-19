" WORDComplete.vim: Insert mode completion that completes an entire sequence of
" non-blank characters. 
"
" DESCRIPTION:
"   The built-in insert mode completion |i_CTRL-N| searches for keywords.
"   Depending on the 'iskeyword' setting, this can be very fine-grained, so that
"   fragments like '--quit-if-one-screen' or '/^Vim\%((\a\+)\)\=:E123/' can take
"   many completion commands and are thus tedious to complete. 
"   This plugin offers completion of sequences of non-blank characters (a.k.a.
"   |WORD|s), i.e. everything separated by whitespace or the start / end of
"   line. With this, one can quickly complete entire text fragments which are
"   delimited by whitespace. 
"
" USAGE:
" <i_CTRL-X_CTRL-W>	Find matches for WORDs that start with the non-blank
"			characters in front of the cursor and end at the next
"			whitespace. 
"			
"   In insert mode, invoke the WORD completion via CTRL-X CTRL-W. 
"   You can then search forward and backward via CTRL-N / CTRL-P, as usual. 
"
" INSTALLATION:
" DEPENDENCIES:
"   - CompleteHelper.vim autoload script. 
"
" CONFIGURATION:
"   Analoguous to the 'complete' option, you can specify which buffers will be
"   scanned for completion candidates. Currently, only '.' (current buffer) and
"   'w' (buffers from other windows) are supported. >
"	let g:WORDComplete_complete string = '.,w'
"   The global setting can be overridden for a particular buffer
"   (b:WORDComplete_complete). 
"   
" INTEGRATION:
" LIMITATIONS:
" ASSUMPTIONS:
" KNOWN PROBLEMS:
" TODO:
"
" Copyright: (C) 2009 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'. 
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS 
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

if ! exists('g:WORDComplete_complete')
    let g:WORDComplete_complete = '.,w'
endif

function! s:GetCompleteOption()
    return (exists('b:WORDComplete_complete') ? b:WORDComplete_complete : g:WORDComplete_complete)
endfunction

function! WORDComplete#WORDComplete( findstart, base )
    if a:findstart
	" Locate the start of the WORD. 
	let l:startCol = searchpos('\S*\%#', 'bn', line('.'))[1]
	if l:startCol == 0
	    let l:startCol = col('.')
	endif
	return l:startCol - 1 " Return byte index, not column. 
    else
	" Find matches starting with a:base and ending with whitespace or the
	" end of the line. The match must start at the beginning of the line or
	" after whitespace. 
	let l:matches = []
	call CompleteHelper#FindMatches( l:matches, '\%(^\|\s\)\zs\V' . escape(a:base, '\') . '\S\+', {'complete': s:GetCompleteOption()} )
	if empty(l:matches)
	    " In case there are no matches, relax the restriction that the match
	    " must start after whitespace. This allows to complete "--" from
	    " "'--foo-bar'" (with an additional trailing "'" character, though),
	    " but also to complete "pos(" from "searchpos([1,2,3])". 
	    echohl ModeMsg
	    echo '-- User defined completion (^U^N^P) -- Relaxed search...'
	    echohl None
	    call CompleteHelper#FindMatches( l:matches, '\V' . escape(a:base, '\') . '\S\+', {'complete': s:GetCompleteOption()} )
	endif
	return l:matches
    endif
endfunction

function! s:WORDCompleteExpr()
    set completefunc=WORDComplete#WORDComplete
    return "\<C-x>\<C-u>"
endfunction
inoremap <script> <expr> <Plug>(WORDComplete) <SID>WORDCompleteExpr()
if ! hasmapto('<Plug>(WORDComplete)', 'i')
    imap <C-x><C-w> <Plug>(WORDComplete)
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
