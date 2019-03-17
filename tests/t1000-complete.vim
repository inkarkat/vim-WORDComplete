" Test completion of non-blank characters.

set completefunc=WORDComplete#WORDComplete
call WORDComplete#Expr()    " Initialize script variables.
edit WORDComplete.txt

runtime tests/helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(7)
call IsMatchesInIsolatedLine('doesnotexist', [], 'no matches for doesnotexist')
call IsMatchesInIsolatedLine('se', ['set'], 'match for se')
call IsMatchesInIsolatedLine('underscore', ['underscore:code:negative'], 'match for underscore')
call IsMatchesInIsolatedLine('pre', ['prefixed:bad:code:name.', 'prefixed:this:crazy:name', 'prefixed:underscore:code:name,'], 'matches for pre')
call IsMatchesInIsolatedLine('--quit', ['--quit-for-special-handling', '--quit-if-one-screen'], 'matches for --quit')
call IsMatchesInIsolatedLine('--quie', ['--quiet-errors', '--quiet-info', '--quiet-stuff'], 'matches for --quie')
call IsMatchesInIsolatedLine('my-', ['my-script-31337-path-and-name-without-extension-11=%~dpn0'], 'match for my-')
call vimtest#Quit()
