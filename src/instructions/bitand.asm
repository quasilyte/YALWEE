%macro @bitand_r?_const? 2
  @#assert_nz %2
  and a, b
%endmacro

%macro @bitand_r?_int? 2
  consume_int C, %2
  and R%1, C64
%endmacro

%macro @bitand_r?_uint? 2
  consume_uint C, %2
  and R%1, C64
%endmacro

%define @bitand_r?_r?(a, b) and R%+a, R%+b
