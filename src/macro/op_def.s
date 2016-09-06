%macro @gen_op 2
  @@op_%1:
    @@op_%1_begin:
      %2
    @@op_%1_end:
      @next_op
%endmacro
