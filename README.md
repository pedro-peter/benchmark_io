# benchmark_io - An example command line bash script

## Introduction

This repo demonstrates how to test a bash command line (benchmark_io) tool using docker. 

## benchmark_io usage

The command line tool is located in ./src/scripts/benchmark_io.  There is a detailed description of how the bash script works in this blog entry:   
https://www.peterstechblog.net/?p=1

The script demostrate how to:

- use bash functions & variables
- log with tty colours
- parse command line args
- detect Linux distros
- background a process and using a trap to stop the process if ^c is pressed

The script should run on any recent Centos or Ubuntu distibution.

Command line options & help:

```
./benchmark_io -h
benchmark_io [OPTION]... 

Script to run a sysbench random r/w & sequential file test.

The script runs a sysbench prepare command which creates a total of --file-size in --work-dir
By adding the --skip-cleanup file you can reuse these files for subsequent benchmarks
Use --cleanup to force the sysbench cleanup command
Each benchmark result is logged to --work-dir/[timestamp]_benchmark_io_result.log

 Options:
  -w, --work-dir      Directory to create sysbench test files (required)
  -f, --file-size     File size(in MB) for sysbench files. Default: 2 * system memory
  -t, --time          Time(in seconds) to run each sysbench test. Default: 300s
  -d, --delay         Delay(in seconds) between running each sysbench test. Default: 30s
  -s, --skip-cleanup  Do not run the sysbench cleanup command
  -c, --cleanup       Clean up sysbench prepare files and exits
  -v, --verbose       Output more information.
      --debug         Output debug information.
  -h, --help          Display this help and exit
      --version       Output version information and exit
```

## Running in Docker

Docker allows you to test your script on mulitple linux distros by building containers for each distro.  containers build quickly from an image and are


To build and run a container (default: centos7) using docker-compose:
```
sudo docker-compose up benchmark_io
```

You can specify which distro(centos or ubuntu) to run in:
```
./src/.env 
# default distro for docker-compose
OS_DISTRO=centos
```

You can also override any eenvironment variables in ./src/docker-compose.yml (paramaters to call the benchmark_io script) in this file.

docker-compose env vars:
```
    environment:
      # env vars that are passed as args to the benchmark script
      - work_dir=/tmp/sysbench
      - file_size=150
      - time=3
      - delay=1
      - TERM=xterm-256color
```


cleanup (run docker-compose down):
```
sudo docker-compose down
Removing centos_benchmark_io     ... done
Removing shellcheck_benchmark_io ... done
Removing network benchmark_io_default
```

## Testing

The script is tested using bats, shellcheck & docker.

### bats (Bash Automated Testing System) 

https://github.com/sstephenson/bats

bats makes it easy to test bash scripts.

Example bats test:
```
@test "docker-compose installed" {
    run command -v docker-compose
    [ "$status" -eq 0 ]
}
```

bats tests for this project are located in ./tests

### shellcheck (A shell script static analysis tool)

https://github.com/koalaman/shellcheck

Shell scripts can be difficult to debug.  shellcheck helps point out syntax issues and common mistakes

Some examples of shellcheck catching common bash mistakes:

```
In benchmark_io line 139:
        if !sudo yum install epel-release -y > /dev/null 2>&1; then
            ^-- SC1035: You are missing a required space after the !.
```

```
In benchmark_io line 139:
        if !sudo yum install epel-release -y > /dev/null 2>&1; then
            ^-- SC1035: You are missing a required space after the !.
```

### Using docker to test using multiple Linux distros

Docker makes it easy to test your script in different Linux distros.  The ./src/run_tests script will start a test (using docker-compose) for each Linux distro that is defined in OS_DISTROS
Create a directory and Dockerfile for each distro you want to test under ./src/docker.  Each Dockerfile shares a command entrypoint script (./src/./docker/start.sh)

## blog

https://www.peterstechblog.net
