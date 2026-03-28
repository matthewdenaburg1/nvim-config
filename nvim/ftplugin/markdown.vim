" File: markdown.vim

setlocal spell
setlocal spelllang=en_us

" change the previous spelling error first suggestion
inoremap <c-l> <c-g>u<esc>[s1z=`]a<c-g>u

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0

setlocal textwidth=120
setlocal formatoptions=qn1p


" add hyperlinks manually... (source: https://stackoverflow.com/a/14284350)
inoremap <c-k> <esc>ciw[<c-r>"]()<esc>i
nnoremap <c-k> ciw[<c-r>"]()<esc>i
vnoremap <c-k> c[<c-r>"]()<esc>i

" add hyperlinks via paste
inoremap <c-s-k> <esc>ciw[<c-r>"](<esc>"*pa)<esc>a
nnoremap <c-s-k> ciw[<c-r>"](<esc>"*pa)<esc>
vnoremap <c-s-k> c[<c-r>"](<esc>"*pa)<esc>

setlocal commentstring=
