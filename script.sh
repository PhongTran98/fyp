#!/bin/bash
BASE_DIR=`pwd`
OUTPUT_DIR=`pwd`/"output"
WASM_DIR=`pwd`/"output/emcc_output"
WASMATI_DIR=`pwd`/"output/wasmati_output"
LOGIC_DIR=`pwd`/"logic"

TEST_FOLDER="$(pwd)/test/CWE416_Use_After_Free"
line="CWE416_Use_After_Free__return_freed_ptr_04"
TEST_GROUP=$(ls $TEST_FOLDER | grep -oP "$line.*\.c(pp)?" | xargs -r)
TEST_GROUP=$TEST_FOLDER/${TEST_GROUP// / $TEST_FOLDER/}

rm -rf $OUTPUT_DIR
mkdir -p $OUTPUT_DIR
mkdir -p $WASM_DIR
sudo docker run -v $BASE_DIR:$BASE_DIR -t emscripten/emsdk emcc $TEST_GROUP  $TEST_FOLDER/std_testcase_io.c -g2 -DINCLUDEMAIN -o $WASM_DIR/out.js 
cp $TEST_GROUP $OUTPUT_DIR

if [ ! -f $WASM_DIR/out.wasm ]; 
then
	echo $WASM_DIR/out.wasm not found, aborting...
	exit
fi
wasm2wat $WASM_DIR/out.wasm > $WASM_DIR/out.wat
sudo docker run -v $BASE_DIR:$BASE_DIR -t wasmati $WASM_DIR/out.wasm --datalog=$BASE_DIR/out.zip

if [ ! -f out.zip ]; 
then
	echo out.zip not found, aborting...
	exit
fi
mkdir -p $WASMATI_DIR
unzip out.zip -d $WASMATI_DIR > /dev/null
rm -f out.zip

#souffle --fact-dir=`pwd`/$WASMATI_DIR -D - logic/main.dl 
sudo docker run -v $BASE_DIR:$BASE_DIR -t souffle --fact-dir=$WASMATI_DIR -D - $LOGIC_DIR/main.dl