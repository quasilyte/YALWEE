%macro @sub_r?_const? 2
  @#assert_nz %2
  lea R%1, [R%1 - %2]
%endmacro

%macro @sub_r?_int? 2
  consume_int C, %2
  sub R%1, C64
%endmacro

%macro @sub_r?_uint? 2
  consume_uint C, %2
  sub R%1, C64
%endmacro

%define @sub_r?_r?(a, b) sub R%+a, R%+b
