%macro @experimental_ops 0
  @@op_xp:
  @@op_xp_begin:
    ;; cmp R3, R4
    ;; jne nomove
    ;;  mov R3, R4
    ;; nomove:

    cmp R3, R4
    cmove R3, R4
  Continue:
  @@op_xp_end:
    @next_op
%endmacro
