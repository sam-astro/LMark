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
badd +66 main.cpp
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
badd +1 term://~/Code/LMark//758630:/bin/bash
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
exe '1resize ' . ((&lines * 41 + 29) / 59)
exe '2resize ' . ((&lines * 14 + 29) / 59)
argglobal
setlocal fdm=expr
setlocal fde=b:anyfold_ind_buffer[v:lnum-1]
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
10
normal! zo
12
normal! zo
26
normal! zo
30
normal! zo
31
normal! zo
34
normal! zo
37
normal! zo
40
normal! zo
57
normal! zo
118
normal! zo
128
normal! zo
180
normal! zo
215
normal! zo
246
normal! zo
272
normal! zo
let s:l = 157 - ((24 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 157
normal! 024|
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
let s:l = 37 - ((13 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 37
normal! 0
wincmd w
exe '1resize ' . ((&lines * 41 + 29) / 59)
exe '2resize ' . ((&lines * 14 + 29) / 59)
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
let s:l = 48 - ((36 * winheight(0) + 28) / 56)
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
let s:l = 1 - ((0 * winheight(0) + 28) / 56)
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
let s:l = 1 - ((0 * winheight(0) + 28) / 56)
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
let s:l = 1 - ((0 * winheight(0) + 28) / 56)
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
let s:l = 1 - ((0 * winheight(0) + 28) / 56)
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
let s:l = 28 - ((27 * winheight(0) + 28) / 56)
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
287
normal! zo
290
normal! zo
291
normal! zo
306
normal! zo
332
normal! zo
351
normal! zo
358
normal! zo
387
normal! zo
395
normal! zo
415
normal! zo
422
normal! zo
429
normal! zo
440
normal! zo
454
normal! zo
458
normal! zo
462
normal! zo
464
normal! zo
480
normal! zo
486
normal! zo
499
normal! zo
501
normal! zo
518
normal! zo
528
normal! zo
537
normal! zo
540
normal! zo
554
normal! zo
557
normal! zo
562
normal! zo
586
normal! zo
let s:l = 413 - ((45 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 413
normal! 09|
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
