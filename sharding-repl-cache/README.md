# Курс Яндекс.Практикума «Архитектура ПО»
## Практическое задание 2-го спринта

### 4. Кэширование

Для контейнера с Redis был выбран образ **bitnami/redis**, т.к. на [его странице](https://hub.docker.com/r/bitnami/redis) есть минимальная, но вполне достаточная документация для запуска контейнера. Как известно, оригинальный сайт redis.io теперь далеко не всем доступен.

Для того, чтобы запустить стэнд, нужно проделать все те же шаги, что и в [3-ем задании](../mongo-sharding-repl/README.md). Последние 2 скрипта можно не запускать (`scripts/07-shard1-count.sh` и `scripts/08-shard2-count.sh`).

Чтобы определить, как скоро отвечает сервер, например, на запрос:

<http://localhost:8080/helloDoc/users>

желательно подключиться к потоку вывода контейнера **pymongo-api** следующей командой:

```bash
$ docker logs -f pymongo-api
```

По мере вызова означенного эндпоинта тем или иным программным средством можно наблюдать, отслеживая в выводе фрагменты типа `"time_taken": "0.0043s"`, сколько по данным самого **pymongo-api** затрачивается на обработку запроса.

Можно вызывать в браузере, глядя при этом на вкладку Networks его DevTools (только кэш не надо отключать!). А можно позапускать, например, **ab**. Утилита так же однозначно подтвердит наши предположения:

```bash
$ ab -c 1 -n 1 http://localhost:8080/helloDoc/users
This is ApacheBench, Version 2.3 <$Revision: 1913912 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:        uvicorn
Server Hostname:        localhost
Server Port:            8080

Document Path:          /helloDoc/users
Document Length:        58791 bytes

Concurrency Level:      1
Time taken for tests:   1.019 seconds
Complete requests:      1
Failed requests:        0
Total transferred:      58975 bytes
HTML transferred:       58791 bytes
Requests per second:    0.98 [#/sec] (mean)
Time per request:       1019.083 [ms] (mean)
Time per request:       1019.083 [ms] (mean, across all concurrent requests)
Transfer rate:          56.51 [Kbytes/sec] received

Connection Times (ms)
min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:  1019 1019   0.0   1019    1019
Waiting:     1019 1019   0.0   1019    1019
Total:       1019 1019   0.0   1019    1019
$
$ ab -c 16 -n 200 http://localhost:8080/helloDoc/users
This is ApacheBench, Version 2.3 <$Revision: 1913912 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 100 requests
Completed 200 requests
Finished 200 requests


Server Software:        uvicorn
Server Hostname:        localhost
Server Port:            8080

Document Path:          /helloDoc/users
Document Length:        58791 bytes

Concurrency Level:      16
Time taken for tests:   0.723 seconds
Complete requests:      200
Failed requests:        1
(Connect: 0, Receive: 0, Length: 1, Exceptions: 0)
Non-2xx responses:      1
Total transferred:      11747542 bytes
HTML transferred:       11699430 bytes
Requests per second:    276.50 [#/sec] (mean)
Time per request:       57.865 [ms] (mean)
Time per request:       3.617 [ms] (mean, across all concurrent requests)
Transfer rate:          15860.53 [Kbytes/sec] received

Connection Times (ms)
min  mean[+/-sd] median   max
Connect:        0    0   0.1      0       0
Processing:     6   55   8.8     57      74
Waiting:        5   51   8.9     51      73
Total:          6   56   8.8     57      75

Percentage of the requests served within a certain time (ms)
50%     57
66%     61
75%     62
80%     63
90%     66
95%     68
98%     69
99%     74
100%     75 (longest request)
```

Как обычно, остановить и удалить все контейнеры, а также почистить за ними созданные тома (volumes) призвана следующая команда:

```bash
$ docker compose down -v
```
