%macro @smul_r?_const? 2
  ;; #TODO: this can be specialized based on %2 value (which is constant)
  %if %2 = 0
    xor %1, %1 
  %else
    imul %1, %2  
  %endif
%endmacro

%define @smul_r?_r?(a, b) imul a, b
%define @smul_r?_int?(a, b) imul a, b
