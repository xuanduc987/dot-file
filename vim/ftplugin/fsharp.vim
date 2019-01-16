setlocal softtabstop=4 shiftwidth=4

vmap <C-c><C-c> <Plug>SendSelectionToTmux:call SendToTmux(";;\r")<CR>
nmap <C-c><C-c> <Plug>NormalModeSendToTmux:call SendToTmux(";;\r")<CR>

