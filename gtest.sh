#!/bin/bash

DIR=/mnt/c/dev/wall/gtest
MAIN=/mnt/c/dev/wall
BUILD=$MAIN/build-tsx_root-TSX-Debug
WALL=$MAIN/tsx_wall

TEST=$BUILD/tsx_common/tests/tst_imagedownloadmanager/release/test_imagedownloadmanager.exe

set -e

mkdir -p $DIR
rm -rf $DIR/*.dll

echo "cp $TEST $DIR"
rm -rf $DIR/$TEST
cp $TEST $DIR

echo "cp $BUILD/bin/tsx_common.dll $DIR"
cp $BUILD/bin/tsx_*.dll $DIR

echo "cp $WALL/deps_stage/bin/Qt5*.dll $DIR"
cp $WALL/deps_stage/bin/*.dll $DIR

cd $DIR
#echo "$TEST --gtest_list_tests"
#$TEST --gtest_list_tests


for f in {1..1000}; do
    res=$($TEST --gtest_filter=ImageDownloadManagerTest.* 2>/dev/null | grep -E 'PASSED|FAIL')
    echo $f : $res
done
