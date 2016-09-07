%macro @neq_ops 0
  @expand_range @op_neq_r0_r?, 1, 7
%endmacro

%macro @op_neq_r0_r? 1
  @op_begin neq_r0_r%1
    cmp R0, R%1
    setne cl
  @op_end 
%endmacro