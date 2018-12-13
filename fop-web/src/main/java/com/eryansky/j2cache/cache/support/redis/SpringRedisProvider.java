package com.eryansky.j2cache.cache.support.redis;

import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

import com.eryansky.j2cache.autoconfigure.J2CacheConfig;
import org.springframework.data.redis.core.RedisTemplate;

import com.eryansky.j2cache.Cache;
import com.eryansky.j2cache.CacheChannel;
import com.eryansky.j2cache.CacheExpiredListener;
import com.eryansky.j2cache.CacheObject;
import com.eryansky.j2cache.CacheProvider;
import com.eryansky.j2cache.cache.support.util.SpringUtil;

/**
 * spring redis缓存
 * @author zhangsaizz
 *
 */
public class SpringRedisProvider implements CacheProvider {

	private RedisTemplate<String, Serializable> redisTemplate;

	private J2CacheConfig config;


	private String namespace;

	private String storage;
	
	protected ConcurrentHashMap<String, Cache> caches = new ConcurrentHashMap<>();

	@Override
	public String name() {
		return "redis";
	}

	@Override
	public int level() {
		return CacheObject.LEVEL_2;
	}

	@Override
	public Collection<CacheChannel.Region> regions() {
		return Collections.emptyList();
	}

	@Override
	public Cache buildCache(String region, CacheExpiredListener listener) {
		Cache cache = caches.get(region);
		if (cache == null) {
			synchronized (SpringRedisProvider.class) {
				cache = caches.get(region);
				if (cache == null) {
	                if("hash".equalsIgnoreCase(this.storage))
	                    cache = new SpringRedisCache(this.namespace, region, redisTemplate);
	                else {
	                	cache = new SpringRedisGenericCache(this.namespace, region, redisTemplate);
					}
					caches.put(region, cache);
				}
			}
		}
		return cache;
	}

	@Override
	public Cache buildCache(String region, long timeToLiveInSeconds, CacheExpiredListener listener) {
		return buildCache(region, listener);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void start(Properties props) {
		this.namespace = props.getProperty("namespace");
		this.storage = props.getProperty("storage");
		this.config = SpringUtil.getBean(J2CacheConfig.class);
		if (!config.isL2CacheOpen()) {
			return;
		}
		this.redisTemplate = SpringUtil.getBean("j2CacheRedisTemplate", RedisTemplate.class);
	}

	@Override
	public void stop() {
		// 由spring控制
	}

}
