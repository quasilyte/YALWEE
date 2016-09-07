%macro @swap_ops 0
  @expand_range @op_swap_r0_with_r?, 1, 7
%endmacro

%macro @op_swap_r0_with_r? 1
  @gen_op swap_r0_with_r%1, {xchg R0, R%1}
%endmacro