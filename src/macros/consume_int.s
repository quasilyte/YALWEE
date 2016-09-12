%macro consume_int 2
  %if size_is_valid(%1)
    consume_int%1 %2
  %else
    %error %[size_error(%1)]
  %endif  
%endmacro

%macro consume_int8 1
  move_int8 %1
  add IP, 1
%endmacro

%macro consume_int16 1
  move_int16 %1
  add IP, 2
%endmacro

%macro consume_int32 1
  move_int32 %1
  add IP, 4
%endmacro

%macro consume_int64 1
  move_int64 %1
  add IP, 8
%endmacro