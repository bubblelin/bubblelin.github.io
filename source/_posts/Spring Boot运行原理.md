---
title: Spring Boot运行原理
date: 2018-01-10 11:21:24
categories: 编程  
tags: [Java]  
---

    @SpringBootApplication 是Spring Boot的核心注解,它是一个组合注解,源码如下:
``` java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@SpringBootConfiguration
@EnableAutoConfiguration
@ComponentScan(excludeFilters = {
		@Filter(type = FilterType.CUSTOM, classes = TypeExcludeFilter.class),
		@Filter(type = FilterType.CUSTOM, classes = AutoConfigurationExcludeFilter.class) })
public @interface SpringBootApplication {
	Class<?>[] exclude() default {};
	String[] excludeName() default {};
	String[] scanBasePackages() default {};
	Class<?>[] scanBasePackageClasses() default {};
}
```

