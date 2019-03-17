" Test completion from selected base.

set completefunc=WORDComplete#WORDComplete
call WORDComplete#Expr()    " Initialize script variables.
let g:SelectBase = 'call WORDComplete#Selected()'
edit WORDComplete.txt

runtime tests/helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(5)
call IsMatchesInContext('prefixed:', '', 'doesNotExist', [], 'no matches for doesNotExist')
call IsMatchesInContext('eval "', '', '--incl', ['--include=foo'], 'match for selected --incl')
call IsMatchesInContext('-', '', '--quit-', ['--quit-for-special-handling', '--quit-if-one-screen'], 'matches for selected --quit-')
call IsMatchesInContext('-', '', '-excl', ['-exclude=bar'], 'match for selected -excl')
call IsMatchesInContext('Query', '', 'Matches', ['MatchesInCurrentWindow(match,', 'MatchesInOtherWindows(matches,'], 'matches for Matches')

call vimtest#SaveOut()
call vimtest#Quit()
