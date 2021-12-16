" Test repeat of WORD completion with the same keyword base.

runtime tests/helpers/insert.vim
view WORDComplete.txt
new

call SetCompletion("\<C-x>g\<C-w>")
call SetCompleteExpr("WORDComplete#Expr('WORDComplete#WORDSameKeywordBaseComplete')")

call InsertRepeat('foo --quit', 1, 0)
call InsertRepeat('call(--quit', 1, 0)
call InsertRepeat('de%mo#--quit', 1, 0)
call InsertRepeat('fox --excl', 0, 0, 0, 0)
call InsertRepeat('return(--excl', 0, 0, 0, 0)
call InsertRepeat('re%na#me$--excl', 0, 0, 0, 0)

call vimtest#SaveOut()
call vimtest#Quit()
