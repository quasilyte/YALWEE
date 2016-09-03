#!/bin/bash

ruby ./scripts/gen_op_enum.rb |
    awk 'BEGIN { print ";; this file was generated, do not edit by hand"} 
         {print "dq @@op_"$0}' > \
        src/op_labels.s
          
