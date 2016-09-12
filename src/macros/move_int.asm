%macro move_int 2
  %define %%dst  %[%1]  
  %define %%size %[%2]

  %if %%size = 8
    movsx %[%%dst]64, ptr8 [IP]
  %elif %%size = 16
    movsx %[%%dst]64, ptr16 [IP]
  %elif %%size = 32
    movsx %[%%dst]64, ptr32 [IP]
  %elif %%size = 64
    mov %[%%dst]64, ptr64 [IP]
  %else
    %error %[size_error(%%size)]
  %endif
%endmacro
