#! /bin/bash

MEMORY_TOTAL_SIZE=$1
MEMORY_BLOCK_SIZE=$2

if [ "$MEMORY_TOTAL_SIZE" == "" ];
     echo "NEED input MEMORY_TOTAL_SIZE"
     exit 0
fi

if [ "$MEMORY_BLOCK_SIZE" == "" ];
     echo "NEED input MEMORY_BLOCK_SIZE"
     exit 0
fi

dstat --time --cpu --sys --load --proc --top-cpu --mem | tee dstat-`date "+%Y%m%d%H%M"`.log &
sleep 3

echo "sysbench --test=memory --memory-total-size=$MEMORY_TOTAL_SIZE --memory-block-size=$MEMORY_BLOCK_SIZE run | tee sysbench-`date +%Y%m%d%H%M`-memory-$MEMORY_TOTAL_SIZE-$MEMORY_BLOCK_SIZE.log" >> run-sysbench.log
sysbench --test=memory --memory-total-size=400G --memory-block-size=4G run 2>&1 > "sysbench-`date "+%Y%m%d%H%M"`-memory.log" 
sleep 5

pid=`ps aux | grep dstat | awk -F" " '{print $2}'`
kill $pid

