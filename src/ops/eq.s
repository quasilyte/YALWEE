%macro @eq_ops 0
  @expand_range @op_eq_r0_r?, 1, 7
%endmacro

%macro @eq_r0_r? 1
  cmp R0, R%1
  sete cl
%endmacro

%macro @op_eq_r0_r? 1
  @gen_op eq_r0_r%1, {@eq_r0_r? %1}
%endmacro