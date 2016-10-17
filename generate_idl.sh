#!/bin/bash

runner='java -cp swift2thrift-generator-cli-0.16.0-standalone.jar:target/classes com.facebook.swift.generator.swift2thrift.Main'
namespace='-namespace php xxx'

one_dir='target/classes/xxx'
one_pck='com.xxx'
one_res='one.idl'
one=`ls -l $one_dir | grep ^- | awk '{print $NF}' | awk -F. 'BEGIN{c=""} {c=c""$1; c=c""" "} END{print c}'`
one_map=`ls -l $one_dir | grep ^- | awk '{print $NF}' | awk -F. 'BEGIN{c=""; one_pck="'$one_pck'"; one_res="'$one_res'"} {c=c""" -map "; c=c""one_pck; c=c"""."; c=c""$1; c=c""" "; c=c""one_res} END{print c}'`



two_dir='target/classes/xxx'

two_pck='com.xxx'
two_1_res='two_1.idl'
two_1=`ls -l $two_dir | grep ^- | awk '{print $NF}' | awk -F. 'BEGIN{c=""} {if($1 != "OrderDetailVo") {c=(c""$1); c=(c""" ");}} END {print c}'`
two_1_map=`ls -l $two_dir | grep ^- | awk '{print $NF}' | awk -F. 'BEGIN{c=""; two_pck="'$two_pck'"; two_1_res="'$two_1_res'"} {if($1 != "OrderDetailVo") {c=c""" -map "; c=c""two_pck; c=c"""."; c=c""$1; c=c""" "; c=c""two_1_res}} END {print c}'`

two_2_res='two_2.idl'
two_2=`ls -l $two_dir | grep ^- | awk '{print $NF}' | awk -F. 'BEGIN{c=""} {if($1 == "OrderDetailVo") {c=(c""$1); c=(c""" ");}} END {print c}'`

$runner -out $one_res -package $one_pck $one $namespace
$runner -out $two_1_res -package $two_pck $two_1 $namespace
$runner -out $two_2_res -package $two_pck $two_2 $one_map $two_1_map $namespace
