package com.eryansky.configure;

import io.lettuce.core.RedisClient;
import io.lettuce.core.RedisURI;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


/**
 * Created by kl on 2017/09/26.
 * redisson 客户端配置
 */
@ConfigurationProperties(prefix = "spring.lettuce")
@Configuration
public class RedissonConfig {

    private String host;
    private String password;
    private int port;
    private int database = 0;

    @Bean(destroyMethod = "shutdown")
    RedisClient redisson() {
        RedisURI redisURI = RedisURI.Builder.redis(host,port)
                .withPassword(password)
                .withDatabase(database)
                .build();
        RedisClient redisClient = RedisClient.create(redisURI);
        return redisClient;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }


    public int getDatabase() {
        return database;
    }

    public void setDatabase(int database) {
        this.database = database;
    }
}
