%macro @logical_ops 0
  @expand_range @op_eq_r0_r?, 1, 7
  @expand_range @op_neq_r0_r?, 1, 7
  @expand_range @op_lt_r0_r?, 1, 7
  @expand_range @op_gt_r0_r?, 1, 7
  @expand_range @op_lte_r0_r?, 1, 7
  @expand_range @op_gte_r0_r?, 1, 7
%endmacro

%macro @op_eq_r0_r? 1
  @op_begin eq_r0_r%1
    cmp R0, R%1
    sete cl
  @op_end
%endmacro

%macro @op_neq_r0_r? 1
  @op_begin neq_r0_r%1
    cmp R0, R%1
    setne cl
  @op_end 
%endmacro

%macro @op_lt_r0_r? 1
  @op_begin lt_r0_r%1
    cmp R0, R%1
    setl cl
  @op_end
%endmacro

%macro @op_gt_r0_r? 1
  @op_begin gt_r0_r%1
    cmp R0, R%1
    setg cl
  @op_end
%endmacro

%macro @op_lte_r0_r? 1
  @op_begin lte_r0_r%1
    cmp R0, R%1
    setle cl
  @op_end
%endmacro

%macro @op_gte_r0_r? 1
  @op_begin gte_r0_r%1
    cmp R0, R%1
    setge cl
  @op_end
%endmacro