" Test repeat of WORD completion.

source ../helpers/insert.vim
view WORDComplete.txt
new

call SetCompletion("\<C-x>\<C-w>")
call SetCompleteExpr('WORDComplete#Expr')

call InsertRepeat('foo --quit', 1, 0)
call InsertRepeat('fox --excl', 0, 0, 0, 0, 0)

call vimtest#SaveOut()
call vimtest#Quit()
