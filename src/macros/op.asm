%macro @op 2
  @@%1:
    @@%1_begin:
      %2
    @@%1_end:
      next_op
%endmacro

%macro @op_begin 1
  %define .op_name %1
  @@%1:
    @@%1_begin:
%endmacro

%macro @op_end 0
  @@%[.op_name]_end:
    next_op
%endmacro

%macro @?_r?_const? 3
  @op %1_r%2_const%3, {@macro_call @%1_r?_const?, %2, %3}
%endmacro

%macro @?_r?_r? 3
  @op %1_r%2_r%3, {@macro_call @%1_r?_r?, %2, %3}
%endmacro

%macro @?_r? 2
  @op %1_r%2, {@macro_call @%1_r?, %2}
%endmacro

%macro @?_int? 2
  @op %1_int%2, {@macro_call @%1_int?, %2}
%endmacro

%macro @?_uint? 2
  @op %1_uint%2, {@macro_call @%1_uint?, %2}
%endmacro

%macro @?_r?_int? 3
  @op %1_r%2_int%3, {@macro_call @%1_r?_int?, %2, %3}
%endmacro

%macro @?_r?_uint? 3
  @op %1_r%2_uint%3, {@macro_call @%1_r?_uint?, %2, %3}
%endmacro
