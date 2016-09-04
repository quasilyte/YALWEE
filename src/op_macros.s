%macro @next_op 0
  movzx rax, word [rdi]
  add rdi, 2 ;; each opcode is 2 bytes wide
  jmp [$op_table+(rax*8)]
%endmacro 

%macro @each 1-2 R_COUNT
  %assign i 0

  %rep %2
    %1 i 
    %assign i i+1
  %endrep
%endmacro

%macro read_imm8 1
  mov %1, byte [IP]
  inc IP
%endmacro

%macro read_imm32 1
  mov %1, dword [IP]
  add IP, 4
%endmacro

%macro read_imm64 1
  mov %1, qword [IP]
  add IP, 8
%endmacro