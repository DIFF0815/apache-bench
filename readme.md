# 基于Alpine的Apache Bench镜像

目录：apache-bench

## Dockerfile 文件

```dockerfile
FROM alpine:3.10.2

RUN apk update                \
    && apk add apache2-utils  \
    && rm -rf /var/cache/apk/*
```

## 构建镜像

### 构建

```dockerfile
docker build -t apachebench:2.3 .
```

### 查验

```dockerfile
#linux
docker images |grep apachebench 

#windows
docker images |findstr apachebench
```

## 启动镜像

```dockerfile
#启动容器
docker run -d --name apachebench-test apachebench:2.3 
#进入容器
docker exec -it apachebench-test sh  #sh 或者 /bin/bash
#查看ab版本
ab -V
```

## 压力测试

```dockerfile
ab -n 2000 -c 5 "url地址"
```

## 返回参数

```shell
/ # ab -n 100 -c 20 "http://local.com/test.php?c=test&m=test"
This is ApacheBench, Version 2.3 <$Revision: 1879490 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking local.com (be patient).....done


Server Software:        nginx
Server Hostname:        local.com
Server Port:            80

Document Path:          test.php?c=test&m=test
Document Length:        3722 bytes

Concurrency Level:      20
Time taken for tests:   4.730 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      387800 bytes
HTML transferred:       372200 bytes
Requests per second:    21.14 [#/sec] (mean)
Time per request:       945.987 [ms] (mean)
Time per request:       47.299 [ms] (mean, across all concurrent requests)
Transfer rate:          80.07 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        1    4   3.2      3      10
Processing:   177  784 191.7    809    1097
Waiting:      177  784 191.7    809    1097
Total:        187  788 190.4    812    1107

Percentage of the requests served within a certain time (ms)
  50%    812
  66%    866
  75%    952
  80%    963
  90%   1024
  95%   1045
  98%   1067
  99%   1107
 100%   1107 (longest request)
```



| 参数                                                   | 说明                                             |
| ------------------------------------------------------ | ------------------------------------------------ |
| Document Path                                          | 请求路径                                         |
| Document Length                                        | 响应数据的正文长度                               |
| Concurrency Level                                      | 并行度，类似JMeter中的线程组和LR中的Virtual User |
| Time taken for tests                                   | 测试所花时间                                     |
| Complete requests                                      | 成功（返回码为200）执行的请求数量                |
| Failed requests                                        | 成功之外（返回码不是200）的请求数量              |
| Total transferred                                      | 所有请求的响应数据总和（数据正文+Header信息）    |
| HTML transferred                                       | 所有请求的数据正文数据总和                       |
| Requests per second                                    | 吞吐量，平均每秒完成的请求数                     |
| Time per request                                       | 平均每个请求所花时间 （用户平均等待时间）        |
| Time per request(mean, across all concurrent requests) | 服务器平均等待时间（吞吐量的倒数）               |
| Transfer rate                                          | 传输率（单位时间从服务器获取的数据长度）         |

结果关联参数：

```shell
RPS（吞吐量）公式：
Requests per second = Complete requests / Time taken for tests = 100 / 4.730s = 21.14 
```

```shell
Time per request公式：
Time per request = Time taken for tests / （Complete requests / Concurrency Level）= 4.730s / (100/5) = 945.987ms
```

```shell
Time per request(mean, across all concurrent requests)公式：
Time per request(mean, across all concurrent requests) = Time taken for tests / Complete requests = 4.730s / 1000 = 47.299ms
```

```shell
Transfer rate公式：
Transfer rate = Total transferred / Time taken for tests = 387800 / 4.730s= 80.07 kb/s（近似等于）
```



# 其他物理机安装方式

```shell
Alpine: apk add apache2-utils

CentOS/RHEL: yum -y install httpd-tools

Ubuntu: apt-get install apache2-utils

```

