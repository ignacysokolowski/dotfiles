setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal colorcolumn=80,100
setlocal foldnestmax=2

function! GoToEndOfVarValue()
  let nextIndentLine = NextIndentLine()
  if (nextIndentLine == line('.') + 1)
    let column = 0
  else
    let column = col('.') + 1
  endif
  exe nextIndentLine
  exe 'normal ' column '|'
endfunction

function! NextIndentLine()
  let line = line('.')
  let lastline = line('$')
  let indent = indent(line)
  while (line <= lastline)
    let line = line + 1
    if (indent(line) == indent && strlen(getline(line)) > 0)
      return line
    endif
  endwhile
endfunction

" Create class
let @c='yiw[[Oclass pa:pass2kw'

" Create method
let @m='f("zyi(2byiwF.b d/^$odef pA(self, "zpa) -> None:V:s/, )/)/geopassk_:noh'

" Extract method (the body needs to be visually selected)
let @x='cself._extracted_method()F.b d/^$Odef _extracted_method(self) -> None:<<p:nohggVG:s/_extracted_method/'

" Implement an abstract class and put it in the buffer
let @i='y]]Pwywf)PdT(0v]]:g/abstractmethod/d?classwwiImpl0d]]'

" Add getter for __init__ argument under cursor
let @g='_"zy$}ko"zp>>Idef w"zywo	return self._"zpkF:s(self) ->$r:'

" Extract variable (the value needs to be visually selected)
let @v='cvarOvar = p'

" Inline variable
let @n=' d2W"zd:call GoToEndOfVarValue()ddde"zP:noh'

" Add argument
let @a='yw[mf)i, pa: '

" Auto import
nmap <silent> <leader>i :ImportName<CR>

" Sort imports
nmap <silent> <leader>I :!make sort-imports<CR>
