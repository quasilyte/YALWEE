%macro @neg_ops 0
  @each_r @op_neg_r?
%endmacro

%macro @op_neg_r? 1
  @@op_neg_r%1:
    neg R%1
    @next_op
%endmacro
