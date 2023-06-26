" Emulate Tab Switching https://vimhelp.org/tabpage.txt.html#gt
" requires Cycle Through Panes Plugins https://obsidian.md/plugins?id=cycle-through-panes
exmap tabnext obcommand cycle-through-panes:cycle-through-panes
nmap gt :tabnext
exmap tabprev obcommand cycle-through-panes:cycle-through-panes-reverse
nmap gT :tabprev

exmap splitVertical obcommand workspace:split-vertical
nmap <C-w>v :splitVertical

exmap splitHorizontal obcommand workspace:split-horizontal
nmap <C-w>s :splitHorizontal

exmap focusRight obcommand editor:focus-right
nmap <C-l> :focusRight

exmap focusLeft obcommand editor:focus-left
nmap <C-h> :focusLeft

exmap focusTop obcommand editor:focus-top
nmap <C-k> :focusTop

exmap focusBottom obcommand editor:focus-bottom
nmap <C-j> :focusBottom

unmap <Space>
exmap openSwitcher obcommand switcher:open
nmap <Space>pf :openSwitcher
