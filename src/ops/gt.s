%macro @gt_ops 0
  @expand_range @op_gt_r0_r?, 1, 7
%endmacro

%macro @op_gt_r0_r? 1
  @op_begin gt_r0_r%1
    cmp R0, R%1
    setg cl
  @op_end
%endmacro