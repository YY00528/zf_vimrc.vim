# introduction

my personal vimrc config for vim

aiming to be used under multi platforms, low dependency, yet powerful for general usage

tested:

* vim version 7.3 or above
* Windows's gVim
* cygwin's vim
* Mac OS's vim and macvim (console or GUI)
* Ubuntu's vim
* Android's VimTouch (with full runtime)

may work: (search and see `g:zf_fakevim`)

* Qt Creator's FakeVim (able to use, no plugin support, some keymap doesn't work)
* IntelliJ IDEA's IdeaVim (able to use, no plugin support, some keymap doesn't work)
* XCode's XVim (not recommended, some action have unexpected behavior)


for me, I use this config mainly for `C/C++` and `markdown` development,
as well as for default text editor and log viewer


# quick install

if you have `curl`, `git`, `vim` installed, here's a very simple command to install everything:

```
curl zsaber.com/vim | sh
```

after installed, you may use `<leader>vimru` to update with this repo
(note: local changes to `zf_vimrc.vim` would be discarded)


# manual install

1. download or clone the `zf_vimrc.vim` file to anywhere
1. have these in your `.vimrc` (under linux) or `_vimrc` (under Windows):

    ```
    source path/zf_vimrc.vim
    ```

1. use [Vundle](https://github.com/VundleVim/Vundle.vim) to manage plugins

    ```
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    ```

1. it's recommended to modify platform-dependent settings in `.vimrc`, such as:

    ```
    au GUIEnter * simalt ~x
    set guifont=Consolas:h12
    set termencoding=cp936
    let g:zf_colorscheme_256=1
    source path/zf_vimrc.vim
    ```

for a list of plugins and configs, please refer to the
[zf_vimrc.vim](https://github.com/ZSaberLv0/zf_vimrc.vim/blob/master/zf_vimrc.vim) itself,
which is self described


# additional requirement

* [cygwin](https://www.cygwin.com)

    not necessary, but strongly recommended for Windows users

* GNU grep (greater than 2.5.3)

    for [vim-easygrep](https://github.com/dkprice/vim-easygrep) if you want to use Perl style regexp

    note the FreeBSD version won't work due to the lack of `-P` option of `grep`

* [Pandoc](http://pandoc.org/)

    for Markdown preview and conversion

* [LLVM](http://llvm.org/)

    for [clang_complete](https://github.com/Rip-Rip/clang_complete), you should:

    * have python support
    * have `g:clang_library_path` been set properly

        the default config may suit most case, modify it if necessary


# platform spec

## cygwin

when used under different version of cygwin, you should concern these settings if weird problem occurred:

```
set shell=cmd.exe
set shellcmdflag=/c
```

or

```
set shell=bash
set shellcmdflag=-c
```

set it directly to `.vimrc`, choose the right one for you


## Android's VimTouch

* `VimTouch Full Runtime` is also required
* the vim config is placed under `/data/data/net.momodalo.app.vimtouch/files/.vimrc`
* you should manually copy all settings from other platform to VimTouch's folder,
    the result folder tree should looks like:

    ```
    /data/data/net.momodalo.app.vimtouch/files/
        .vim/
            bundle/
                ...
        .vimrc
        zf_vimrc.vim
    ```

* `othree/xml.vim` won't work on VimTouch, disable it manually by:

    ```
    let g:plugin_xml_vim=0
    ```

## for simulation plugins of IDE

```
let g:zf_fakevim=1
```

* not fully tested
* some vim simulation plugins doesn't support `source` command,
  so you may need to paste directly to proper vimrc files (e.g. `.ideavim`, `.xvimrc`)
* some vim simulation plugins doesn't support `if-statement` and plugins,
  so you may need to manually delete all lines under the `if g:zf_no_plugin!=1` section

