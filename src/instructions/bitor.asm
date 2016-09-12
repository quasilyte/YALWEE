%macro @bitor_r?_int? 2
  consume_int C, %2
  or R%1, C64
%endmacro

%macro @bitor_r?_uint? 2
  consume_uint C, %2
  or R%1, C64
%endmacro

%define @bitor_r?_const?(a, b) or R%+a, b
%define @bitor_r?_r?(a, b)     or R%+a, R%+b
