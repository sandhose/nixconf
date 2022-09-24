" vim:fdm=marker

colorscheme gruvbox

" Plugin options {{{
" Highlight on yank
augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
" }}}

" Keybindings {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprev<CR>
nnoremap <Leader>p :!pandoc --pdf-engine=xelatex -o %:t:r.pdf %; open %:t:r.pdf<CR><CR>
vnoremap <Leader>s :!psql<CR>
nnoremap <Leader>m :set list!<CR>
nnoremap <Leader>jp :%!jq<CR>
nnoremap <Leader>k :RustOpenExternalDocs<CR>
nnoremap <C-p> :GFiles<CR>
nmap <Leader>b :NvimTreeToggle<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" }}}
