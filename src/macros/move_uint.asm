%macro move_uint8 1  
  movzx %1, byte [IP]
%endmacro

%macro move_uint16 1  
  movzx %1, word [IP]
%endmacro

%macro move_uint32 1  
  movzx %1, dword [IP]
%endmacro

%macro move_uint64 1  
  mov %1, qword [IP]
%endmacro
