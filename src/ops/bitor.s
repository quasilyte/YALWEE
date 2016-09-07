%macro @bitor_ops 0
  @expand_r? @op_bitor_r0_by_r? 
  @expand_imm? @op_bitor_r0_by_imm?
%endmacro

%macro @op_bitor_r0_by_r? 1
  @gen_op bitor_r0_by_r%1, {or R0, R%1}
%endmacro

%macro @op_bitor_r0_by_imm? 1
  @op_begin bitor_r0_by_imm%1
    consume_imm%1 rax
    or R0, rax 
  @op_end
%endmacro