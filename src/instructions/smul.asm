%macro @smul_r?_const? 2
  ;; #TODO: this can be specialized based on %2 value (which is constant)
  %if %2 = 0
    xor %1, %1 
  %else
    imul %1, %2  
  %endif
%endmacro

%macro @smul_r?_int? 2
  consume_int C, %2
  imul R%1, C64
%endmacro

%define @smul_r?_r?(a, b) imul R%+a, R%+b
