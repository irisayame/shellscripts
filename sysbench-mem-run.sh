#! /bin/bash

MEMORY_TOTAL_SIZE=$1
MEMORY_BLOCK_SIZE=$2

if [ "$MEMORY_TOTAL_SIZE" == "" ] ;then
     echo "NEED input MEMORY_TOTAL_SIZE"
     MEMORY_TOTAL_SIZE=10G
fi

if [ "$MEMORY_BLOCK_SIZE" == "" ] ;then
     echo "NEED input MEMORY_BLOCK_SIZE"
     MEMORY_BLOCK_SIZE=1G
fi

dstat --time --cpu --sys --load --proc --top-cpu --mem | tee dstat-memory-$MEMORY_TOTAL_SIZE-$MEMORY_BLOCK_SIZE-`date "+%Y%m%d%H%M"`.log &
sleep 3

echo "sysbench --test=memory --memory-total-size=$MEMORY_TOTAL_SIZE --memory-block-size=$MEMORY_BLOCK_SIZE run | tee sysbench-memory-$MEMORY_TOTAL_SIZE-$MEMORY_BLOCK_SIZE-`date +%Y%m%d%H%M`.log" >> run-sysbench.log
sysbench --test=memory --memory-total-size=$MEMORY_TOTAL_SIZE --memory-block-size=$MEMORY_BLOCK_SIZE run 2>&1 > "sysbench-memory-$MEMORY_TOTAL_SIZE-$MEMORY_BLOCK_SIZE-`date "+%Y%m%d%H%M"`.log" 
sleep 5

pid=`ps aux | grep dstat | awk -F" " '{print $2}'`
kill $pid

