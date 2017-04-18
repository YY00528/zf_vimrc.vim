" ============================================================
" http://zsaber.com/blog/p/31
" ============================================================
if 1 " global settings
    " env
    let g:zf_windows=0
    if(has("win32") || has("win64") || has("win95") || has("win16"))
        let g:zf_windows=1
    endif
    let g:zf_mac=0
    if(has("unix"))
        try
            silent! let s:uname=system("uname")
            if s:uname=="Darwin\n"
                let g:zf_mac=1
            endif
        endtry
    endif
    let g:zf_linux=0
    if(has("unix"))
        let g:zf_linux=1
    endif
    if g:zf_windows!=1 && g:zf_mac!=1
        let g:zf_linux=1
    elseif g:zf_linux==1
        let g:zf_windows=0
    endif

    if !exists("g:zf_fakevim")
        let g:zf_fakevim=0
    endif

    if !exists("g:zf_no_plugin")
        let g:zf_no_plugin=g:zf_fakevim
    endif

    " leader should be set before other key map
    if g:zf_fakevim!=1
        let mapleader="'"
        nnoremap ' <leader>
        inoremap 'v 'v
        inoremap 'c 'c
        inoremap 'z 'z
    else
        let mapleader='\\'
        nmap ' <leader>
    endif

    " global ignore
    let g:zf_exclude_init="___dummy___"

    let g:zf_exclude_common=""
    let g:zf_exclude_common.=",.svn,.git,.hg"
    let g:zf_exclude_common.=",tags,.vim_tags"
    let g:zf_exclude_common.=",*.swp"

    let g:zf_exclude_tmp_dir=""
    let g:zf_exclude_tmp_dir.=",_cache,.cache"
    let g:zf_exclude_tmp_dir.=",_tmp,.tmp"

    let g:zf_exclude_build=""
    let g:zf_exclude_build.=",*.d,*.depend*"
    let g:zf_exclude_build.=",*.a,*.o,*.so,*.dylib"
    let g:zf_exclude_build.=",*.jar,*.class"
    let g:zf_exclude_build.=",*.exe,*.dll"

    let g:zf_exclude_build_dir=""
    let g:zf_exclude_build_dir.=",_release,.release"
    let g:zf_exclude_build_dir.=",_build,.build"
    let g:zf_exclude_build_dir.=",build,build-*"
    let g:zf_exclude_build_dir.=",bin,gen,lib,libs,obj"
    let g:zf_exclude_build_dir.=",_repo"

    let g:zf_exclude_media=""
    let g:zf_exclude_media.=",*.ico,*.jpg,*.jpeg,*.png,*.bmp,*.gif,*.webp"
    let g:zf_exclude_media.=",*.mp2,*.mp3,*.wav,*.ogg"

    let g:zf_exclude_all=g:zf_exclude_init
    let g:zf_exclude_all.=g:zf_exclude_common
    let g:zf_exclude_all.=g:zf_exclude_tmp_dir
    let g:zf_exclude_all.=g:zf_exclude_build
    let g:zf_exclude_all.=g:zf_exclude_build_dir
    let g:zf_exclude_all.=g:zf_exclude_media

    " git info
    if !exists("g:zf_git_user_email")
        let g:zf_git_user_email = 'z@zsaber.com'
    endif
    if !exists("g:zf_git_user_name")
        let g:zf_git_user_name = 'ZSaberLv0'
    endif
endif " global settings


