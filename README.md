WORD COMPLETE   
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

The built-in insert mode completion i\_CTRL-N searches for keywords.
Depending on the 'iskeyword' setting, this can be very fine-grained, so that
fragments like '--quit-if-one-screen' or '/^Vim\%((\a\+)\)\=:E123/' can take
many completion commands and are thus tedious to complete.
This plugin offers completion of sequences of non-blank characters (a.k.a.
|WORD|s), i.e. everything separated by whitespace or the start / end of line.
With this, one can quickly complete entire text fragments which are delimited
by whitespace.

### SEE ALSO

- Check out the CompleteHelper.vim plugin page ([vimscript #3914](http://www.vim.org/scripts/script.php?script_id=3914)) for a full
  list of insert mode completions powered by it.

USAGE
------------------------------------------------------------------------------

    In insert mode, invoke the WORD completion via CTRL-X CTRL-W.
    You can then search forward and backward via CTRL-N / CTRL-P, as usual.

    CTRL-X CTRL-W           Find matches for WORDs that start with the non-blank
                            characters in front of the cursor and end at the next
                            whitespace.
                            First, a match must start after whitespace (or at the
                            beginning of the line); if that returns no results, it
                            may match anywhere.
                            Further use of CTRL-X W will copy the text including
                            the next WORDs following the previous expansion in
                            other contexts.

    {Visual}CTRL-X CTRL-W   Find matches for WORDs that start with selected text
                            and end at the next whitespace.

### EXAMPLE

To query the entire command argument --foo-bar (when "-" is not part of
'iskeyword'), just type "--f" and trigger the completion.

With the relaxed search, "pos(" will complete the entire call "pos([1,2,3])"
found in "searchpos([1,2,3])".

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-WORDComplete
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim WORDComplete*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.010 or
  higher.
- Requires the CompleteHelper.vim plugin ([vimscript #3914](http://www.vim.org/scripts/script.php?script_id=3914)), version 1.40 or
  higher.

CONFIGURATION
------------------------------------------------------------------------------

For a permanent configuration, put the following commands into your vimrc:

By default, the 'complete' option controls which buffers will be scanned for
completion candidates. You can override that either for the entire plugin, or
only for particular buffers; see CompleteHelper\_complete for supported
values.

    let g:WORDComplete_complete = '.,w,b,u'

If you want to use a different mapping, map your keys to the
 Plug>(WORDComplete) mapping target _before_ sourcing the script (e.g.
in your vimrc):

    imap <C-x><C-w> <Plug>(WORDComplete)
    vmap <C-x><C-w> <Plug>(WORDComplete)

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-WORDComplete/issues or email (address below).

HISTORY
------------------------------------------------------------------------------

##### 1.00    27-Sep-2017
- First published version.

##### 0.01    30-May-2009
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2009-2017 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat <ingo@karkat.de>
