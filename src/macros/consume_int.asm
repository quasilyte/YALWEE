%macro consume_int 2
  move_int %1, %2
  add IP, (%2 / 8) 
%endmacro
