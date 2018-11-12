#!/bin/bash
#sbt "test"
echo "starting compile"

sbt "run"

echo "cleaning up"
rm *.fir
rm *.json
mv *.v ../verilog_files/
echo "verilog files in verilog_files"


