%macro @jump_abs_uint? 1
  ;; #TODO: try lea IP, [%1 + $code_root]
  add %1, [$code_root]
  mov IP, %1
%endmacro