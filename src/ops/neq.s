%macro @neq_ops 0
  @expand_range @op_neq_r0_r?, 1, 7
%endmacro

%macro @neq_r0_r? 1
  cmp R0, R%1
  setne cl
%endmacro

%macro @op_neq_r0_r? 1
  @gen_op neq_r0_r%1, {@neq_r0_r? %1}
%endmacro