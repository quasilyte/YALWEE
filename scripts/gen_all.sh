#!/bin/bash

op_enum_path='tmp/op_enum.txt'
s_op_labels='src/generated/op_labels.s'
s_op_sizes='src/generated/op_sizes.s'
c_mnemonics='include/c_api/mnemonics.h'

ruby ./scripts/gen_op_enum.rb > $op_enum_path

echo "generating $s_op_labels"
awk -f scripts/op_enum_to_labels.awk "$op_enum_path" > "$s_op_labels"

echo "generating $s_op_sizes"
awk -f scripts/op_enum_to_sizes.awk "$op_enum_path" > "$s_op_sizes"

echo "generating $c_mnemonics"
awk -f scripts/op_enum_to_mnemonics.awk "$op_enum_path" > "$c_mnemonics"
          
echo 'done'
rm "$op_enum_path"
