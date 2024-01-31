let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd /mnt/d/Code/LatexMarkdown
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +184 main.cpp
badd +10 strops.cpp
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
exe '1resize ' . ((&lines * 40 + 24) / 48)
exe '2resize ' . ((&lines * 4 + 24) / 48)
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
19
normal! zo
82
normal! zo
121
normal! zo
147
normal! zo
153
normal! zo
161
normal! zo
175
normal! zo
let s:l = 132 - ((25 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 132
normal! 032|
wincmd w
argglobal
if bufexists(fnamemodify("term:///mnt/d/Code/LatexMarkdown//5324:/bin/bash", ":p")) | buffer term:///mnt/d/Code/LatexMarkdown//5324:/bin/bash | else | edit term:///mnt/d/Code/LatexMarkdown//5324:/bin/bash | endif
if &buftype ==# 'terminal'
  silent file term:///mnt/d/Code/LatexMarkdown//5324:/bin/bash
endif
balt main.cpp
setlocal fdm=manual
setlocal fde=b:anyfold_ind_buffer[v:lnum-1]
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 355 - ((3 * winheight(0) + 2) / 4)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 355
normal! 0
wincmd w
exe '1resize ' . ((&lines * 40 + 24) / 48)
exe '2resize ' . ((&lines * 4 + 24) / 48)
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
let s:l = 74 - ((40 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 74
normal! 036|
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
let s:l = 1 - ((0 * winheight(0) + 22) / 45)
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
let s:l = 37 - ((36 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 37
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
let s:l = 33 - ((31 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 33
normal! 0
tabnext
argglobal
if bufexists(fnamemodify("term:///mnt/d/Code/LatexMarkdown//9261:/bin/bash", ":p")) | buffer term:///mnt/d/Code/LatexMarkdown//9261:/bin/bash | else | edit term:///mnt/d/Code/LatexMarkdown//9261:/bin/bash | endif
if &buftype ==# 'terminal'
  silent file term:///mnt/d/Code/LatexMarkdown//9261:/bin/bash
endif
balt lmarkhome.lmark
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 27 - ((26 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 27
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
let s:l = 28 - ((23 * winheight(0) + 22) / 45)
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
164
normal! zo
173
normal! zo
189
normal! zo
197
normal! zo
216
normal! zo
226
normal! zo
229
normal! zo
230
normal! zo
245
normal! zo
254
normal! zo
271
normal! zo
277
normal! zo
290
normal! zo
297
normal! zo
326
normal! zo
333
normal! zo
340
normal! zo
351
normal! zo
356
normal! zo
365
normal! zo
371
normal! zo
384
normal! zo
393
normal! zo
403
normal! zo
406
normal! zo
413
normal! zo
422
normal! zo
425
normal! zo
429
normal! zo
439
normal! zo
442
normal! zo
459
normal! zo
471
normal! zo
483
normal! zo
495
normal! zo
508
normal! zo
524
normal! zo
530
normal! zo
532
normal! zo
let s:l = 338 - ((22 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 338
normal! 04|
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
