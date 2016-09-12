%macro @jump_rel_int? 1
  move_int C, %1
  lea IP, [IP + C64]
  ;; add IP, %1
%endmacro