%macro @test_gte_?_? 2
  cmp %1, %2 
  setge cl
%endmacro

%macro @test_gte_r?_r? 2
  @#assert_symbolic_diff %1, %2
  @test_gte_?_? %1, %2
%endmacro

%define @test_gte_r?_const?(a, b) @test_gte_?_? a, b
%define @test_gte_r?_int?(a, b)   @test_gte_?_? a, b
%define @test_gte_r?_uint?(a, b)  @test_gte_?_? a, b