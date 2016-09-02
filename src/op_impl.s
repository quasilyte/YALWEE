%macro @acc_add_r 1
  add ACC, R%1 
%endmacro

%macro @acc_load_r 1
  mov ACC, R%1
%endmacro

%macro @acc_save_r 1
  mov R%1, ACC
%endmacro

%macro @reset_r 1
  xor R%1, R%1
%endmacro

%macro @inc_r 1
  inc R%1
%endmacro

%macro @dec_r 1
  dec R%1
%endmacro

%macro @move_r0_to_r 1
  mov R%1, R0
%endmacro

%macro @move_r1_to_r 1
  mov R%1, R1
%endmacro

%macro @move_r2_to_r 1
  mov R%1, R2
%endmacro

%macro @move_8_to_r 1
  movzx rax, byte [rdi]
  inc rdi
  add R%1, rax 
%endmacro

%macro @move_16_to_r 1
  mov ax, word [rdi]
  add rdi, 2
  add R%1x16, ax 
%endmacro

%macro @move_32_to_r 1
  mov eax, dword [rdi]
  add rdi, 4
  add R%1x32, eax 
%endmacro

%macro @move_64_to_r 1
  mov rax, qword [rdi]
  add rdi, 8
  add R%1, rax 
%endmacro
