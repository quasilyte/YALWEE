%macro @jump_abs_if_uint? 1
  ;;; 1
  consume_uint C, %1
  jecxz %%jump_noop
  add C64, [$code_root]
  mov IP, C64
  %%jump_noop:

  ;;; 2
  ;; consume_uint C, %1
  ;; jecxz %%jump_noop
  ;; lea IP, [$code_root + C64]
  ;; %%jump_noop:
%endmacro