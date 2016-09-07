%macro @check_ops 0
  @expand_range @op_check_r0_eq_r?, 1, 7
  @expand_range @op_check_r0_neq_r?, 1, 7
  @expand_range @op_check_r0_lt_r?, 1, 7
  @expand_range @op_check_r0_gt_r?, 1, 7
  @expand_range @op_check_r0_lte_r?, 1, 7
  @expand_range @op_check_r0_gte_r?, 1, 7
%endmacro

%macro @op_check_r0_eq_r? 1
  @op_begin check_r0_eq_r%1
    cmp R0, R%1
    sete cl
  @op_end
%endmacro

%macro @op_check_r0_neq_r? 1
  @op_begin check_r0_neq_r%1
    cmp R0, R%1
    setne cl
  @op_end 
%endmacro

%macro @op_check_r0_lt_r? 1
  @op_begin check_r0_lt_r%1
    cmp R0, R%1
    setl cl
  @op_end
%endmacro

%macro @op_check_r0_gt_r? 1
  @op_begin check_r0_gt_r%1
    cmp R0, R%1
    setg cl
  @op_end
%endmacro

%macro @op_check_r0_lte_r? 1
  @op_begin check_r0_lte_r%1
    cmp R0, R%1
    setle cl
  @op_end
%endmacro

%macro @op_check_r0_gte_r? 1
  @op_begin check_r0_gte_r%1
    cmp R0, R%1
    setge cl
  @op_end
%endmacro