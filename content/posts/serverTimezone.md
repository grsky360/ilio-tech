---
title: MySQL JDBC serverTimezone
share: true
date: 2025-11-23 15:55:37 +08:00
lastmod: 2025-12-23 00:15:06 +08:00
---

## serverTimezone

### 前提
1. serverTimezone = UTC
2. mysql timezone = +08:00
2. date = Asia/Shanghai 2000-01-01 08:00

### 存数据
1. 服务器根据UTC格式化date, "2020-01-01 00:00"
2. date字符串发送给mysql
3. mysql认为这个字符串是+8的时间, 也就是 "2020-01-01 00:00 +08:00"
4. mysql把解析后的时间转timestamp存起来

#### 预期和实际数据
1. 预期: Asia/Shanghai 2000-01-01 08:00
2. 实际: Asia/Shanghai 2000-01-01 00:00

### 取数据
1. 服务器根据Asia/Shanghai格式化, "2020-01-01 00:00"
2. 字符串返回给服务器
3. 服务器认为这个字符串是UTC的时间, 也就是 "2020-01-01 00:00 +00:00"
4. "2020-01-01 00:00 +00:00" == ""2020-01-01 08:00 +08:00"

### 实现
1. 存数据格式化的地方: com.mysql.cj.ClientPreparedQueryBindings#bindTimestamp
2. 取数据解析的地方: com.mysql.cj.result.SqlTimestampValueFactory#localCreateFromTimestamp -->

### 服务器端只要保证存取的serverTimezone是一致的, 就可以保证存取的数据在服务器端是一致的
