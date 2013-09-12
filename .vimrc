set encoding=utf-8
set fileencodings=utf8,sjis,euc-jp,utf8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,sjis,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac    "改行コードの自動認識

set ambiwidth=double
set statusline=[%F%r%h%w]\[%{&fenc==''?&enc:&fenc}]\[POS=%04l,%04v][%p%%]\[LEN=%L]

" ファイルに合わせたEncoding
" autocmd FileType html :set  fileencoding=sjis
" autocmd FileType perl :set  fileencoding=euc-jp
" autocmd FileType sql  :set  fileencoding=sjis

autocmd BufNewFile,BufRead *.psgi   set filetype=perl
autocmd BufNewFile,BufRead *.t      set filetype=perl

" 新規作成時のテンプレート
autocmd BufNewFile *.pl 0r $HOME/.vim/template/new_pl.txt
autocmd BufNewFile *.t  0r $HOME/.vim/template/new_pl_t.txt
function! s:pm_template()
    let path = substitute(expand('%'), '.*lib/', '', 'g')
    let path = substitute(path, '[\\/]', '::', 'g')
    let path = substitute(path, '\.pm$', '', 'g')

    call append(0, 'package ' . path . ';')
    call append(1, '')
    call append(2, 'use strict;')
    call append(3, 'use warnings;')
    call append(4, 'use utf8;')
    call append(5, '')
    call append(6, '')
    call append(7, '')
    call append(8, '1;')
    call cursor(7, 0)
    " echomsg path
endfunction
autocmd BufNewFile *.pm call s:pm_template()

"View
syntax  on          "強調表示(色付け)のON/OFF設定
set t_Co=256        "256色対応
colorscheme molokai "カラースキーム（別途DLの設定）
set list
set lcs=tab:^\ ,trail:_,extends:\_
set cursorline
set cursorcolumn
highlight JpSpace cterm=underline ctermfg=Red guifg=Red
au BufRead,BufNew * match JpSpace /　/  "全角スペースの表示
set textwidth=80                        "横幅制限とハイライト
if exists('&colorcolumn')
    set colorcolumn=+1
endif

"UI
set title           "タイトルバーに名前を表示   
set laststatus=2 
set number          "行ナンバーの表示
set tabstop=4       "１タブがスペース４個分
set shiftwidth=4    "インデントがスペース４個分
set expandtab       "タブの代わりにスペースを入れる
set softtabstop=4   "タブキーを押したときに挿入される空白の数
set smarttab        "shiftwidhに合わせてインデントする
"set ruler          "カーソルが何行目の何列目に置かれているか

"General
set nocompatible    "VimをなるべくVi互換にする
set history=50      "コロンコマンドを記録する数

" 開いていた行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe
"normal g`\"" | endif

"Search
set ignorecase      "大文字小文字を区別しない
set smartcase       "大文字なら小文字を無視しない設定
set wrapscan        "検索後、ファイルの先頭へループする
set hlsearch        "検索結果をハイライトする
set noincsearch     "インクリメンタルサーチ

"File System
set nobackup        "バックアップファイルを作らない

"Cursor & Key bind
set whichwrap=b,s,h,l,<,>,[,]   "端から行へのカーソル移動
set backspace=indent,eol,start  "BSでインデントや改行を削除

" Escapeを近くする (IMEオフはkeyRemap4MacBookで設定）
imap <C-j> <Esc>
vmap <C-j> <Esc>
"その行を削除する Eclipse風
imap <C-d> <esc>dd k$a<return><esc>i

" vimのWindow系機能
nmap <C-w>c :tabnew <CR> 
nmap <C-w>n :tabn <CR> 
nmap <C-w>v :sp <CR>
nmap <C-w>S :sp <CR>
nmap <C-w>V :vs <CR>
nmap <C-w>y <C-w>><C-w>><C-w>>
nmap <C-w>i <C-w>-<C-w>-<C-w>-
nmap <C-w>o <C-w><<C-w><<C-w><
nmap <C-w>u <C-w>+<C-w>+<C-w>+

"--NeoBundle--"
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" Bundle
NeoBundle 'Shougo/neobundle.vim'

"Perl/Document
NeoBundle 'petdance/vim-perl'
NeoBundle 'hotchpotch/perldoc-vim'
NeoBundle 'thinca/vim-ref'

"CompleCache
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'vim-scripts/Highlight-UnMatched-Brackets'

"Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'ujihisa/unite-locate'
NeoBundle 'ujihisa/quicklearn'
NeoBundle 't9md/vim-unite-ack'
NeoBundle 'h1mesuke/unite-outline'

" Copy
NeoBundle 'yanktmp.vim'

" Filer/Search
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'

NeoBundle 'Shougo/vimshell'
NeoBundle 'kana/vim-tabpagecd'

"Git
NeoBundle 'tpope/vim-fugitive'

"JSX
NeoBundle 'git://github.com/jsx/jsx.vim.git'

