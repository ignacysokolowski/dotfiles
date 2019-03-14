setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal colorcolumn=80,100
setlocal foldnestmax=2

" Create class
let @c='yiw[[Oclass pa:pass2kw'

" Create method
nmap <buffer> gm yiwF.b<leader>d/^$<CR>odef <Esc>pA(self) -> None:<CR>pass<CR><Esc>k_

" Implement an abstract class and put it in the buffer
let @i='y]]Pwywf)PdT(0v]]:g/abstractmethod/d?classwwiImpl0d]]'