" ============================================================
" all plugins
"     Vundle
"     git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
if g:zf_no_plugin!=1
    set nocompatible
    filetype off
    filetype plugin indent on
    set runtimepath+=$HOME/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim.git'

    " ==================================================
    if 1 " themes
        " ==================================================
        if exists("g:zf_colorscheme_256") && g:zf_colorscheme_256 == 1
            set t_Co=256
            let g:zf_colorscheme_plugin='tomasr/molokai'
            let g:zf_colorscheme='molokai'
            let g:zf_background='dark'
        endif

        " let g:zf_colorscheme_plugin='YourSchemePlugin'
        " let g:zf_colorscheme='YourSchemeName'
        " let g:zf_background='dark_or_light'
        if exists("g:zf_colorscheme_plugin") && g:zf_colorscheme_plugin != '' && g:zf_colorscheme_plugin != 'xterm16.vim'
            Plugin g:zf_colorscheme_plugin
        endif
        if !exists("g:zf_background")
            let g:zf_background='dark'
        endif
        " ==================================================
        Plugin 'xterm16.vim'
        let xterm16_brightness='high'
        let xterm16_colormap='soft'

        let g:zf_colorscheme_default='xterm16'
        let g:zf_background_default='dark'
    endif " themes

    " ==================================================
    if 1 " common plugins for happy text editing
        " ==================================================
        if !exists("g:plugin_agit_vim")
            let g:plugin_agit_vim=1
        endif
        if g:plugin_agit_vim==1
            Plugin 'cohama/agit.vim'
            let g:agit_no_default_mappings=1
            let g:agit_ignore_spaces=0
            function! ZF_Plugin_agit_print_commitmsg()
                try
                    execute "normal \<Plug>(agit-print-commitmsg)"
                finally
                endtry
            endfunction
            function! ZF_Plugin_agit_diff()
                let g:miniBufExplAutoStart=0
                silent! execute "normal \<Plug>(agit-diff)"
            endfunction
            function! ZF_Plugin_agit_diff_with_local()
                let g:miniBufExplAutoStart=0
                silent! execute "normal \<Plug>(agit-diff-with-local)"
            endfunction
            augroup ZF_Plugin_agit_setting
                autocmd!
                autocmd FileType agit,agit_stat,agit_diff
                            \ nmap <silent><buffer> q <Plug>(agit-exit)|
                            \ nmap <silent><buffer> p :call ZF_Plugin_agit_print_commitmsg()<cr>|
                            \ nmap <silent><buffer> DI :call ZF_Plugin_agit_diff()<cr>|
                            \ nmap <silent><buffer> DL :call ZF_Plugin_agit_diff_with_local()<cr>
            augroup END
        endif
        " ==================================================
        if !exists("g:plugin_asyncrun_vim")
            let g:plugin_asyncrun_vim=1
        endif
        if g:plugin_asyncrun_vim==1
            Plugin 'skywind3000/asyncrun.vim'
        endif
        nnoremap <leader>va :AsyncRun<space>
        let g:asyncrun_exit='echo "AsyncRun " . g:asyncrun_status . "(" . g:asyncrun_code'
                    \ . ' . "), use `:copen` to see the result"'
        " ==================================================
        if !exists("g:plugin_auto_mkdir")
            let g:plugin_auto_mkdir=1
        endif
        if g:plugin_auto_mkdir==1
            Plugin 'DataWraith/auto_mkdir'
        endif
        " ==================================================
        if !exists("g:plugin_auto_pairs")
            let g:plugin_auto_pairs=1
        endif
        if g:plugin_auto_pairs==1
            Plugin 'jiangmiao/auto-pairs'
            let g:AutoPairsShortcurToggle=''
            let g:AutoPairsShortcutFastWrap=''
            let g:AutoPairsShortcutJump=''
            let g:AutoPairsShortcutBackInsert=''
            let g:AutoPairsCenterLine=0
            let g:AutoPairsMultilineClose=0
            let g:AutoPairsMapBS=1
            let g:AutoPairsMapCh=0
            let g:AutoPairsMapCR=0
            let g:AutoPairsCenterLine=0
            let g:AutoPairsMapSpace=0
            let g:AutoPairsFlyMode=0
            let g:AutoPairsMultilineClose=0
        endif
        " ==================================================
        if !exists("g:plugin_BufOnly_vim")
            let g:plugin_BufOnly_vim=1
        endif
        if g:plugin_BufOnly_vim==1
            Plugin 'BufOnly.vim'
            nnoremap X :BufOnly<cr>
        endif
        " ==================================================
        if !exists("g:plugin_ctrlp_vim")
            let g:plugin_ctrlp_vim=1
        endif
        if g:plugin_ctrlp_vim==1
            Plugin 'kien/ctrlp.vim'
            let g:ctrlp_by_filename=1
            let g:ctrlp_regexp=1
            let g:ctrlp_working_path_mode=''
            let g:ctrlp_root_markers=[]
            let g:ctrlp_use_caching=1
            let g:ctrlp_clear_cache_on_exit=0
            let g:ctrlp_cache_dir=$HOME.'/.vim_cache/ctrlp'
            let g:ctrlp_show_hidden=1
            let g:ctrlp_prompt_mappings={
                        \ 'MarkToOpen()':['<c-a>'],
                        \ 'PrtInsert("c")':['<MiddleMouse>','<insert>','<c-g>'],
                        \ 'OpenMulti()':['<c-y>'],
                        \ 'PrtExit()':['<esc>','<c-c>','<c-o>'],
                        \ }
            let g:ctrlp_abbrev = {
                        \ 'gmode': 'i',
                        \ 'abbrevs': []
                        \ }
            function! ZF_Plugin_ctrlp_keymap(c, n)
                for i in range(a:n)
                    let k = nr2char(char2nr(a:c) + i)
                    let g:ctrlp_abbrev['abbrevs'] += [{'pattern': k, 'expanded': k . '.*'}]
                endfor
            endfunction
            call ZF_Plugin_ctrlp_keymap('0', 10)
            call ZF_Plugin_ctrlp_keymap('a', 26)
            call ZF_Plugin_ctrlp_keymap('A', 26)
            call ZF_Plugin_ctrlp_keymap('-', 1)
            call ZF_Plugin_ctrlp_keymap('_', 1)
            let g:ctrlp_map='<c-o>'
            nnoremap <silent> <leader>vo :CtrlP<cr>
            nnoremap <silent> <leader>zo :CtrlPClearAllCaches<cr>:CtrlP<cr>
        endif
        " ==================================================
        if !exists("g:plugin_CmdlineComplete")
            let g:plugin_CmdlineComplete=1
        endif
        if g:plugin_CmdlineComplete==1
            Plugin 'CmdlineComplete'
        endif
        " ==================================================
        if !exists("g:plugin_vim_dirdiff")
            let g:plugin_vim_dirdiff=1
        endif
        if g:plugin_vim_dirdiff==1
            Plugin 'will133/vim-dirdiff'
            let g:DirDiffEnableMappings=0
            let g:DirDiffExcludes=g:zf_exclude_init
            let g:DirDiffExcludes.=g:zf_exclude_common
            let g:DirDiffExcludes.=g:zf_exclude_tmp_dir
            let g:DirDiffExcludes.=g:zf_exclude_build
            let g:DirDiffExcludes.=g:zf_exclude_build_dir
            let g:DirDiffWindowSize=15
            let g:DirDiffIgnoreCase=0

            " minor fix for DirDiff's window size
            function! ZF_Plugin_DirDiff(arg)
                execute ":DirDiff " . a:arg
                if winnr() >= 3
                    execute ":q"
                    nnoremap <buffer> q :DirDiffQuit<cr>
                    nnoremap <buffer> o :DirDiffOpen<cr><c-w>k<c-w>l10<c-w>+
                    nnoremap <buffer> <cr> :DirDiffOpen<cr><c-w>k<c-w>l10<c-w>+
                    execute "normal! 30\<c-w>-"
                    execute "normal! \<c-w>k\<c-w>l"
                endif
            endfunction
            command! -nargs=+ -complete=dir ZFDirDiff :call ZF_Plugin_DirDiff(<q-args>)
            nnoremap <leader>vdd :ZFDirDiff<space>
        endif
        " ==================================================
        if !exists("g:plugin_vim_easy_align")
            let g:plugin_vim_easy_align=1
        endif
        if g:plugin_vim_easy_align==1
            Plugin 'junegunn/vim-easy-align'
            function! ZF_Plugin_EasyAlign_regexFix(param)
                let param = substitute(a:param, '\\/', '_zf_slash_', 'g')
                let regexp = substitute(substitute(param, '^[^/]*/\(\\v\)*', '', 'g'), '/.*', '', 'g')
                let option = substitute(param, '^[^/]*/[^/]*/', '', 'g')
                if empty(regexp) || regexp == param || option == param
                    return a:param
                endif
                try
                    let regexp = E2v(regexp)
                catch
                    return a:param
                endtry
                let param = '/' . regexp . '/' . option
                let param = substitute(param, '_zf_slash_', '/', 'g')
                return param
            endfunction
            command! -nargs=* -range -bang ZFEasyAlign <line1>,<line2>call easy_align#align('<bang>' == '!', 0, '', ZF_Plugin_EasyAlign_regexFix(<q-args>))
            xmap <leader>ca :ZFEasyAlign /\v/<left>
        endif
        " ==================================================
        if !exists("g:plugin_vim_easygrep")
            let g:plugin_vim_easygrep=1
        endif
        if g:plugin_vim_easygrep==1
            set grepprg=grep\ -n\ $*\ /dev/null
            Plugin 'dkprice/vim-easygrep'
            let g:EasyGrepRecursive=1
            let g:EasyGrepAllOptionsInExplorer=1
            let g:EasyGrepCommand=1
            let g:EasyGrepPerlStyle=1
            let g:EasyGrepFilesToExclude=g:zf_exclude_all
            let g:EasyGrepReplaceWindowMode=2
            let g:EasyGrepDisableCmdParam=1

            let g:EasyGrepOptionPrefix='<leader>v?grep?y'
            map <silent> <leader>v?grep?v <plug>EgMapGrepCurrentWord_v
            vmap <silent> <leader>v?grep?v <plug>EgMapGrepSelection_v
            map <silent> <leader>v?grep?V <plug>EgMapGrepCurrentWord_V
            vmap <silent> <leader>v?grep?V <plug>EgMapGrepSelection_V
            map <silent> <leader>v?grep?a <plug>EgMapGrepCurrentWord_a
            vmap <silent> <leader>v?grep?a <plug>EgMapGrepSelection_a
            map <silent> <leader>v?grep?A <plug>EgMapGrepCurrentWord_A
            vmap <silent> <leader>v?grep?A <plug>EgMapGrepSelection_A
            map <silent> <leader>v?grep?r <plug>EgMapReplaceCurrentWord_r
            vmap <silent> <leader>v?grep?r <plug>EgMapReplaceSelection_r
            map <silent> <leader>v?grep?R <plug>EgMapReplaceCurrentWord_R
            vmap <silent> <leader>v?grep?R <plug>EgMapReplaceSelection_R

            if 0
                nnoremap <leader>vgf :Grep<space>
            else
                function! ZF_Plugin_Grep(arg)
                    execute ":Grep " . a:arg
                    execute ":silent! M/" . a:arg
                endfunction
                command! -nargs=+ ZFGrep :call ZF_Plugin_Grep(<q-args>)
                nnoremap <leader>vgf :ZFGrep<space>
            endif
            nnoremap <leader>vgr :Replace //<left>
            nmap <leader>vgo <plug>EgMapGrepOptions
            let s:ZF_Plugin_easygrep_toggle_ignore_on=0
            let s:ZF_Plugin_easygrep_toggle_ignore_saved_wildignore=''
            let s:ZF_Plugin_easygrep_toggle_ignore_saved_easygrepignore=''
            function! ZF_Plugin_easygrep_toggle_ignore()
                let s:ZF_Plugin_easygrep_toggle_ignore_on=1-s:ZF_Plugin_easygrep_toggle_ignore_on
                if s:ZF_Plugin_easygrep_toggle_ignore_on==1
                    let s:ZF_Plugin_easygrep_toggle_ignore_saved_wildignore=&wildignore
                    let s:ZF_Plugin_easygrep_toggle_ignore_saved_easygrepignore=g:EasyGrepFilesToExclude
                    set wildignore=
                    let g:EasyGrepFilesToExclude=''
                    echo 'easygrep global ignore off'
                else
                    let &wildignore=s:ZF_Plugin_easygrep_toggle_ignore_saved_wildignore
                    let g:EasyGrepFilesToExclude=s:ZF_Plugin_easygrep_toggle_ignore_saved_easygrepignore
                    echo 'easygrep global ignore on'
                endif
            endfunction
            nnoremap <leader>vgi :call ZF_Plugin_easygrep_toggle_ignore()<cr>

            function! ZF_Plugin_easygrep_pcregrep(expr)
                let expr = a:expr
                let expr = substitute(expr, '"', '\\"', 'g')

                let cmd = 'pcregrep --buffer-size=16M -M -r -s -n'
                if match(expr, '\C[A-Z]') < 0
                    let cmd .= ' -i'
                endif
                let ignoreList = split(g:EasyGrepFilesToExclude, ',')
                for ignore in ignoreList
                    let ignore = substitute(ignore, '\.', '\\.', 'g')
                    let ignore = substitute(ignore, '\*', '.*', 'g')

                    let cmd .= ' --exclude-dir="' . ignore . '"'
                    let cmd .= ' --exclude="' . ignore . '"'
                endfor
                let cmd .= ' "' . expr . '" *'

                let result = system(cmd)
                let qflist = []
                let vim_pattern = E2v(a:expr)
                for line in split(result, '\n')
                    let file = substitute(matchstr(line, '^[^:]\+:'), ':', '', 'g')
                    let file_line = substitute(matchstr(line, ':[0-9]\+:'), ':', '', 'g')
                    if strlen(file) <= 0 || strlen(file_line) <= 0
                        continue
                    endif
                    let text = substitute(line, '^\[^:\]*:\[^:\]*:\(.*\)$', '\1', 'g')
                    let qflist += [{
                                \ 'filename' : file,
                                \ 'lnum' : file_line,
                                \ 'text' : text,
                                \ 'pattern' : vim_pattern,
                                \ }]
                endfor
                call setqflist(qflist)
                if len(qflist) > 0
                    execute ":silent! M/" . a:expr
                    copen
                else
                    echo 'no matches for: ' . a:expr
                endif
            endfunction
            command! -nargs=+ ZFGrepExt :call ZF_Plugin_easygrep_pcregrep(<q-args>)
            try
                if match(system('pcregrep --version'), '[0-9]\+\.[0-9]\+') < 0
                    nnoremap <leader>vge :echo 'pcregrep not installed'<cr>
                else
                    nnoremap <leader>vge :ZFGrepExt<space>
                endif
            endtry
        endif
        " ==================================================
        if !exists("g:plugin_vim_easymotion")
            let g:plugin_vim_easymotion=1
        endif
        if g:plugin_vim_easymotion==1
            Plugin 'easymotion/vim-easymotion'
            let g:EasyMotion_do_mapping=0
            let g:EasyMotion_smartcase=1
            let g:EasyMotion_use_upper=1
            let g:EasyMotion_keys='ASDGHKLQWERTYUIOPZXCVBNMFJ'
            nmap s <plug>(easymotion-s)
            xmap s <plug>(easymotion-s)
            nmap S <plug>(easymotion-sol-bd-jk)
            xmap S <plug>(easymotion-sol-bd-jk)
        endif
        " ==================================================
        if !exists("g:plugin_vim_easytags")
            let g:plugin_vim_easytags=1
        endif
        if g:plugin_vim_easytags==1
            Plugin 'xolox/vim-misc'
            Plugin 'xolox/vim-easytags'
            let g:easytags_resolve_links=1
            let g:easytags_suppress_ctags_warning=1
            " must not match wildignore
            let g:easytags_file='~/.vim_cache/.vim_tags'
            let g:ZF_Plugin_EasyTagsEnabled=1
            function! ZF_Plugin_EasyTagsOff()
                if g:ZF_Plugin_EasyTagsEnabled==0
                    return
                endif
                let g:ZF_Plugin_EasyTagsEnabled=0
                if !xolox#easytags#initialize('5.5')
                    return
                endif
                for s:eventname in g:easytags_events
                    if s:eventname !~? 'cursorhold'
                        execute 'autocmd! PluginEasyTags' s:eventname
                    endif
                endfor
            endfunction
            function! ZF_Plugin_EasyTagsOn()
                if g:ZF_Plugin_EasyTagsEnabled==1
                    return
                endif
                let g:ZF_Plugin_EasyTagsEnabled=1
                if !xolox#easytags#initialize('5.5')
                    return
                endif
                for s:eventname in g:easytags_events
                    if s:eventname !~? 'cursorhold'
                        execute 'autocmd' s:eventname '* call xolox#easytags#autoload(' string(s:eventname) ')'
                    endif
                endfor
            endfunction
            function! ZF_Plugin_EasyTagsToggle()
                if g:ZF_Plugin_EasyTagsEnabled==1
                    call ZF_Plugin_EasyTagsOff()
                    echo 'easytags off'
                else
                    call ZF_Plugin_EasyTagsOn()
                    echo 'easytags on'
                endif
            endfunction
            nnoremap <leader>ctt :call ZF_Plugin_EasyTagsToggle()<cr>
            augroup ZF_Plugin_EasyTags_setting
                autocmd!
                autocmd VimEnter *
                            \ call ZF_Plugin_EasyTagsOff()|
                            \ redraw!
            augroup END
        endif
        " ==================================================
        if !exists("g:plugin_eregex_vim")
            let g:plugin_eregex_vim=1
        endif
        if g:plugin_eregex_vim==1
            Plugin 'othree/eregex.vim'
            let g:eregex_default_enable=0
        endif
        " ==================================================
        if !exists("g:plugin_vim_fontsize")
            let g:plugin_vim_fontsize=1
        endif
        if g:plugin_vim_fontsize==1
            Plugin 'drmikehenry/vim-fontsize'
            nmap + <plug>FontsizeInc
            nmap - <plug>FontsizeDec
            nmap -= <plug>FontsizeDefault
        endif
        " ==================================================
        if !exists("g:plugin_linediff_vim")
            let g:plugin_linediff_vim=1
        endif
        if g:plugin_linediff_vim==1
            Plugin 'AndrewRadev/linediff.vim'
            let g:linediff_first_buffer_command='new'
            let g:linediff_second_buffer_command='vertical new'

            function! ZF_Plugin_linediff_Diff(line1, line2)
                let splitright_old=&splitright
                set splitright
                call linediff#Linediff(a:line1, a:line2, {})
                let &splitright=splitright_old
                if &diff == 1
                    execute "normal! \<c-w>l"
                endif
            endfunction
            command! -range LinediffBeginWrap call ZF_Plugin_linediff_Diff(<line1>, <line2>)
            xnoremap ZD :LinediffBeginWrap<cr>

            function! ZF_Plugin_linediff_DiffExit()
                while 1
                    if &diff != 1
                        break
                    endif

                    execute "normal! \<c-w>h"
                    let modified=&modified
                    execute "normal! \<c-w>l"
                    let modified=(modified||&modified)
                    if modified != 1
                        break
                    endif

                    echo "diff updated, save?"
                    echo "  (y)es"
                    echo "  (n)o"
                    echo "choose: "
                    let cmd=getchar()
                    if cmd != char2nr('y')
                        break
                    endif

                    execute "normal! \<c-w>h"
                    update
                    execute "normal! \<c-w>l"
                    update
                    bd
                    redraw!
                    echo 'diff updated'
                    return
                endwhile

                execute "LinediffReset!"
                redraw!
                echo "diff canceled"
            endfunction
            nnoremap ZD :call ZF_Plugin_linediff_DiffExit()<cr>
        endif
        " ==================================================
        if !exists("g:plugin_matchit_zip")
            let g:plugin_matchit_zip=1
        endif
        if g:plugin_matchit_zip==1
            Plugin 'matchit.zip'
        endif
        " ==================================================
        if !exists("g:plugin_minibufexpl_vim")
            let g:plugin_minibufexpl_vim=1
        endif
        if g:plugin_minibufexpl_vim==1
            Plugin 'weynhamz/vim-plugin-minibufexpl'
            let g:miniBufExplMaxSize=3
            let g:miniBufExplBuffersNeeded=1
            let g:miniBufExplHideWhenDiff=0
            nnoremap <leader>ctm :MBEToggle<cr>
        endif
        " ==================================================
        if !exists("g:plugin_nerdtree")
            let g:plugin_nerdtree=1
        endif
        if g:plugin_nerdtree==1
            Plugin 'scrooloose/nerdtree'
            let NERDTreeSortHiddenFirst=1
            let NERDTreeQuitOnOpen=1
            let NERDTreeShowHidden=1
            let NERDTreeShowLineNumbers=1
            let NERDTreeWinSize=50
            let NERDTreeMinimalUI=1
            let NERDTreeDirArrows=0
            let NERDTreeAutoDeleteBuffer=1
            let NERDTreeHijackNetrw=1
            let NERDTreeBookmarksFile=$HOME.'/.vim_cache/.NERDTreeBookmarks'
            let g:NERDTreeDirArrowExpandable="+"
            let g:NERDTreeDirArrowCollapsible="~"
            let g:NERDTreeRemoveDirCmd='rm -rf '
            nnoremap <silent> <leader>ve :NERDTreeToggle<cr>
            nnoremap <silent> <leader>ze :NERDTreeFind<cr>
            augroup plugin_nerdtree
                autocmd!
                autocmd FileType nerdtree
                            \ setlocal tabstop=2|
                            \ nmap <buffer> <leader>ze :NERDTreeToggle<cr>:NERDTreeFind<cr>|
                            \ nmap <buffer> cd z?cdz?CD:pwd<cr>|
                            \ nmap <buffer> X ggz?X|
                            \ nmap <buffer> u z?u:let _l=line(".")<cr>ggz?cdz?CD:<c-r>=_l<cr><cr>:pwd<cr>
                let g:ZF_Plugin_nerdtree_shellslash_saved=&shellslash
                autocmd BufEnter NERD_Tree_*
                            \ let g:ZF_Plugin_nerdtree_shellslash_saved=&shellslash|
                            \ set noshellslash
                autocmd BufLeave NERD_Tree_*
                            \ let &shellslash=g:ZF_Plugin_nerdtree_shellslash_saved
            augroup END
            let g:NERDTreeMapActivateNode="o"
            let g:NERDTreeMapChangeRoot="z?CD"
            let g:NERDTreeMapChdir="z?cd"
            let g:NERDTreeMapCloseChildren="z?X"
            let g:NERDTreeMapCloseDir="x"
            let g:NERDTreeMapDeleteBookmark=""
            let g:NERDTreeMapMenu="m"
            let g:NERDTreeMapHelp="?"
            let g:NERDTreeMapJumpFirstChild="zh"
            let g:NERDTreeMapJumpLastChild="zl"
            let g:NERDTreeMapJumpNextSibling="zj"
            let g:NERDTreeMapJumpParent="zu"
            let g:NERDTreeMapJumpPrevSibling="zk"
            let g:NERDTreeMapJumpRoot=""
            let g:NERDTreeMapOpenExpl=""
            let g:NERDTreeMapOpenInTab=""
            let g:NERDTreeMapOpenInTabSilent=""
            let g:NERDTreeMapOpenRecursively="O"
            let g:NERDTreeMapOpenSplit=""
            let g:NERDTreeMapOpenVSplit=""
            let g:NERDTreeMapPreview=""
            let g:NERDTreeMapPreviewSplit=""
            let g:NERDTreeMapPreviewVSplit=""
            let g:NERDTreeMapQuit="q"
            let g:NERDTreeMapRefresh="R"
            let g:NERDTreeMapRefreshRoot="r"
            let g:NERDTreeMapToggleBookmarks=""
            let g:NERDTreeMapToggleFiles=""
            let g:NERDTreeMapToggleFilters=""
            let g:NERDTreeMapToggleHidden="ch"
            let g:NERDTreeMapToggleZoom=""
            let g:NERDTreeMapUpdir="z?u"
            let g:NERDTreeMapUpdirKeepOpen=""
            let g:NERDTreeMapCWD=""

            Plugin 'jistr/vim-nerdtree-tabs'
            let g:nerdtree_tabs_startup_cd=0
            let g:nerdtree_tabs_open_on_gui_startup=0
            let g:nerdtree_tabs_open_on_console_startup=0
            let g:nerdtree_tabs_no_startup_for_diff=1

            Plugin 'ivalkeen/nerdtree-execute'
            Plugin 'ZSaberLv0/nerdtree_menu_copypath'
            Plugin 'ZSaberLv0/nerdtree_menu_quit'
        endif
        " ==================================================
        if !exists("g:plugin_ShowTrailingWhitespace")
            let g:plugin_ShowTrailingWhitespace=1
        endif
        if g:plugin_ShowTrailingWhitespace==1
            Plugin 'ShowTrailingWhitespace'
        endif
        " ==================================================
        if !exists("g:plugin_vim_signature")
            let g:plugin_vim_signature=1
        endif
        if g:plugin_vim_signature==1
            Plugin 'kshenoy/vim-signature'
        endif
        " ==================================================
        if !exists("g:plugin_supertab")
            let g:plugin_supertab=1
        endif
        if g:plugin_supertab==1
            Plugin 'ervandew/supertab'
            let g:SuperTabDefaultCompletionType="context"
            let g:SuperTabContextDefaultCompletionType="<c-p>"
            let g:SuperTabCompletionContexts=['s:ContextText', 's:ContextDiscover']
            let g:SuperTabContextTextOmniPrecedence=['&omnifunc', '&completefunc']
            let g:SuperTabContextDiscoverDiscovery=["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
            let g:SuperTabLongestEnhanced=1
            let g:SuperTabLongestHighlight=1
            augroup plugin_supertab
                autocmd!
                autocmd FileType,VimEnter *
                            \ if &omnifunc!='' && exists("*SuperTabChain") && exists("*SuperTabSetDefaultCompletionType")|
                            \     call SuperTabChain(&omnifunc, "<c-p>")|
                            \     call SuperTabSetDefaultCompletionType("<c-x><c-u>")|
                            \ endif
            augroup END
        endif
        " ==================================================
        if !exists("g:plugin_vim_surround")
            let g:plugin_vim_surround=1
        endif
        if g:plugin_vim_surround==1
            Plugin 'tpope/vim-surround'
            let g:surround_no_mappings=1
            let g:surround_no_insert_mappings=1
            nmap rd <plug>Dsurround
            nmap RD <plug>Dsurround
            nmap rc <plug>Csurround
            nmap RC <plug>CSurround
            xmap r <plug>VSurround
            xmap R <plug>VgSurround
            let g:surround_67="/* \r */" " C
            let g:surround_99="/* \r */" " c
            let g:surround_80="<?php \r ?>" " P
            let g:surround_112="<?php \r ?>" " p
            let g:surround_88="<!-- \r -->" " X
            let g:surround_120="<!-- \r -->" " x
            let g:surround_126="```\r```" " ~
        endif
        " ==================================================
        if !exists("g:plugin_tagbar")
            let g:plugin_tagbar=1
        endif
        if g:plugin_tagbar==1
            Plugin 'majutsushi/tagbar'
            let g:tagbar_width=80
            let g:tagbar_autoclose=1
            let g:tagbar_autofocus=1
            let g:tagbar_sort=0
            let g:tagbar_compact=1
            let g:tagbar_show_linenumbers=1
            let g:tagbar_show_visibility=0
            let g:tagbar_autoshowtag=1

            nnoremap <silent> <leader>vt :TagbarToggle<cr>
        endif
        " ==================================================
        if !exists("g:plugin_vimim")
            let g:plugin_vimim=1
        endif
        if g:plugin_vimim==1
            Plugin 'ZSaberLv0/VimIM'
            let g:Vimim_map='no-gi'
            let g:Vimim_punctuation=0
            let g:Vimim_toggle='pinyin,baidu'
            nnoremap <silent> ;; i<C-R>=g:Vimim_chinese()<CR><Esc>l
            inoremap <silent> ;; <C-R>=g:Vimim_chinese()<CR>
            nnoremap <silent> ;: i<C-R>=g:Vimim_onekey()<CR><Esc>l
            inoremap <silent> ;: <C-R>=g:Vimim_onekey()<CR>
        endif
        " ==================================================
        if !exists("g:plugin_wildfire_vim")
            let g:plugin_wildfire_vim=1
        endif
        if g:plugin_wildfire_vim==1
            Plugin 'gcmt/wildfire.vim'
            let g:wildfire_objects=[]
            let g:wildfire_objects+=["i'", 'i"', "i`", "i)", "i]", "i}", "i>", "it"]
            let g:wildfire_objects+=["a'", 'a"', "a`", "a)", "a]", "a}", "a>", "at"]
            " we want no map in select mode
            let g:wildfire_fuel_map='<leader>v?wildfire?t'
            let g:wildfire_water_map='<leader>v?wildfire?T'
            nmap t <Plug>(wildfire-fuel)
            xmap t <Plug>(wildfire-fuel)
            xmap T <Plug>(wildfire-water)
        endif
        " ==================================================
        if !exists("g:plugin_ZFVimEscape_vim")
            let g:plugin_ZFVimEscape_vim=1
        endif
        if g:plugin_ZFVimEscape_vim==1
            Plugin 'ZSaberLv0/ZFVimEscape'
            vnoremap <leader>ce <esc>:call ZF_VimEscape()<cr>
            nnoremap <leader>ce ggvG$<esc>:call ZF_VimEscape()<cr>
        endif
        " ==================================================
        if !exists("g:plugin_ZFVimFoldBlock")
            let g:plugin_ZFVimFoldBlock=1
        endif
        if g:plugin_ZFVimFoldBlock==1
            Plugin 'ZSaberLv0/ZFVimFoldBlock'
            nnoremap ZB q::call ZF_FoldBlockTemplate()<cr>
            nnoremap ZF :ZFFoldBlock //<left>
            function! ZF_Plugin_ZFVimFoldBlock_comment()
                let expr='\(^\s*\/\/\)'
                if &filetype=='vim'
                    let expr.='\|\(^\s*"\)'
                endif
                if &filetype=='c' || &filetype=='cpp'
                    let expr.='\|\(^\s*\(\(\/\*\)\|\(\*\)\)\)'
                endif
                if &filetype=='make'
                    let expr.='\|\(^\s*#\)'
                endif
                let disableE2vSaved = g:ZFVimFoldBlock_disableE2v
                let g:ZFVimFoldBlock_disableE2v = 1
                call ZF_FoldBlock("/" . expr . "//")
                let g:ZFVimFoldBlock_disableE2v = disableE2vSaved
                echo "comments folded"
            endfunction
            nnoremap ZC :call ZF_Plugin_ZFVimFoldBlock_comment()<cr>
        endif
        " ==================================================
        if !exists("g:plugin_ZFFormater_vim")
            let g:plugin_ZFFormater_vim=1
        endif
        if g:plugin_ZFFormater_vim==1
            Plugin 'ZSaberLv0/ZFVimFormater'
            Plugin 'elzr/vim-json'
            Plugin 'Chiel92/vim-autoformat'
            Plugin 'rhysd/vim-clang-format'
            let g:vim_json_syntax_conceal=0
            nnoremap <leader>cf :call ZF_Formater()<cr>
        endif
        " ==================================================
        if !exists("g:plugin_ZFIndentMove_vim")
            let g:plugin_ZFIndentMove_vim=1
        endif
        if g:plugin_ZFIndentMove_vim==1
            Plugin 'ZSaberLv0/ZFVimIndentMove'
            nnoremap E <nop>
            nnoremap EE ``
            nnoremap EH :call ZF_IndentMoveParent('n')<cr>
            xnoremap EH :<c-u>call ZF_IndentMoveParent('v')<cr>
            nnoremap EL :call ZF_IndentMoveParentEnd('n')<cr>
            xnoremap EL :<c-u>call ZF_IndentMoveParentEnd('v')<cr>
            nnoremap EK :call ZF_IndentMovePrev('n')<cr>
            xnoremap EK :<c-u>call ZF_IndentMovePrev('v')<cr>
            nnoremap EJ :call ZF_IndentMoveNext('n')<cr>
            xnoremap EJ :<c-u>call ZF_IndentMoveNext('v')<cr>
            nnoremap EI :call ZF_IndentMoveChild('n')<cr>
            xnoremap EI :<c-u>call ZF_IndentMoveChild('v')<cr>
        endif
        " ==================================================
        if !exists("g:plugin_ZFVimTxtHighlight")
            let g:plugin_ZFVimTxtHighlight=1
        endif
        if g:plugin_ZFVimTxtHighlight==1
            Plugin 'ZSaberLv0/ZFVimTxtHighlight'
            nnoremap <leader>cth :call ZF_VimTxtHighlightToggle()<cr>
        endif
        " ==================================================
        if !exists("g:plugin_ZFVimrcUtil")
            let g:plugin_ZFVimrcUtil=1
        endif
        if g:plugin_ZFVimrcUtil==1
            Plugin 'ZSaberLv0/ZFVimrcUtil'
            nnoremap <leader>vimrc :call ZF_VimrcEdit()<cr>
            nnoremap <leader>vimrt :call ZF_VimrcEditOrg()<cr>
            nnoremap <leader>vimclean :call ZF_VimClean()<cr>
            nnoremap <leader>vimrd :call ZF_VimrcDiff()<cr>
            nnoremap <leader>vimru :call ZF_VimrcUpdate()<cr>
            nnoremap <leader>vimrp :call ZF_VimrcPush()<cr>
        endif
        " ==================================================
        if !exists("g:plugin_ZFVimTagSetting")
            let g:plugin_ZFVimTagSetting=1
        endif
        if g:plugin_ZFVimTagSetting==1
            Plugin 'ZSaberLv0/ZFVimTagSetting'
            nnoremap <leader>ctagl :call ZF_TagsFileLocal()<cr>
            nnoremap <leader>ctagg :call ZF_TagsFileGlobal()<cr>
            nnoremap <leader>ctaga :call ZF_TagsFileGlobalAdd()<cr>
            nnoremap <leader>ctagr :call ZF_TagsFileRemove()<cr>
            nnoremap <leader>ctagv :edit $HOME/.vim_cache/.vim_tags<cr>
        endif
        " ==================================================
        if !exists("g:plugin_ZFVimUtil")
            let g:plugin_ZFVimUtil=1
        endif
        if g:plugin_ZFVimUtil==1
            Plugin 'ZSaberLv0/ZFVimUtil'
            nnoremap <leader>vs :ZFExecShell<space>
            nnoremap <leader>vc :ZFExecCmd<space>
            nnoremap <leader>calc :ZFCalc<space>
            nnoremap <leader>vdf :ZFDiffFile<space>
            nnoremap <leader>vdb :ZFDiffBuffer<space>
            nnoremap <leader>vdg :ZFDiffGit https://github.com/
            nnoremap <leader>vde :ZFDiffExit<cr>
            nnoremap <leader>vvo :ZFOpenAllFileInClipboard<cr>
            nnoremap <leader>vvs :ZFRunShellScriptInClipboard<cr>
            nnoremap <leader>vn :ZFNumberConvert<cr>
            nnoremap ZB q::call ZF_FoldBlockTemplate()<cr>
            nnoremap Z) :call ZF_FoldBrace(')')<cr>
            nnoremap Z] :call ZF_FoldBrace(']')<cr>
            nnoremap Z} :call ZF_FoldBrace('}')<cr>
            nnoremap Z> :call ZF_FoldBrace('>')<cr>
            nnoremap <leader>vf :call ZF_FuzzySearch("[a-z0-9_]*")<cr>
            nnoremap <leader>cc :call ZF_Convert()<cr>
            nnoremap <leader>cm :call ZF_Toggle()<cr>
        endif
    endif " common plugins for happy text editing

    " ==================================================
    if 1 " additional plugins for language spec
        " ==================================================
        if !exists("g:plugin_a_vim")
            let g:plugin_a_vim=1
        endif
        if g:plugin_a_vim==1
            Plugin 'taxilian/a.vim'
        endif
        " ==================================================
        if !exists("g:plugin_clang_complete")
            let g:plugin_clang_complete=1
        endif
        if g:plugin_clang_complete==1 && has('python')
            Plugin 'Rip-Rip/clang_complete'
            let g:clang_auto_select=1
            let g:clang_complete_auto=0
            let g:clang_snippets=1
            let g:clang_close_preview=1
            let g:clang_sort_algo="alpha"
            let g:clang_jumpto_declaration_key="zj"
            let g:clang_jumpto_back_key="zk"
            " let g:clang_user_options+='-I'
            let g:clang_complete_macros=1
            let g:clang_complete_patterns=1
            let g:clang_make_default_keymappings=1
            let g:clang_use_library=1
            if !exists("g:clang_library_path") || g:clang_library_path == ""
                if g:zf_windows==1
                    if filereadable('C:\Program Files\LLVM\bin\libclang.dll')
                        let g:clang_library_path=expand('C:\Program Files\LLVM\bin')
                    elseif filereadable($VIMRUNTIME . 'libclang.dll')
                        let g:clang_library_path=$VIMRUNTIME
                    elseif filereadable($HOME . '/clang/bin/libclang.dll')
                        let g:clang_library_path=$HOME . '/clang/bin'
                    else
                        let g:clang_library_path=expand('C:\Program Files\LLVM\bin')
                    endif
                elseif g:zf_mac==1
                    let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
                elseif filereadable('/usr/lib/libclang.a')
                            \ || filereadable('/usr/lib/libclang.so')
                            \ || filereadable('/usr/lib/libclang.dll')
                            \ || filereadable('/usr/lib/libclang.dll.a')
                            \ || filereadable('/usr/lib/libclang.dll.so')
                    let g:clang_library_path='/usr/lib'
                else
                    let g:clang_library_path='/usr/local/lib'
                endif
            endif
        endif
        " ==================================================
        if !exists("g:plugin_vim_cpp_enhanced_highlight")
            let g:plugin_vim_cpp_enhanced_highlight=1
        endif
        if g:plugin_vim_cpp_enhanced_highlight==1
            Plugin 'octol/vim-cpp-enhanced-highlight'
        endif
        " ==================================================
        if !exists("g:plugin_DoxygenToolkit_vim")
            let g:plugin_DoxygenToolkit_vim=1
        endif
        if g:plugin_DoxygenToolkit_vim==1
            Plugin 'DoxygenToolkit.vim'
            let g:load_doxygen_syntax=1
        endif
        " ==================================================
        if !exists("g:plugin_vim_flavored_markdown")
            let g:plugin_vim_flavored_markdown=1
        endif
        if g:plugin_vim_flavored_markdown==1
            Plugin 'jtratner/vim-flavored-markdown'

            augroup plugin_vim_flavored_markdown
                autocmd!
                autocmd BufNewFile,BufReadPost {*.md,*.mkd,*.markdown} set filetype=ghmarkdown
            augroup END
        endif
        " ==================================================
        if !exists("g:plugin_ZFMarkdownToc_vim")
            let g:plugin_ZFMarkdownToc_vim=1
        endif
        if g:plugin_ZFMarkdownToc_vim==1
            Plugin 'ZSaberLv0/ZFVimMarkdownToc'
            augroup ZF_setting_markdown_keymap
                autocmd!
                autocmd FileType markdown,ghmarkdown
                            \ nnoremap <buffer> [[ :call ZF_MarkdownTitlePrev('n')<cr>|
                            \ xnoremap <buffer> [[ :call ZF_MarkdownTitlePrev('v')<cr>|
                            \ nnoremap <buffer> ]] :call ZF_MarkdownTitleNext('n')<cr>|
                            \ xnoremap <buffer> ]] :call ZF_MarkdownTitleNext('v')<cr>|
                            \ nnoremap <buffer> <leader>vt :call ZF_MarkdownToc()<cr>
            augroup END
        endif
        " ==================================================
        if !exists("g:plugin_vim_php_namespace")
            let g:plugin_vim_php_namespace=1
        endif
        if g:plugin_vim_php_namespace==1
            Plugin 'arnaud-lb/vim-php-namespace'
            nnoremap <leader>cphpu :call PhpInsertUse()<cr>
            nnoremap <leader>cphpe :call PhpExpandClass()<cr>
        endif
        " ==================================================
        if !exists("g:plugin_PIV")
            let g:plugin_PIV=1
        endif
        if g:plugin_PIV==1
            Plugin 'spf13/PIV'
            let g:PIVCreateDefaultMappings=0
            let g:DisableAutoPHPFolding=1
        endif
        " ==================================================
        if !exists("g:plugin_xml_vim")
            let g:plugin_xml_vim=1
        endif
        if g:plugin_xml_vim==1
            Plugin 'othree/xml.vim'
        endif
    endif " additional plugins for language spec


    " ==================================================
    call vundle#end()
