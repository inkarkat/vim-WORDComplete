" Test completion of non-blank characters with the same keyword base.

set completefunc=WORDComplete#WORDSameKeywordBaseComplete
call WORDComplete#Expr('WORDComplete#WORDSameKeywordBaseComplete')    " Initialize script variables.
edit WORDComplete.txt

runtime tests/helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(20)

call IsMatchesInIsolatedLine('doesnotexist', [], 'no matches for doesnotexist')
call IsMatchesInIsolatedLine('se', ['set'], 'match for se')
call IsMatchesInIsolatedLine('underscore', ['underscore:code:negative'], 'match for underscore')
call IsMatchesInIsolatedLine('pre', ['prefixed:bad:code:name.', 'prefixed:this:crazy:name', 'prefixed:underscore:code:name,'], 'matches for pre')
call IsMatchesInIsolatedLine('--quit', ['--quit-for-special-handling', '--quit-if-one-screen'], 'matches for --quit')
call IsMatchesInIsolatedLine('call(--quit', ['--quit-for-special-handling', '--quit-if-one-screen'], 'matches for --quit following call(')
call IsMatchesInIsolatedLine('--quie', ['--quiet-errors', '--quiet-info', '--quiet-stuff'], 'matches for --quie')
call IsMatchesInIsolatedLine('my-call(--quie', ['--quiet-errors', '--quiet-info', '--quiet-stuff'], 'matches for --quie following my-call(')
call IsMatchesInIsolatedLine('my-', ['my-script-31337-path-and-name-without-extension-11=%~dpn0'], 'match for my-')

call IsMatchesInIsolatedLine('zero@one', [], 'no matches for @one')
call IsMatchesInIsolatedLine('@one', [], 'no matches for @one')
call IsMatchesInIsolatedLine('zero&one', [], 'no matches for zero&one')
call IsMatchesInIsolatedLine('&one', [], 'no matches for &one')
call IsMatchesInIsolatedLine('zero&one@two', ['one@two#three$four%five%base', 'one@two@three$four%five%six%base'], 'matches for one@two following zero&')
call IsMatchesInIsolatedLine('&one@two', ['one@two#three$four%five%base', 'one@two@three$four%five%six%base'], 'matches for one@two following &')
call IsMatchesInIsolatedLine('zero&one@two@', ['one@two@three$four%five%six%base'], 'match for one@two@ following zero&')
call IsMatchesInIsolatedLine('&&one@two@', ['one@two@three$four%five%six%base'], 'match for one@two@ following &&')
call IsMatchesInIsolatedLine('&one@@', ['one@@two##three$$four%%five%%base'], 'match for one@@ following &')
call IsMatchesInIsolatedLine('zero&one@@', ['one@@two##three$$four%%five%%base'], 'match for one@@ following zero&')
call IsMatchesInIsolatedLine('zero&one@@two', ['one@@two##three$$four%%five%%base'], 'match for one@@two following zero&')

call vimtest#Quit()
