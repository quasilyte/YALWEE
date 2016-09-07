%macro @bitand_ops 0
  @expand_r? @op_bitand_r0_by_r? 
  @expand_imm? @op_bitand_r0_by_imm?
%endmacro

%macro @op_bitand_r0_by_r? 1
  @gen_op bitand_r0_by_r%1, {and R0, R%1}
%endmacro

%macro @op_bitand_r0_by_imm? 1
  @op_begin bitand_r0_by_imm%1
    consume_imm%1 rax
    and R0, rax
  @op_end
%endmacro