
" TAB LABEL SCRIPT
function NumberedTabLine()
	let s = ''
	let label_maxlen = (&columns) / (tabpagenr('$'))
	for i in range(1, tabpagenr('$'))
		" Set highlighting of the current label
		if i == tabpagenr()
			let s .= '%#TabLineSel# %#TabLineSelSpec#' . (i) . '%#TabLineSel#'
		else
			let s .= '%#TabLine# %#TabLineSpec#' . (i) . '%#TabLine#'
		endif
		" Set the label text of this tab
		let s .= '%{TabName(' . (i) . ',' . (label_maxlen-3) . ')} '
	endfor
	" After last tab fill tabline 
	let s .= '%#TabLineFill#'
	return s
endfunction

function TabName(n, maxlen)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let full_name = bufname(buflist[winnr - 1])
	" let label = '' . (a:n)
	let label = ''
	if getbufvar(buflist[winnr-1], '&modified')
		let label .= '+'
	endif
	let label .= ' '
	let name = fnamemodify(full_name, ':t')
	if (strwidth(name) + strwidth(label)) > a:maxlen
		let name = strpart(name, (strwidth(name) + strwidth(label) - a:maxlen))
	endif
	let label .= name
	return label
endfunction

hi TabLineSpec term=underline cterm=underline ctermfg=3 ctermbg=0 gui=underline guibg=DarkGrey
hi TabLineSelSpec term=underline cterm=underline ctermfg=9 ctermbg=10 gui=bold
set tabline=%!NumberedTabLine()
