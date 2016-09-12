%macro @test_lt_?_? 2
  cmp %1, %2 
  setl cl
%endmacro

%macro @test_lt_r?_r? 2
  @#assert_symbolic_diff %1, %2
  @test_lt_?_? %1, %2
%endmacro

%define @test_lt_r?_const?(a, b) @test_lt_?_? a, b
%define @test_lt_r?_int?(a, b)   @test_lt_?_? a, b
%define @test_lt_r?_uint?(a, b)  @test_lt_?_? a, b