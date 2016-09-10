%macro move_imm8 1  
  movsx %1, byte [IP]
%endmacro

%macro move_imm16 1  
  movsx %1, word [IP]
%endmacro

%macro move_imm32 1  
  movsx %1, dword [IP]
%endmacro

%macro move_imm64 1  
  mov %1, qword [IP]
%endmacro
