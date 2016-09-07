---
title: SSH2三大框架的整合
date: 2016-08-05 23:56:21
categories: 编程
tags: [Java]
---

> SSH2框架由Struts2.3.15，Spring3.2.0，Hibernate3.6.10集成。下面记录我在JavaWeb上搭建基于SSH2框架的开发环境。

## jar包

### Struts2用到的jar包
* asm-3.3.jar
* asm-commons-3.3.jar
* asm-tree-3.3.jar
* commons-fileupload-1.3.jar
* commons-io-2.0.1.jar
* commons-lang3-3.1.jar
* commons-logging-1.1.3.jar
* freemarker-2.3.19.jar
* javassist-3.11.0.GA.jar
* log4j-1.2.17.jar
* ognl-3.0.6.jar
* struts2-core-2.3.15.3.jar
* struts2-json-plugin-2.3.15.3.jar
* struts2-spring-plugin-2.3.15.3.jar
* xwork-core-2.3.15.3.jar

### Spring用到的jar包
* com.springsource.org.aopalliance-1.0.0.jar
* com.springsource.org.apache.commons.logging-1.1.1.jar
* com.springsource.org.apache.log4j-1.2.15.jar
* com.springsource.org.aspectj.weaver-1.6.8.RELEASE.jar
* spring-aop-3.2.0.RELEASE.jar
* spring-aspects-3.2.0.RELEASE.jar
* spring-beans-3.2.0.RELEASE.jar
* spring-context-3.2.0.RELEASE.jar
* spring-core-3.2.0.RELEASE.jar
* spring-expression-3.2.0.RELEASE.jar
* spring-jdbc-3.2.0.RELEASE.jar
* spring-orm-3.2.0.RELEASE.jar
* spring-test-3.2.0.RELEASE.jar
* spring-tx-3.2.0.RELEASE.jar
* spring-web-3.2.0.RELEASE.jar

### Hibernate用到的jar包
* antlr-2.7.6.jar
* commons-collections-3.1.jar
* dom4j-1.6.1.jar
* hibernate3.jar
* hibernate-jpa-2.0-api-1.0.1.Final.jar
* javassist-3.12.0.GA.jar
* jta-1.1.jar
* slf4j-api-1.6.1.jar
* slf4j-log4j12-1.7.2.jar

### MySQL连接用到的jar包
* c3p0-0.9.1.jar
* mysql-connector-java-5.0.4-bin.jar

## web.xml配置
#### 配置Spring的核心监听器
    <listener>
      <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>
#### 配置全局初始化参数
    <context-param>
    		<param-name>contextConfigLocation</param-name>
    		<param-value>classpath:applicationContext.xml</param-value>
    </context-param>
#### 配置Struts2的核心过滤器
    <filter>
    		<filter-name>struts2</filter-name>
    		<filter-class>org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter</filter-class>
    	</filter>
    	<filter-mapping>
    		<filter-name>struts2</filter-name>
    		<url-pattern>/* </url-pattern>
    		<dispatcher>REQUEST</dispatcher>
    		<dispatcher>FORWARD</dispatcher>
      </filter-mapping>

## applicationContext.xml配置
#### 配置连接池，通过引入外部属性文件配置
    <context:property-placeholder location="classpath:jdbc.properties"/>
    	<bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
    		<property name="driverClass" value="${jdbc.driver}"/>
    		<property name="jdbcUrl" value="${jdbc.url}"/>
    		<property name="user" value="${jdbc.user}"/>
    		<property name="password" value="${jdbc.password}"/>
    </bean>
#### 配置Hibernate的相关属性信息
    <bean id="sessionFactory" class="org.springframework.orm.hibernate3.LocalSessionFactoryBean">
    		<!-- 注入连接池 -->
    		<property name="dataSource" ref="dataSource"/>
    		<!-- 配置Hibernate的其他属性 -->
    		<property name="hibernateProperties">
    			<props>
    				<prop key="hibernate.dialect">org.hibernate.dialect.MySQLDialect</prop>
    				<prop key="hibernate.show_sql">true</prop>
    				<prop key="hibernate.format_sql">true</prop>
    				<prop key="hibernate.connection.autocommit">false</prop>
    				<prop key="hibernate.hbm2ddl.auto">update</prop>
    		</props>
    </property>
    <!-- 配置Hibernate的映射文件 -->
    <property name="mappingResources">
    			<list>
    				<value>com/yanlin/shop/user/vo/User.hbm.xml</value>
    				<value>com/yanlin/shop/category/vo/Category.hbm.xml</value>
    				<value>com/yanlin/shop/product/vo/Product.hbm.xml</value>
    				<value>com/yanlin/shop/categorysecond/vo/CategorySecond.hbm.xml</value>
    				<value>com/yanlin/shop/order/vo/Order.hbm.xml</value>
    				<value>com/yanlin/shop/order/vo/OrderItem.hbm.xml</value>
    				<value>com/yanlin/shop/adminuser/vo/AdminUser.hbm.xml</value>
    			</list>
    	</property>
    </bean>
#### 事务管理器的配置
    <bean id="transactionManager" class="org.springframework.orm.hibernate3.HibernateTransactionManager">
    		<property name="sessionFactory" ref="sessionFactory"/>
    </bean>
#### 开启注解事务
    <tx:annotation-driven transaction-manager="transactionManager"/>
#### Action的配置
    <bean id="xxxAction" class="xxx.action.XxxAction" scope="prototype">
      <property name="xxxService" ref="xxxService"/>
    </bean>
#### Service的配置
    <bean id="xxxService" class="xxx.service.XxxService">
    		<property name="xxxDao" ref="xxxDao"/>
    </bean>
#### Dao的配置
    <bean id="xxxDao" class="xxx.dao.XxxDao">
    		<property name="sessionFactory" ref="sessionFactory"/>
    </bean>

## 外部属性文件配置:jdbc.properties
    jdbc.driver=com.mysql.jdbc.Driver
    jdbc.url=jdbc:mysql:///shop
    jdbc.user=root
    jdbc.password=admin

## Struts.xml的配置
    <struts>
        <constant name="struts.devMode" value="false" />

    	<package name="shop" namespace="/" extends="struts-default">
        <action name="xx_*" class="" method="{1}">
          <result name="success">/xxx.jsp</result>
        </action>
      </package>
    </struts>

## 配置log4j.properties
    ### direct log messages to stdout ###
    log4j.appender.stdout=org.apache.log4j.ConsoleAppender
    log4j.appender.stdout.Target=System.out
    log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
    log4j.appender.stdout.layout.ConversionPattern=%d{ABSOLUTE} %5p %c{1}:%L - %m%n

    ### direct messages to file mylog.log ###
    log4j.appender.file=org.apache.log4j.FileAppender
    log4j.appender.file.File=c:/mylog.log
    log4j.appender.file.layout=org.apache.log4j.PatternLayout
    log4j.appender.file.layout.ConversionPattern=%d{ABSOLUTE} %5p %c{1}:%L - %m%n

    ### set log levels - for more verbose logging change 'info' to 'debug' ###

    log4j.rootLogger=info, stdout