" Text
NeoBundle 'tpope/vim-surround'
NeoBundle 'h1mesuke/textobj-wiw.git'
NeoBundle 'deris/vim-textobj-enclosedsyntax'
NeoBundle 'vimtaku/vim-textobj-sigil.git'
NeoBundle 'vimtaku/vim-textobj-doublecolon.git'
NeoBundle 'kana/vim-textobj-user.git'

"neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:neocomplcache_ctags_arguments_list = {
\ 'perl' : '-R -h ".pm"'
\ }
let g:neocomplcache_snippets_dir = "~/.vim/snippets"
let g:neocomplcache_dictionary_filetype_lists = {
\ 'default'    : '',
\ 'perl'       : $HOME . '/.vim/dict/perl.dict'
\ }
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" neocomplcache for snippets
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ?
"\<Plug>(neocomplcache_snippets_expand)" : "\<C-n>"
smap <C-k> <Plug>(neocomplcache_snippets_expand)
nnoremap <C-k> :vsp ~/.vim/snippets/perl.snip <return> 

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable()
?"\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable()
?"\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


" path にヘッダーファイルのディレクトリを追加することで
" neocomplcache が include 時に tag ファイルを作成してくれる
set path+=$LIBSTDCPP
set path+=$BOOST_LATEST_ROOT

" neocomplcache が作成した tag ファイルのパスを tags に追加する
function! s:TagsUpdate()
    " include している tag ファイルが毎回同じとは限らないので毎回初期化
    setlocal tags=
    for filename in
neocomplcache#sources#include_complete#get_include_files(bufnr('%'))
        execute "setlocal tags+=".neocomplcache#cache#encode_name('tags_output',
filename)
    endfor
endfunction


command!
    \ -nargs=? PopupTags
    \ call <SID>TagsUpdate()
    \ |Unite tag:<args>

function! s:get_func_name(word)
    let end = match(a:word, '<\|[\|(')
    return end == -1 ? a:word : a:word[ : end-1 ]
endfunction

" カーソル下のワード(word)で絞り込み
noremap <silent> g<C-]> :<C-u>execute "PopupTags ".expand('<cword>')<CR>

" カーソル下のワード(WORD)で ( か < か [ までが現れるまでで絞り込み
" 例)
" boost::array<std::stirng... → boost::array で絞り込み
noremap <silent> G<C-]> :<C-u>execute "PopupTags "
    \.substitute(<SID>get_func_name(expand('<cWORD>')), '\:', '\\\:', "g")<CR>

"superyank
map <silent> sy :call YanktmpYank()<CR> 
map <silent> sp :call YanktmpPaste_p()<CR> 
map <silent> sP :call YanktmpPaste_P()<CR>

"Quickrun
nmap qr <plug>(quickrun)

"Unite
nmap ;; :Unite
nmap ;s :Unite source<CR>
nmap ;b :Unite buffer<CR>
nmap ;f :Unite file<CR>
nmap ;m :Unite file_mru<CR>
nmap ;y :Unite register<CR>
nmap ;a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark
file<CR>
nmap ;r :Unite ref/
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"FuzzyFind
nmap ff :FufCoverageFile <CR>

let g:fuf_splitPathMatching = ' '
let g:fuf_patternSeparator = ' '
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.howm$'
let g:fuf_mrufile_maxItem = 10000
let g:fuf_enumeratingLimit = 20


"Vimfiler
nmap vf :VimFiler -split -simple -winwidth=35 -no-quit<CR>
"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0

"PerlTidy
map ,pt <Esc>:%! perltidy -se<CR>
map ,ptv <Esc>:'<,'>! perltidy -se<CR>

"surround
" dsX delete X
" csXY change from X to Y
" yssB "xx" => {"xx"}

"自動でプレビューを表示する。
let g:SrcExpl_RefreshTime = 1
"プレビューウインドウの高さ
let g:SrcExpl_WinHeight     = 9
"tagsは自動で作成する
let g:SrcExpl_UpdateTags    = 1
"マッピング
let g:SrcExpl_RefreshMapKey = "<Space>"
let g:SrcExpl_GoBackMapKey  = "<C-b>"
nnoremap <silent> <C-p> :SrcExplToggle<CR>

"パッケージのミスに気づく
function! s:get_package_name()
    let mx = '^\s*package\s\+\([^ ;]\+\)'
    for line in getline(1, 5)
        if line =~ mx
        return substitute(matchstr(line, mx), mx, '\1', '')
        endif
    endfor
    return ""
endfunction

function! s:check_package_name()
    let path = substitute(expand('%:p'), '\\', '/', 'g')
    let name = substitute(s:get_package_name(), '::', '/', 'g') . '.pm'
    if path[-len(name):] != name
        echohl WarningMsg
        echomsg "パッケージ名と保存されているパスが違う気がします。"
        echohl None
    endif
endfunction
au! BufWritePost *.pm call s:check_package_name()

"restart
map <C-g> :! ~/common/script/dev/all_local_restart.sh <Enter>

"QuickFix
:nnoremap <buffer> <silent> Z :w<Enter>:!/usr/bin/perl -c -MVi::QuickFix
%<Enter>

" filetype
filetype plugin indent off
syntax on

