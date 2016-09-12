%macro @jump_abs_uint? 1
  ;;; 1
  consume_uint C, %1
  add C64, [$code_root]
  mov IP, C64

  ;;; 2
  ;; consume_uint C, %1
  ;; lea IP, [$code_root + C64]
%endmacro