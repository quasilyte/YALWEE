%macro @gen_op 2
  @@op_%1:
    @@op_%1_begin:
      %2
    @@op_%1_end:
      @next_op
%endmacro

%macro @op_begin 1
  %define .op_name %1
  @@op_%1:
    @@op_%1_begin:
%endmacro

%macro @op_end 0
    @@op_%[.op_name]_end:
      @next_op
%endmacro