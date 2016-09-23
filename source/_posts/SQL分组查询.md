---
title: SQL分组查询
date: 2016-09-03 18:25:50
categories: 数据库  
tags: [SQL]
---

### group by

- 什么是分组查询？
使用`group by`子句将表中的数据分成若干组，再对分组之后的数据做统计计算，一般使用`聚集函数`才使用`group by`

- 聚集函数：`sum`，`avg`，`count`，`min`，`max`
- 分组查询的格式
```SQL
select
  <selectList>,聚集函数
from
  t_name
where
  条件
group by
  <selectList>
```

- 注意
`group by` 后面的列名的值要有重复性分组才有意义

### having

- 使用`having`子句，对分组之后的结果作筛选

```SQL
select
  <selectList>,聚集函数
from
  t_name
where
  条件
group by
  <selectList>
having
  组函数
```

- 注意
不在`where`子句中使用`组函数`；
应该在`having`子句中使用`组函数`
