%macro @jump_rel_if_int? 1
  jecxz %%jump_noop
  add IP, %1
  %%jump_noop:
%endmacro