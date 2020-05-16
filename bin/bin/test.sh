#!/bin/sh
# Test script for random stuff

padding=10
a="asdf"
b="jkl"

echo ${#a}

result=$(printf "%-*s%s" $((${padding} - ${#a})) "$a" "$b" )
echo $result;
