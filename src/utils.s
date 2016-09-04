%macro consume_imm8 1
  movsx %1, byte [IP]
  inc IP
%endmacro

%macro consume_imm32 1
  movsx %1, dword [IP]
  add IP, 4
%endmacro

%macro consume_imm64 1
  mov %1, qword [IP]
  add IP, 8
%endmacro