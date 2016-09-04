#!/bin/bash

op_enum_path='tmp/op_enum.txt'
s_labels='src/op_labels.s'
c_mnemonics='include/c_api/mnemonics.h'

ruby ./scripts/gen_op_enum.rb > $op_enum_path

echo "generating $s_labels"
awk -f scripts/op_enum_to_labels.awk "$op_enum_path" > "$s_labels"

echo "generating $c_mnemonics"
awk -f scripts/op_enum_to_mnemonics.awk "$op_enum_path" > "$c_mnemonics"
          
echo 'done'
rm "$op_enum_path"
