%macro @inc_ops 0
  @each_r @op_inc_r?_by_1
  @op_inc_cx_by_1 
  @each_r @op_inc_r0_by_r?
  @each_r @op_inc_cx_by_r?
  @each_r_and_imm @op_inc_r?_by_imm?
  @each_imm @op_inc_cx_by_imm?
%endmacro

%macro @op_inc_r?_by_1 1
  @@op_inc_r%1_by_1:
    inc R%1
    @next_op
%endmacro

%macro @op_inc_cx_by_1 0
  @@op_inc_cx_by_1:
    inc CX
    @next_op
%endmacro

%macro @op_inc_r0_by_r? 1
  @@op_inc_r0_by_r%1:
    add ACC, R%1
    @next_op
%endmacro

%macro @op_inc_cx_by_r? 1
  @@op_inc_cx_by_r%1:
    add CX, R%1
    @next_op
%endmacro

%macro @op_inc_r?_by_imm? 2
  @@op_inc_r%1_by_imm%2:
    consume_imm%2 rax
    add R%1, rax
    @next_op
%endmacro

%macro @op_inc_cx_by_imm? 1
  @@op_inc_cx_by_imm%1:
    consume_imm%1 rax
    add CX, rax
    @next_op
%endmacro
