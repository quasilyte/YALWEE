%macro @dec_ops 0
  @each_r @op_dec_r?_by_1
  @op_dec_cx_by_1 
  @each_r @op_dec_r0_by_r?
  @each_r @op_dec_cx_by_r?
  @each_r_and_imm @op_dec_r?_by_imm?
  @each_imm @op_dec_cx_by_imm?
  @each_r @op_decrev_r0_by_r?
  @each_r_and_imm @op_decrev_r?_by_imm?
%endmacro

%macro @op_dec_r?_by_1 1
  @@op_dec_r%1_by_1:
    dec R%1
    @next_op
%endmacro

%macro @op_dec_cx_by_1 0
  @@op_dec_cx_by_1:
    dec CX
    @next_op
%endmacro

%macro @op_dec_r0_by_r? 1
  @@op_dec_r0_by_r%1:
    sub ACC, R%1
    @next_op
%endmacro

%macro @op_dec_cx_by_r? 1
  @@op_dec_cx_by_r%1:
    sub CX, R%1
    @next_op
%endmacro

%macro @op_dec_r?_by_imm? 2
  @@op_dec_r%1_by_imm%2:
    consume_imm%2 rax
    sub R%1, rax
    @next_op
%endmacro

%macro @op_dec_cx_by_imm? 1
  @@op_dec_cx_by_imm%1:
    consume_imm%1 rax
    sub CX, rax
    @next_op
%endmacro

%macro @op_decrev_r0_by_r? 1
  @@op_decrev_r0_by_r%1:
    sub ACC, R%1
    neg ACC
    @next_op
%endmacro

%macro @op_decrev_r?_by_imm? 2
  @@op_decrev_r%1_by_imm%2:
    consume_imm%2 rax
    sub R%1, rax
    neg rax
    @next_op
%endmacro
