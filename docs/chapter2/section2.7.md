# Date对象

## 构造对象方法

### Date.now()
Date.now方法返回当前距离1970年1月1日 00:00:00 UTC的毫秒数。

### Date.parse()
Date.parse方法用来解析日期字符串，返回距离1970年1月1日 00:00:00的毫秒数。

## 原型对象方法

### Date.prototype.toString()
返回一个完整的日期字符串。

### Date.prototype.toUTCString()
返回对应的UTC时间，也就是比北京时间晚8个小时。

### Date.prototype.toISOString()
返回对应时间的ISO8601写法。

### Date.prototype.toJSON()
返回一个符合JSON格式的ISO格式的日期字符串，与toISOString方法的返回结果完全相同。

### Date.prototype.toDateString()
返回日期字符串。

### Date.prototype.toTimeString()
返回时间字符串。

### Date.prototype.toLocaleDateString()
返回一个字符串，代表日期的当地写法。

### Date.prototype.toLocaleTimeString()
返回一个字符串，代表时间的当地写法。

### get类方法

- getTime()：返回距离1970年1月1日00:00:00的毫秒数，等同于valueOf方法。
- getDate()：返回实例对象对应每个月的几号（从1开始）。
- getDay()：返回星期几，星期日为0，星期一为1，以此类推。
- getYear()：返回距离1900的年数。
- getFullYear()：返回四位的年份。
- getMonth()：返回月份（0表示1月，11表示12月）。
- getHours()：返回小时（0-23）。
- getMilliseconds()：返回毫秒（0-999）。
- getMinutes()：返回分钟（0-59）。
- getSeconds()：返回秒（0-59）。
- getTimezoneOffset()：返回当前时间与UTC的时区差异，以分钟表示，返回结果考虑到了夏令时因素。

### set类方法

- setDate(date)：设置实例对象对应的每个月的几号（1-31），返回改变后毫秒时间戳。
- setYear(year): 设置距离1900年的年数。
- setFullYear(year [, month, date])：设置四位年份。
- setHours(hour [, min, sec, ms])：设置小时（0-23）。
- setMilliseconds()：设置毫秒（0-999）。
- setMinutes(min [, sec, ms])：设置分钟（0-59）。
- setMonth(month [, date])：设置月份（0-11）。
- setSeconds(sec [, ms])：设置秒（0-59）。
- setTime(milliseconds)：设置毫秒时间戳。

### Date.prototype.valueOf()
返回实例对象距离1970年1月1日00:00:00 UTC对应的毫秒数，该方法等同于getTime方法。