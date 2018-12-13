package com.eryansky;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.util.Properties;

@SpringBootApplication
@EnableScheduling
@ComponentScan(value = {"com.eryansky.j2cache.autoconfigure",
        "com.eryansky.configure",
        "com.eryansky.modules.fop.web",
        "com.eryansky.modules.fop.task",
        "com.eryansky.modules.fop.fop",
        "com.eryansky.modules.fop.service",
        "com.eryansky.modules.fop.utils"
})
public class Application {
    public static void main(String[] args) {
        Properties properties = System.getProperties();
        System.out.println(properties.get("user.dir"));
        SpringApplication.run(Application.class, args);
    }
}
