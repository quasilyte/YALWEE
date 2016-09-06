BEGIN {
  print ";; this file was generated, do not edit by hand"
}

/^jump_*/ || /.*imm(8|32|64).*/ || 
/^for_*/ || /break_for/ || /end_for_nz/ ||
/^prepare*/ || /^exec*/ {
  print "dq 0 ;; "$0; 
  next
}

{ print "dq (@@op_"$0"_end - @@op_"$0"_begin)" }