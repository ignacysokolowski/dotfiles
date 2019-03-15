setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal colorcolumn=80,100
setlocal foldnestmax=2

" Create class
let @c='yiw[[Oclass pa:pass2kw'

" Create method
let @m='f("zyi(2byiwF.b d/^$odef pA(self, "zpa) -> None:V:s/, )/)/geopassk_:noh'

" Implement an abstract class and put it in the buffer
let @i='y]]Pwywf)PdT(0v]]:g/abstractmethod/d?classwwiImpl0d]]'

" Add getter for __init__ argument under cursor
let @g='_"zy$}ko"zp>>Idef w"zywo	return self._"zpkF:s(self) ->$r:'

" Extract variable (the value needs to be visually selected)
let @v='cvarOvar = p'

" Auto import
nmap <silent> <leader>i :ImportName<CR>

" Sort imports
nmap <silent> <leader>I :!make sort-imports<CR>
