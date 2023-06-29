#!/bin/bash
echo $1
echo $2
echo $3
echo $4
echo $5

TOOL_NAME=PYRAT
CATEGORY=$2
ONNX_FILE=$3
VNNLIB_FILE=$4
RESULTS_FILE=$5
TIMEOUT=$6

echo "Running $TOOL_NAME for benchmark instance in category '$CATEGORY' with onnx file '$ONNX_FILE' and vnnlib file
 '$VNNLIB_FILE' and timeout '$TIMEOUT'. Writing to '$RESULTS_FILE'"

python pyrat.pyc --model_path $ONNX_FILE --vnnlib_path $VNNLIB_FILE --timeout $TIMEOUT