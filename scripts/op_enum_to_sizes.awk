BEGIN {
  print ";; this file was generated, do not edit by hand"
}

/^for_*/ || /^jump_*/ || /.*imm(8|32|64).*/ {
  print "qd 0 ;; "$0; 
  next
}

{ print "dq (@@op_"$0"_end - @@op_"$0"_begin)" }