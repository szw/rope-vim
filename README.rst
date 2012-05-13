Ropevim, rope in vim
======================

Ropevim is a vim mode that uses rope_ library to provide features like
python refactorings and code-assists.

This vim plugin allow you use rope library in vim very easy.
Now you dont needed install rope libs in system.
Also this plugin add vim help with rope commands.

This fork contains embedded rope-omni_ plugin created by Ryan Wooden. 
It allows you to setup rope completion as 
a usercomplete/omnicomplete function in Vim.

Installation
------------

Just copy plugin folders in your ~/.vim directory.

Or with pathogen_ clone plugin in your ``bundle`` folder


Settings
--------

Rope auto assist mapped in Control+Space keys. You can remap it. Example: ::

    imap <buffer><Tab> <M-/>

To setup omni/user complete functions add to your .vimrc: ::

    "For omnicomplete <C-x><C-o>
    autocmd FileType python setlocal omnifunc=RopeCompleteFunc 

or ::

    "For usercomplete <C-X><C-u>
    autocmd FileType python setlocal completefunc=RopeCompleteFunc 

Note, you can have both: the default python omnicompletion and rope completion together: ::

    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType python setlocal completefunc=RopeCompleteFunc


.. _rope: http://rope.sourceforge.net/
.. _rope-omni: https://github.com/rygwdn/rope-omni
.. _pathogen: https://github.com/tpope/vim-pathogen
