source ~/.gdb/peda/peda.py

# Intel for life
set disassembly-flavor intel
# For CTFs we're usually interested in the child process
set follow-fork-mode child
# Good for CTF fork-exec
set detach-on-fork no
