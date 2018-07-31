package com.wang;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @Desc
 * @Author wang926454
 * @Date 2018/5/24 16:20
 */
@SpringBootApplication
@tk.mybatis.spring.annotation.MapperScan("com.wang.mapper")
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
