%macro consume_uint 2
  move_uint %1, %2
  add IP, (%2 / 8)
%endmacro