endif " if g:zf_no_plugin!=1


" ==================================================
if 1 " themes
    " themes should be set before other vim settings
    if exists('g:zf_colorscheme') && !empty(globpath(&rtp, 'colors/' . g:zf_colorscheme . '.vim'))
        execute 'colorscheme ' . g:zf_colorscheme
        if exists('g:zf_background')
            execute 'set background=' . g:zf_background
        endif
    elseif exists('g:zf_colorscheme_default') && !empty(globpath(&rtp, 'colors/' . g:zf_colorscheme_default . '.vim'))
        execute 'colorscheme ' . g:zf_colorscheme_default
        if exists('g:zf_background_default')
            execute 'set background=' . g:zf_background_default
        endif
    else
        colorscheme murphy
        set background=dark
    endif
endif " themes


" ==================================================
if 1 " custom key mapping
    " esc
    inoremap jk <esc>l
    cnoremap jk <c-c>
    nnoremap <space> <esc>
    xnoremap <space> <esc>
    onoremap <space> <esc>
    " visual
    nnoremap V <c-v>
    vnoremap V <c-v>
    nnoremap <c-v> V
    vnoremap <c-v> V
    " special select mode mapping
    if g:zf_fakevim!=1
        let s:_selectmode_keys='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~!@#$%^&*-_=+\\|;:,./?)]}>'
        for i in range(strlen(s:_selectmode_keys))
            silent! execute 'snoremap <silent> ' . s:_selectmode_keys[i] . ' <c-g>"_c' . s:_selectmode_keys[i]
        endfor
        silent! snoremap <silent> <space> <esc>
        silent! snoremap <silent> jk <esc>gv
        silent! snoremap <silent> <bs> <c-g>"_c
        silent! snoremap <silent> ( <c-g>"_c()<esc>i
        silent! snoremap <silent> [ <c-g>"_c[]<esc>i
        silent! snoremap <silent> { <c-g>"_c{}<esc>i
        silent! snoremap <silent> < <c-g>"_c<><esc>i
        silent! snoremap <silent> ' <c-g>"_c''<esc>i
        silent! snoremap <silent> " <c-g>"_c""<esc>i
        silent! snoremap <silent> ` <c-g>"_c``<esc>i
    endif
    " scrolling
    nnoremap <c-h> zh
    nnoremap <c-l> zl
    nnoremap <c-j> <c-e>
    nnoremap <c-k> <c-y>
    inoremap <c-h> <left>
    inoremap <c-l> <right>
    inoremap <c-j> <down>
    inoremap <c-k> <up>
    cnoremap <c-h> <left>
    cnoremap <c-l> <right>
    cnoremap <c-j> <down>
    cnoremap <c-k> <up>
    nnoremap H :bp<cr>
    nnoremap L :bn<cr>
    nnoremap J <c-f>
    vnoremap J <c-f>
    nnoremap K <c-b>
    vnoremap K <c-b>
    " move
    nmap z, %
    xmap z, %

    noremap , $
    noremap g, g$

    noremap j gj
    noremap gj j

    noremap k gk
    noremap gk k
    " brace jump
    nnoremap zg <nop>

    nnoremap zg) va)<esc>h%
    nnoremap z) va)<esc>h
    xnoremap zg) <esc>`<mz`>va)<esc>h%m>`zm<:delmarks z<cr>gv
    xnoremap z) <esc>`<mz`>va)<esc>`zm<:delmarks z<cr>gvh

    nnoremap zg] va]<esc>h%
    nnoremap z] va]<esc>h
    xnoremap zg] <esc>`<mz`>va]<esc>h%m>`zm<:delmarks z<cr>gv
    xnoremap z] <esc>`<mz`>va]<esc>`zm<:delmarks z<cr>gvh

    nnoremap zg} va}<esc>h%
    nnoremap z} va}<esc>h
    xnoremap zg} <esc>`<mz`>va}<esc>h%m>`zm<:delmarks z<cr>gv
    xnoremap z} <esc>`<mz`>va}<esc>`zm<:delmarks z<cr>gvh

    nnoremap zg> va><esc>h%
    nnoremap z> va><esc>h
    xnoremap zg> <esc>`<mz`>va><esc>h%m>`zm<:delmarks z<cr>gv
    xnoremap z> <esc>`<mz`>va><esc>`zm<:delmarks z<cr>gvh

    nnoremap zg" vi"<esc>`<h
    nnoremap z" vi"<esc>
    xnoremap zg" <esc>`<mz`>vi"<esc>`<m>`zm<:delmarks z<cr>gv
    xnoremap z" <esc>`<mz`>vi"<esc>`zm<:delmarks z<cr>gv

    nnoremap zg' vi'<esc>`<h
    nnoremap z' vi'<esc>
    xnoremap zg' <esc>`<mz`>vi'<esc>`<m>`zm<:delmarks z<cr>gv
    xnoremap z' <esc>`<mz`>vi'<esc>`zm<:delmarks z<cr>gv

    nmap zg; zg}
    nmap z; z}
    xmap zg; zg}
    xmap z; z}
    " go to define
    nnoremap zj <c-]>
    nnoremap zk <c-t>
    nnoremap zh :tprevious<cr>
    nnoremap zl :tnext<cr>
    " redo
    nnoremap U <c-r>
    " modify/delete without change clipboard
    nnoremap c "_c
    xnoremap c "_c
    nnoremap d "_d
    xnoremap d "_d
    nnoremap <del> "_dl
    vnoremap <del> "_d
    inoremap <del> <right><bs>
    " always use system clipboard
    set clipboard+=unnamed
    if has('clipboard')
        nnoremap zp :let @"=@*<cr>:echo 'copied from system clipboard'<cr>
    else
        nnoremap zp <nop>
    endif
    nnoremap p gP
    xnoremap p "_dgP
    nnoremap P gp
    xnoremap P "_dgp
    function! ZF_Setting_VisualPaste()
        normal! gv
        if mode() != ""
            if has('clipboard')
                normal! "_d"*gP
            else
                normal! "_dgP
            endif
        endif
    endfunction
    nmap <c-g> p
    xnoremap <c-g> <esc>:call ZF_Setting_VisualPaste()<cr>
    if has('clipboard')
        inoremap <c-g> <c-r>*
        cnoremap <c-g> <c-r>*
        snoremap <c-g> <c-o>"_d"*gP
    else
        inoremap <c-g> <c-r>"
        cnoremap <c-g> <c-r>"
        snoremap <c-g> <c-o>"_dgP
    endif
    " window and buffer management
    nnoremap B :bufdo<space>
    nnoremap zs :w<cr>
    nnoremap ZS :wa<cr>
    nnoremap zx :w<cr>:bd<cr>
    nnoremap ZX :wa<cr>:bufdo bd<cr>
    nnoremap cx :bd!<cr>
    nnoremap CX :bufdo bd!<cr>
    nnoremap x :bd<cr>
    command! W w !sudo tee % > /dev/null

    nnoremap WH <c-w>h
    nnoremap WL <c-w>l
    nnoremap WJ <c-w>j
    nnoremap WK <c-w>k

    nnoremap WO :resize<cr>:vertical resize<cr>
    nnoremap WI :vertical resize<cr>
    nnoremap WU :resize<cr>
    nnoremap WW <c-w>w
    nnoremap WN <c-w>=
    nnoremap Wh 30<c-w><
    nnoremap Wl 30<c-w>>
    nnoremap Wj 10<c-w>+
    nnoremap Wk 10<c-w>-
    " fold
    xnoremap ZH zf
    nnoremap ZH zc
    nnoremap ZL zo
    nnoremap Zh zC
    nnoremap Zl zO
    nnoremap ZU zE
    nnoremap ZI zM
    nnoremap ZO zR
    " diff util
    nnoremap D <nop>
    nnoremap DJ ]czz
    nnoremap DK [czz
    nnoremap DH do
    nnoremap DL dp
    nnoremap DD :diffupdate<cr>
    " quick move lines
    nnoremap C <nop>

    nnoremap CH mz<<`zhhhh:delmarks z<cr>:echo ''<cr>
    nnoremap CL mz>>`zllll:delmarks z<cr>:echo ''<cr>
    nnoremap CJ mz:m+<cr>`z:delmarks z<cr>:echo ''<cr>
    nnoremap CK mz:m-2<cr>`z:delmarks z<cr>:echo ''<cr>

    vnoremap CH <gv
    vnoremap CL >gv
    vnoremap CJ :m'>+<cr>gv
    vnoremap CK :m'<-2<cr>gv

    "inoremap CH <esc>lmz<<`zhhhh:delmarks z<cr>:echo ''<cr>i
    "inoremap CL <esc>lmz>>`zllll:delmarks z<cr>:echo ''<cr>i
    "inoremap CJ <esc>lmz:m+<cr>`z:delmarks z<cr>:echo ''<cr>i
    "inoremap CK <esc>lmz:m-2<cr>`z:delmarks z<cr>:echo ''<cr>i
    " inc/dec numbers
    nnoremap CI <c-a>
    nnoremap CU <c-x>
    " macro spec
    function! ZF_Setting_VimMacroMap()
        nnoremap Q :call ZF_Setting_VimMacroBegin(0)<cr>
        nnoremap zQ :call ZF_Setting_VimMacroBegin(1)<cr>
        nnoremap cQ :let @t='let @m="' . @m . '"'<cr>q:"tgP
        nmap M @m
    endfunction
    function! ZF_Setting_VimMacroBegin(isAppend)
        nnoremap Q q:call ZF_Setting_VimMacroEnd()<cr>
        nnoremap M q:call ZF_Setting_VimMacroEnd()<cr>@m
        if a:isAppend!=1
            normal! qm
        else
            normal! qM
        endif
    endfunction
    function! ZF_Setting_VimMacroEnd()
        call ZF_Setting_VimMacroMap()
        echo 'macro recorded, use M in normal mode to repeat'
    endfunction
    if g:zf_fakevim!=1
        " mapping '::' would confuse some vim simulate plugins which would cause strange behavior,
        " even worse, some of them won't check 'if' statement and always apply settings inside the 'if',
        " here's some tricks (using autocmd) to completely prevent the mapping from being executed
        autocmd VimEnter *
                    \ call ZF_Setting_VimMacroMap()|
                    \ nnoremap :: q:k$|
                    \ nnoremap // q/k$
    endif
    " quick edit command
    cnoremap <leader>ve <c-c>q:k$
    " search and replace
    " (here's a memo for regexp)
    "
    " zero width:
    "     (?=exp)  : anything end with exp (excluding exp)
    "     (?!exp)  : anything not end with exp
    "     (?<=exp) : anything start with exp (excluding exp)
    "     (?<!exp) : anything not start with exp
    "
    " match as less as possible:
    "     .*    : .*?
    "     .+    : .+?
    "     .{n,} : .{n,}?
    if exists("g:plugin_eregex_vim") && g:plugin_eregex_vim==1
        nnoremap / /\v
        nnoremap ? :M/
        nnoremap <leader>vr :.,$S//gec<left><left><left><left>
        xnoremap <leader>vr "ty:.,$S/<c-r>t//gec<left><left><left><left>
        nnoremap <leader>zr :.,$S//gec<left><left><left><left>\<<c-r><c-w>\>/
        xnoremap <leader>zr "ty:.,$S/\<<c-r>t\>//gec<left><left><left><left>

        nnoremap <leader>v/ :%S///gn<left><left><left><left>
    else
        if g:zf_fakevim!=1
            nnoremap / /\v
            nnoremap ? /\v
            nnoremap <leader>vr :.,$s/\v/gec<left><left><left><left>
            xnoremap <leader>vr "ty:.,$s/\v<c-r>t//gec<left><left><left><left>
            nnoremap <leader>zr :.,$s/\v/gec<left><left><left><left><<c-r><c-w>>/
            xnoremap <leader>zr "ty:.,$s/\v<<c-r>t>//gec<left><left><left><left>

            nnoremap <leader>v/ :%s/\v//gn<left><left><left><left>
        else
            nnoremap / /
            nnoremap ? /
            nnoremap <leader>vr :.,$s//gec<left><left><left><left>
            xnoremap <leader>vr "ty:.,$s/<c-r>t//gec<left><left><left><left>
            nnoremap <leader>zr :.,$s//gec<left><left><left><left>\<<c-r><c-w>\>/
            xnoremap <leader>zr "ty:.,$s/\<<c-r>t\>//gec<left><left><left><left>

            nnoremap <leader>v/ :%s///gn<left><left><left><left>
        endif
    endif
    " <c-z> to qall
    nnoremap <c-z> :qa<cr>
