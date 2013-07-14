" WORDComplete.vim: Insert mode completion that completes an entire sequence of
" non-blank characters.
"
" DEPENDENCIES:
"   - CompleteHelper.vim autoload script
"
" Copyright: (C) 2009-2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
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

function! WORDComplete#Expr()
    set completefunc=WORDComplete#WORDComplete
    return "\<C-x>\<C-u>"
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
