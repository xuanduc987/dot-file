if exists("current_compiler")
  finish
endif
let current_compiler = "minitest"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=rails\ test

CompilerSet errorformat=
  \%EFailure:,
  \%EError:,
  \%Z%.%\\+\ %f:%l,
  \%Z%.%\\+\ %f:%l:%m,
  \%Z%m\ [%f:%l]:,
  \%-C%m,
  \%C

let &cpo = s:cpo_save
unlet s:cpo_save
