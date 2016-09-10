%macro @mul_r?_const? 2
  @op mul_r%1_const%2, {imul R%1, %2}
%endmacro

%macro @mul_r?_r? 2
  @op mul_r%1_r%2, {imul R%1, R%2}
%endmacro

%macro @mul_r?_imm? 2
  @op_begin mul_r%1_imm%2
    consume_imm%2 rax
    imul R%1, rax
  @op_end
%endmacro