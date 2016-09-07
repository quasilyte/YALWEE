%macro @inc_ops 0
  @expand_r? @op_inc_r?_by_1
  @op_inc_cx_by_1 
  @expand_r? @op_inc_r0_by_r?
  @expand_r? @op_inc_cx_by_r?
  @expand_r?_imm? @op_inc_r?_by_imm?
  @expand_imm? @op_inc_cx_by_imm?
%endmacro

%macro @op_inc_r?_by_1 1
  @gen_op inc_r%1_by_1, {inc R%1}
%endmacro

%macro @op_inc_cx_by_1 0
  @gen_op inc_cx_by_1, {inc CX} 
%endmacro

%macro @op_inc_r0_by_r? 1
  @gen_op inc_r0_by_r%1, {add ACC, R%1}
%endmacro

%macro @op_inc_cx_by_r? 1
  @gen_op inc_cx_by_r%1, {add CX, R%1}
%endmacro

%macro @op_inc_r?_by_imm? 2
  @op_begin inc_r%1_by_imm%2
    consume_imm%2 rax
    add R%1, rax
  @op_end
%endmacro

%macro @op_inc_cx_by_imm? 1
  @op_begin inc_cx_by_imm%1
    consume_imm%1 rax
    add CX, rax
  @op_end
%endmacro