endif " custom key mapping


" ==================================================
if 1 " common settings
    " common
    filetype plugin on
    syntax on
    set nocompatible
    set hidden
    set list
    set listchars=tab:>\ ,trail:-,extends:>
    set modeline
    set showcmd
    set showmatch
    set wildmenu
    set autoread
    set nobackup
    set nowritebackup
    set noswapfile
    set nowrap
    set synmaxcol=500
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guioptions-=b
    set clipboard+=unnamed
    set whichwrap=b,s,<,>,[,]
    function! ZF_setting_common_action()
        set number
        set textwidth=0
        set iskeyword=@,48-57,_,128-167,224-235
    endfunction
    augroup ZF_setting_common
        call ZF_setting_common_action()
        autocmd!
        autocmd FileType,BufNewFile,BufReadPost * call ZF_setting_common_action()
    augroup END
    augroup ZF_setting_largefile
        autocmd!
        autocmd BufReadPre *
                    \ let f=expand("<afile>")|
                    \ if getfsize(f) > (1024 * 1024 * 5)|
                    \     set eventignore+=FileType|
                    \     setlocal bufhidden=unload|
                    \     setlocal foldmethod=manual|
                    \     setlocal nofoldenable|
                    \     syntax clear|
                    \ endif
    augroup END
    " encodings
    set fileformats=unix,dos
    set fileformat=unix
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8,ucs-bom,chinese
    " search
    set ignorecase
    set smartcase
    set hlsearch
    set incsearch
    let s:ZF_Setting_ToggleSearch_last=''
    function! ZF_Setting_ToggleSearch()
        if s:ZF_Setting_ToggleSearch_last == '' || s:ZF_Setting_ToggleSearch_last == @/
            let s:ZF_Setting_ToggleSearch_last=@/
            echo '' . s:ZF_Setting_ToggleSearch_last
            return
        endif

        echo 'choose search pattern:'
        echo '  j: ' . s:ZF_Setting_ToggleSearch_last
        echo '  k: ' . @/
        let confirm=nr2char(getchar())
        redraw!

        if confirm == 'j'
            let @/=s:ZF_Setting_ToggleSearch_last
            silent! normal! n
            echo '' . @/
        elseif confirm == 'k'
            let s:ZF_Setting_ToggleSearch_last=@/
            silent! normal! n
            echo '' . @/
        else
            echo 'canceled'
        endif
    endfunction
    nnoremap zb :call ZF_Setting_ToggleSearch()<cr>
    nnoremap zn viw<esc>b/<c-r><c-w><cr>N
    xnoremap zn "ty/<c-r>t<cr>N
    nnoremap zm viw<esc>b/\<<c-r><c-w>\><cr>N
    xnoremap zm "ty/\<<c-r>t\><cr>N

    nnoremap z/n viw<esc>b:%s/<c-r><c-w>//gn<cr>``
    xnoremap z/n "ty:%s/<c-r>t//gn<cr>``
    nnoremap z/m viw<esc>b:%s/\<<c-r><c-w>\>//gn<cr>``
    xnoremap z/m "ty:%s/\<<c-r>t\>//gn<cr>``
    " tab and indent
    set expandtab
    set shiftwidth=4
    set softtabstop=0
    set tabstop=4
    set smartindent
    set cindent
    set autoindent
    set cinkeys=0{,0},0),:,!^F,o,O,e
    " editing
    set virtualedit=onemore,block
    set selection=exclusive
    set guicursor=a:block-blinkon0
    set backspace=indent,eol,start
    set scrolloff=5
    set sidescrolloff=5
    set selectmode=mouse,key
    set mouse=a
    " wildignore
    function! ZF_Setting_wildignore(pattern)
        let pattern = split(a:pattern, ',')
        for item in pattern
            execute 'set wildignore+=' . item
            execute 'set wildignore+=*/' . item . '/*'
        endfor
    endfunction
    call ZF_Setting_wildignore(g:zf_exclude_all)
    " disable italic fonts
    function! ZF_Setting_DisableItalic()
        let his = ''
        redir => his
        silent highlight
        redir END
        let his = substitute(his, '\n\s\+', ' ', 'g')
        for line in split(his, "\n")
            if line !~ ' links to ' && line !~ ' cleared$'
                execute 'hi' substitute(substitute(line, ' xxx ', ' ', ''), 'italic', 'none', 'g')
            endif
        endfor
    endfunction
    augroup ZF_setting_disable_italic
        call ZF_Setting_DisableItalic()
        autocmd!
        autocmd FileType,BufNewFile,BufReadPost * call ZF_Setting_DisableItalic()
    augroup END
    " status line
    set laststatus=2
    set statusline=
    set statusline+=%<%f
    set statusline+=\ %m%r
    set statusline+=%=%k
    set statusline+=\ %l/%L\ :\ %c
    set statusline+=\ \ \ %y
    set statusline+=\ [%{(&bomb?\",BOM\ \":\"\")}%{(&fenc==\"\")?&enc:&fenc}\ %{(&fileformat)}]
    set statusline+=\ %4b
    set statusline+=\ %04B
    set statusline+=\ %3p%%
    augroup ZF_setting_quickfix_statusline
        autocmd!
        autocmd BufWinEnter quickfix,qf
                    \ setlocal statusline=%<%t\ %=%k\ %l/%L\ :\ %c\ %4b\ %04B\ %3p%%
    augroup END
    " cursorline
    set linespace=2
    set cursorline
    highlight Cursor gui=NONE guibg=green guifg=black
    highlight Cursor cterm=NONE ctermbg=green ctermfg=black
    highlight CursorLine gui=underline guibg=NONE guifg=NONE
    highlight CursorLine cterm=bold ctermbg=NONE ctermfg=NONE
    highlight CursorLineNr gui=reverse guibg=NONE guifg=NONE
    highlight CursorLineNr cterm=reverse ctermbg=NONE ctermfg=NONE
    " complete
    inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
    inoremap <expr> <c-p> pumvisible() ? '<c-p>' : '<c-p><c-r>=pumvisible() ? "\<lt>Up>" : ""<cr>'
    inoremap <expr> <c-n> pumvisible() ? '<c-n>' : '<c-n><c-r>=pumvisible() ? "\<lt>Down>" : ""<cr>'
    set completeopt=menuone,longest
    set complete=.,w,b,u,k,t
    set omnifunc=syntaxcomplete#Complete
    " fold
    function! ZF_setting_fold_action()
        set foldminlines=0
        set foldlevel=128
        set foldmethod=manual
    endfunction
    augroup ZF_setting_fold
        call ZF_setting_fold_action()
        autocmd!
        autocmd FileType,BufNewFile,BufReadPost * call ZF_setting_fold_action()
    augroup END
    " diff
    set diffopt=filler,context:200
    " themes
    highlight Folded gui=NONE guibg=NONE guifg=DarkBlue
    highlight Folded cterm=NONE ctermbg=NONE ctermfg=DarkBlue
    highlight IncSearch ctermbg=White ctermfg=Red
    highlight IncSearch guibg=White guifg=Red
    highlight MatchParen ctermbg=DarkBlue ctermfg=Red
    highlight MatchParen guibg=DarkBlue guifg=Red
    highlight NonText ctermbg=NONE ctermfg=DarkRed
    highlight NonText guibg=NONE guifg=DarkRed
    highlight Pmenu gui=NONE guibg=Gray guifg=Black
    highlight Pmenu cterm=NONE ctermbg=Gray ctermfg=Black
    highlight PmenuSel gui=bold guibg=LightGreen guifg=Red
    highlight PmenuSel cterm=bold ctermbg=LightGreen ctermfg=Red
    highlight PmenuSbar gui=bold guibg=DarkGreen guifg=Red
    highlight PmenuSbar cterm=bold ctermbg=DarkGreen ctermfg=Red
    highlight PmenuThumb gui=NONE guibg=LightGreen guifg=Red
    highlight PmenuThumb cterm=NONE ctermbg=LightGreen ctermfg=Red
    highlight SpecialKey ctermbg=NONE ctermfg=DarkRed
    highlight SpecialKey guibg=NONE guifg=DarkRed
    " other settings
    nnoremap q <esc>
    xnoremap q <esc>
    augroup ZF_setting_cmdwin
        autocmd!
        autocmd CmdwinEnter *
                    \ nnoremap <buffer> <silent> q :q<cr>
    augroup END
    augroup ZF_setting_quickfix
        autocmd!
        autocmd BufWinEnter quickfix
                    \ nnoremap <buffer> <silent> q :bd<cr>|
                    \ nnoremap <buffer> <silent> <leader>vt :bd<cr>|
                    \ nnoremap <buffer> <silent> <cr> <cr>:lclose<cr>|
                    \ nnoremap <buffer> <silent> o <cr>:lclose<cr>|
                    \ setlocal foldmethod=indent
    augroup END
    augroup ZF_setting_help
        autocmd!
                autocmd FileType help
                    \ nnoremap <buffer> <silent> q :q<cr>
    augroup END
endif " common settings


" ==================================================
if 1 " plugin themes
    " plugin colors must be set after colorscheme
    if exists("g:plugin_minibufexpl_vim") && g:plugin_minibufexpl_vim==1
        let g:did_minibufexplorer_syntax_inits=1
        highlight MBENormal guibg=White guifg=Black
        highlight MBENormal ctermbg=White ctermfg=Black
        highlight MBEChanged guibg=White guifg=Red
        highlight MBEChanged ctermbg=White ctermfg=Red
        highlight link MBEVisibleNormal MBENormal
        highlight link MBEVisibleChanged MBEChanged
        highlight MBEVisibleActiveNormal guibg=LightGreen guifg=Black
        highlight MBEVisibleActiveNormal ctermbg=LightGreen ctermfg=Black
        highlight MBEVisibleActiveChanged guibg=LightGreen guifg=Red
        highlight MBEVisibleActiveChanged ctermbg=LightGreen ctermfg=Red
    endif
    if exists("g:plugin_vim_easymotion") && g:plugin_vim_easymotion==1
        highlight EasyMotionTarget guibg=NONE guifg=White
        highlight EasyMotionTarget ctermbg=NONE ctermfg=White
        highlight link EasyMotionTarget2First EasyMotionTarget
        highlight link EasyMotionTarget2Second EasyMotionTarget
        highlight EasyMotionShade guibg=NONE guifg=DarkRed
        highlight EasyMotionShade ctermbg=NONE ctermfg=DarkRed
        highlight link EasyMotionIncSearch EasyMotionShade
        highlight link EasyMotionMoveHL EasyMotionShade
    endif
endif " plugin themes


" ==================================================
if 1 " local env setting
    if g:zf_windows==1
        " use cmd.exe for most compatibility
        set shell=cmd.exe
        " have shellslash for convenient when editing code,
        " may break something while using other plugins,
        " disable it manually if need
        set shellslash
        " ensure cygwin at head of PATH,
        " otherwise some Windows' shell function may break cygwin's command,
        " such as 'find'
        let $PATH='C:\cygwin\bin;' . $PATH

        function! ZF_Windows_WindowCenterInScreen()
            set lines=9999 columns=9999
            let g:windowsSizeFixX=58
            let g:windowsSizeFixY=118
            let g:windowsScaleX=7.75
            let g:windowsScaleY=17.0
            let g:windowsPosOldX=getwinposx()
            let g:windowsPosOldY=getwinposy()
            let g:windowsScreenWidth=float2nr(winwidth(0) * g:windowsScaleX) + g:windowsPosOldX + g:windowsSizeFixX
            let g:windowsScreenHeight=float2nr(winheight(0) * g:windowsScaleY) + g:windowsPosOldY + g:windowsSizeFixY
            set lines=45 columns=160
            let g:windowsSizeWidth=float2nr(winwidth(0) * g:windowsScaleX) + g:windowsSizeFixX
            let g:windowsSizeHeight=float2nr(winheight(0) * g:windowsScaleY) + g:windowsSizeFixY
            let g:windowsPosX=((g:windowsScreenWidth - g:windowsSizeWidth) / 2)
            let g:windowsPosY=((g:windowsScreenHeight - g:windowsSizeHeight) / 2)
            execute ':winpos ' . g:windowsPosX . ' ' . g:windowsPosY
        endfunction
        au GUIEnter * call ZF_Windows_WindowCenterInScreen()
    endif
endif " local env setting

" ==================================================
if 1 " custom file type
    augroup ZF_setting_filetype
        autocmd!
        autocmd BufNewFile,BufReadPost {*.pro}
                    \ set filetype=make|
                    \ set expandtab
    augroup END
endif " custom file type

