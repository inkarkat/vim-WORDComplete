" Test relaxed completion of non-blank characters within a word.

set completefunc=WORDComplete#WORDComplete
call WORDComplete#Expr()    " Initialize script variables.
edit WORDComplete.txt

source ../../vim-CompleteHelper/tests/helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(3)
call IsMatchesInIsolatedLine('cra', ['crazy:name'], 'relaxed match for cra')
call IsMatchesInIsolatedLine('scor', ['score:code:name,', 'score:code:negative'], 'relaxed matches for scor')
call IsMatchesInIsolatedLine('-spec', ['-special-handling'], 'relaxed match for -spec')
call vimtest#Quit()
