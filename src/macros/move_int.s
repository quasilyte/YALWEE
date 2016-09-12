%macro move_int8 1  
  movsx %1, byte [IP]
%endmacro

%macro move_int16 1  
  movsx %1, word [IP]
%endmacro

%macro move_int32 1  
  movsx %1, dword [IP]
%endmacro

%macro move_int64 1  
  mov %1, qword [IP]
%endmacro
