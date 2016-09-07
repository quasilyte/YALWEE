%macro @dec_ops 0
  @expand_r? @op_dec_r?_by_1
  @op_dec_cx_by_1 
  @expand_r? @op_dec_r0_by_r?
  @expand_r? @op_dec_cx_by_r?
  @expand_r?_imm? @op_dec_r?_by_imm?
  @expand_imm? @op_dec_cx_by_imm?
  @expand_r? @op_decrev_r0_by_r?
  @expand_r?_imm? @op_decrev_r?_by_imm?
%endmacro

%macro @op_dec_r?_by_1 1
  @gen_op dec_r%1_by_1, {dec R%1}
%endmacro

%macro @op_dec_cx_by_1 0
  @gen_op dec_cx_by_1, {dec CX}
%endmacro

%macro @op_dec_r0_by_r? 1
  @gen_op dec_r0_by_r%1, {sub ACC, R%1}
%endmacro

%macro @op_dec_cx_by_r? 1
  @gen_op dec_cx_by_r%1, {sub CX, R%1}
%endmacro

%macro @op_dec_r?_by_imm? 2
  @op_begin dec_r%1_by_imm%2
    consume_imm%2 rax
    sub R%1, rax
  @op_end
%endmacro

%macro @op_dec_cx_by_imm? 1
  @op_begin dec_cx_by_imm%1
    consume_imm%1 rax
    sub CX, rax
  @op_end
%endmacro

%macro @op_decrev_r0_by_r? 1
  @op_begin decrev_r0_by_r%1
    sub ACC, R%1
    neg ACC
  @op_end
%endmacro

%macro @op_decrev_r?_by_imm? 2
  @op_begin decrev_r%1_by_imm%2
    consume_imm%2 rax
    sub R%1, rax
    neg R%1
  @op_end
%endmacro
