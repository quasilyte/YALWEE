%macro @lt_ops 0
  @expand_range @op_lt_r0_r?, 1, 7
%endmacro

%macro @op_lt_r0_r? 1
  @op_begin lt_r0_r%1
    cmp R0, R%1
    setl cl
  @op_end
%endmacro