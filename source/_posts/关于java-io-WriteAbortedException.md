---
title: 关于session序列化异常
subtitle: java.io.WriteAbortedException
date: 2016-08-02 21:56:21
categories: 编程
tags: [Java,Exception]
---

### 1.在tomcat下部署的SSH2项目
``` bash
严重: IOException while loading persisted sessions: java.io.WriteAbortedException: writing aborted; java.io.NotSerializableException: com.yanlin.shop.category.vo.Category
java.io.WriteAbortedException: writing aborted; java.io.NotSerializableException: com.yanlin.shop.category.vo.Category

Caused by: java.io.NotSerializableException: com.yanlin.shop.category.vo.Category

严重: Exception loading sessions from persistent storage
java.io.WriteAbortedException: writing aborted; java.io.NotSerializableException: com.yanlin.shop.category.vo.Category

Caused by: java.io.NotSerializableException: com.yanlin.shop.category.vo.Category
```


### 2.分析
回顾session销毁的主要情况
* 超时，超过30min
* 服务器非正常关闭
* 调用invalidate()方法

分析1：运行tomcat下面的 ssh项目，启动，打开某页面（让session起作用），关闭服务器；再重新启动（第二次启动），控制台抛出异常[NotSerializableException]
分析2：运行tomcat下面的 ssh项目，启动，直接强行关闭服务器；再重新启动（第二次启动），不会产生异常

### 3.原因
1.tomcat停止时，会在下面的目录中
``` bash
[.metadata\.me_tcat7\work\Catalina\localhost\项目]
```
保存session资源，然后再在重启tomcat服务器时，服务器会恢复该session资源，由于项目在配置实体对象时，未实现序列化[NotSerializable]操作，启动过程中就会出现未序列化的异常[NotSerializableException]
2.若是【正常关闭tomcat服务器】的情况下，session不销毁并完成序列化，session会保存在硬盘下。

### 4.解决
* 非正常关闭

* 不保存session，在server.xml中Context下配置Manager：
``` bash
<Manager className="org.apache.catalina.session.PersistentManager" saveOnRestart="false">
      <Store className="org.apache.catalina.session.FileStore"/>
</Manager>
```

* 给实体类对象实现Serializable接口
``` bash
public class Category implements Serializable{
  ...
}
```
