%macro @neg_ops 0
  @expand_r? @op_neg_r?
%endmacro

%macro @op_neg_r? 1
  @gen_op neg_r%1, {neg R%1}
%endmacro
