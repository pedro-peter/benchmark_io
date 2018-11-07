#!/bin/bash
printf "env vars\n"
printf "work_dir=$work_dir\n"
printf "file_size=$file_size\n"
printf "time=$time\n"
printf "delay=$delay\n"

/benchmark_io --work-dir=$work_dir --file-size=$file_size --time=$time --delay=$delay
cat /tmp/sysbench/logs/*.log
exit 0
