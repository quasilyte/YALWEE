%macro @jump_rel_if_int? 1
  consume_int C, %1
  jecxz %%jump_noop
  add IP, C64
  %%jump_noop:
%endmacro