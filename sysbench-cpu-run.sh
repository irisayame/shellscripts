#! /bin/bash

NUM_THREADS=$1
MAX_PRIME=$2

if [ "$NUM_THREADS" == "" ];
     echo "NEED input NUM_THREADS"
     exit 0
fi

if [ "$MAX_PRIME" == "" ];
     echo "NEED input MAX_PRIME"
     exit 0
fi



dstat --time --cpu --sys --load --proc --top-cpu --mem | tee dstat-`date "+%Y%m%d%H%M"`.log &
sleep 3

echo "sysbench --num-threads=$NUM_THREADS --test=cpu --cpu-max-prime=$MAX_PRIME run | tee sysbench-`date +%Y%m%d%H%M`.log"
sysbench --num-threads=$NUM_THREADS --test=cpu --cpu-max-prime=$MAX_PRIME run 2>&1 > "sysbench-`date "+%Y%m%d"`-cpu.log"
sleep 5

pid=`ps aux | grep dstat | awk -F" " '{print $2}'`
kill $pid

