%macro consume_uint 2
  %if size_is_valid(%1)
    consume_uint%1 %2
  %else
    %error %[size_error(%1)]
  %endif  
%endmacro

%macro consume_uint8 1
  move_uint8 %1
  add IP, 1
%endmacro

%macro consume_uint16 1
  move_uint16 %1
  add IP, 2
%endmacro

%macro consume_uint32 1
  move_uint32 %1
  add IP, 4
%endmacro

%macro consume_uint64 1
  move_uint64 %1
  add IP, 8
%endmacro