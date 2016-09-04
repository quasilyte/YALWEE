%macro @next_op 0
  movzx rax, word [rdi]
  add rdi, 2 ;; each opcode is 2 bytes wide
  jmp [$op_table+(rax*8)]
%endmacro 

%macro @each_r 1-2 R_COUNT
  %assign i 0

  %rep %2
    %1 i 
    %assign i i+1
  %endrep
%endmacro

%macro @each_r_and_imm 1-2 R_COUNT
  %assign i 0

  %rep %2
    %1 i, 8
    %1 i, 32
    %1 i, 64

    %assign i i+1
  %endrep
%endmacro

%macro @each_curry 2-*
  %define m %1
  %define c %2
  %rotate 2

  %rep %0-2
    %[m] %[c], %1

    %rotate 1
  %endrep
%endmacro

%macro @each 1-*
  %define m %1
  %rotate 1

  %rep %0-1
    %[m] %1

    %rotate 1
  %endrep
%endmacro

%macro @each_imm 1
  %1 8
  %1 32
  %1 64
%endmacro