%macro @jump_abs_if_uint? 1
  jecxz %%jump_noop
  add %1, [$code_root]
  mov IP, %1
  %%jump_noop:
%endmacro