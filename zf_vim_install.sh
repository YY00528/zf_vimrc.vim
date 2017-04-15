#!bash

_git_exist=0
git --version >/dev/null && _git_exist=1 || _git_exist=0
if test "x$_git_exist" = "x0"; then
    echo "error: git not installed"
    exit
fi

_vim_exist=0
vim --version >/dev/null && _vim_exist=1 || _vim_exist=0
if test "x$_vim_exist" = "x0"; then
    echo "error: vim not installed"
    exit
fi

_old_dir=$(pwd)
cd ~

_vimrc=
if test -e ".vimrc"; then
    _vimrc=".vimrc"
elif test -e "_vimrc"; then
    _vimrc="_vimrc"
else
    _vimrc=".vimrc"
fi

_exist=0
grep -wq "zf_vimrc.vim" $_vimrc && _exist=1 || _exist=0

if test "x$_exist" = "x0"; then
    echo "" >> $_vimrc
    echo "# if any weird problem occurred, uncomment one of these:" >> $_vimrc
    echo "#" >> $_vimrc
    echo "# set shell=cmd.exe" >> $_vimrc
    echo "# set shellcmdflag=/c" >> $_vimrc
    echo "#" >> $_vimrc
    echo "# set shell=bash" >> $_vimrc
    echo "# set shellcmdflag=-c" >> $_vimrc
    echo "#" >> $_vimrc
    echo "source \~/zf_vimrc.vim" >> $_vimrc
fi

git config --global core.autocrlf false

echo "updating zf_vimrc..."
_tmpdir="_zf_vimrc_tmp_"
git clone https://github.com/ZSaberLv0/zf_vimrc.vim.git $_tmpdir
cp $_tmpdir/zf_vimrc.vim "zf_vimrc.vim"
rm -rf $_tmpdir

echo "updating Vundle..."
if test ! -e ".vim/bundle/Vundle.vim"; then
    git clone https://github.com/VundleVim/Vundle.vim.git ".vim/bundle/Vundle.vim"
fi

vim +PluginUpdate +qall

cd "$_old_dir"

