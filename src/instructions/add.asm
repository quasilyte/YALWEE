%macro @add_r?_const? 2
  @#assert_nz %2
  lea R%1, [R%1 + %2]
%endmacro

%macro @add_r?_int? 2
  consume_int C, %2 
  add R%1, C64
%endmacro

%macro @add_r?_uint? 2
  consume_uint C, %2
  add R%1, C64
%endmacro

%define @add_r?_r?(a, b) add R%+a, R%+b
