let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Code/LMark
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +73 main.cpp
badd +410 strops.cpp
badd +32 strops.h
badd +1 term:///mnt/d/Code/LatexNotes//8472:/bin/bash
badd +3 build.sh
badd +21 test.lmark
badd +2212 /mnt/d/Code/Astro8-Computer/Astro8-Emulator/main.cpp
badd +2 term:///mnt/d/Code/LatexMarkdown//392:/bin/bash
badd +28 ~/.config/nvim/init.vim
badd +2 test.tex
badd +1 term:///mnt/d/Code/LatexMarkdown//5324:/bin/bash
badd +19 lmarkhome.lmark
badd +1 lmarkhome.tex
badd +1 term:///mnt/d/Code/LatexMarkdown//9261:/bin/bash
badd +1 examples/test.lmark
badd +1 examples/lmarkhome.lmark
badd +3 examples/lmarkhome.tex
badd +9 term:///mnt/d/Code/LatexMarkdown//653:/bin/bash
badd +0 term://~/Code/LMark//758630:/bin/bash
argglobal
%argdel
$argadd main.cpp
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit main.cpp
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 28 + 21) / 42)
exe '2resize ' . ((&lines * 10 + 21) / 42)
argglobal
setlocal fdm=expr
setlocal fde=b:anyfold_ind_buffer[v:lnum-1]
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
9
normal! zo
11
normal! zo
12
normal! zo
24
normal! zo
30
normal! zo
45
normal! zo
59
normal! zo
73
normal! zo
87
normal! zo
129
normal! zo
160
normal! zo
168
normal! zo
176
normal! zo
185
normal! zo
190
normal! zo
let s:l = 28 - ((10 * winheight(0) + 14) / 28)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 28
normal! 05|
wincmd w
argglobal
if bufexists(fnamemodify("term://~/Code/LMark//758630:/bin/bash", ":p")) | buffer term://~/Code/LMark//758630:/bin/bash | else | edit term://~/Code/LMark//758630:/bin/bash | endif
if &buftype ==# 'terminal'
  silent file term://~/Code/LMark//758630:/bin/bash
endif
balt term:///mnt/d/Code/LatexMarkdown//5324:/bin/bash
setlocal fdm=manual
setlocal fde=b:anyfold_ind_buffer[v:lnum-1]
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 84 - ((9 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 84
normal! 025|
wincmd w
exe '1resize ' . ((&lines * 28 + 21) / 42)
exe '2resize ' . ((&lines * 10 + 21) / 42)
tabnext
edit strops.h
argglobal
balt main.cpp
setlocal fdm=expr
setlocal fde=b:anyfold_ind_buffer[v:lnum-1]
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 48 - ((25 * winheight(0) + 19) / 39)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 48
normal! 078|
tabnext
edit examples/test.lmark
argglobal
balt test.lmark
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 19) / 39)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit examples/lmarkhome.lmark
argglobal
balt lmarkhome.lmark
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 19) / 39)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit examples/lmarkhome.tex
argglobal
balt term:///mnt/d/Code/LatexMarkdown//653:/bin/bash
setlocal fdm=expr
setlocal fde=b:anyfold_ind_buffer[v:lnum-1]
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 19) / 39)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit term:///mnt/d/Code/LatexMarkdown//9261:/bin/bash
argglobal
balt lmarkhome.lmark
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 19) / 39)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit ~/.config/nvim/init.vim
argglobal
balt test.lmark
setlocal fdm=expr
setlocal fde=b:anyfold_ind_buffer[v:lnum-1]
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 28 - ((20 * winheight(0) + 19) / 39)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 28
normal! 0
tabnext
edit strops.cpp
argglobal
balt main.cpp
setlocal fdm=expr
setlocal fde=b:anyfold_ind_buffer[v:lnum-1]
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
14
normal! zo
28
normal! zo
32
normal! zo
35
normal! zo
53
normal! zo
73
normal! zo
86
normal! zo
106
normal! zo
155
normal! zo
165
normal! zo
169
normal! zo
176
normal! zo
192
normal! zo
201
normal! zo
210
normal! zo
226
normal! zo
234
normal! zo
253
normal! zo
263
normal! zo
266
normal! zo
267
normal! zo
282
normal! zo
291
normal! zo
308
normal! zo
314
normal! zo
327
normal! zo
334
normal! zo
363
normal! zo
370
normal! zo
377
normal! zo
388
normal! zo
393
normal! zo
402
normal! zo
406
normal! zo
407
normal! zo
410
normal! zo
412
normal! zo
428
normal! zo
434
normal! zo
447
normal! zo
456
normal! zo
466
normal! zo
469
normal! zo
476
normal! zo
485
normal! zo
488
normal! zo
492
normal! zo
502
normal! zo
505
normal! zo
522
normal! zo
534
normal! zo
546
normal! zo
558
normal! zo
571
normal! zo
587
normal! zo
593
normal! zo
595
normal! zo
let s:l = 410 - ((18 * winheight(0) + 19) / 39)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 410
normal! 013|
tabnext 1
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
