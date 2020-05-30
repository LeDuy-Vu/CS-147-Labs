# Hello, World!
.data                     # Data section
  out_string:   .asciiz   "\nHello, World!\n"  # String to be printed:

.text                     # Assembly language instructions go in the text segment
main:                     # Start of code section
  li   $v0, 4             # system call code (4) for printing a string 
  la   $a0,   out_string  # load address of string to be printed into $a0
  syscall                 # call operating system to perform operation specified in $v0
                          # syscall takes its arguments from $a0, $a1, ...
  li   $v0,   10          # syscall code (10) to terminate the program
  syscall