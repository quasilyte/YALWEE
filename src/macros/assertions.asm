;; Ensure given expression is true
%macro @#assert 1
  %if !(%[%1])
    %fatal assertion (%[%1]) failed
  %endif
%endmacro

%macro @#assert_nz 1
  %if %1 = 0
    %fatal zero assertion failed
  %endif
%endmacro

%macro @#assert_numeric_diff 2
  %if %1 = %2
    %error numeric diff assertion failed (arg = %[%1])
  %endif
%endmacro

%macro @#assert_symbolic_diff 2
  %defstr %%a_str %1
  %defstr %%b_str %2

  %if %%a_str = %%b_str
    %error symbolic diff assertion failed (arg = %[%1])
  %endif
%endmacro 

%macro @#validate_size 1
  %if !size_is_valid(%1)
    %fatal size validation failed (%[%1])
  %endif
%endmacro

%macro @#validate_int_arg 1
  @#validate_size %1
%endmacro

%macro @#validate_uint_arg 1
  @#validate_size %1
%endmacro

%macro @#validate_const_arg 1
  %ifnnum %1
    %fatal only numeric value is allowed for const (%[%1] given)    
  %endif
%endmacro

%macro @#validate_r_arg 1
  %if %1 < 0
    %fatal register index underflow (%[%1] < 0)
  %elif %1 > 8
    %fatal register index overflow (%[%1] > 8)
  %endif
%endmacro