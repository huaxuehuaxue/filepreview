package com.eryansky.modules.fop.service;

import com.eryansky.modules.fop.model.FileAttribute;
import com.eryansky.modules.fop.model.FileType;
import com.eryansky.modules.fop.manager.FileManager;
import io.lettuce.core.KeyValue;
import io.lettuce.core.RedisClient;
import io.lettuce.core.RedisCommandTimeoutException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ExtendedModelMap;

import javax.annotation.PostConstruct;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by kl on 2018/1/19.
 * Content :消费队列中的转换文件
 */
@Service
public class FileConverQueueTask {

    Logger logger = LoggerFactory.getLogger(getClass());
    public static final String queueTaskName = "FileConverQueueTask";

    @Autowired
    FilePreviewFactory filePreviewFactory;

    @Autowired
    RedisClient redisClient;

    @Autowired
    FileManager fileManager;

    @PostConstruct
    public void startTask() {
        ExecutorService executorService = Executors.newFixedThreadPool(3);
        executorService.submit(new ConverTask(filePreviewFactory, redisClient, fileManager));
        logger.info("队列处理文件转换任务启动完成 ");
    }

    class ConverTask implements Runnable {

        FilePreviewFactory previewFactory;

        RedisClient redisClient;

        FileManager fileManager;

        public ConverTask(FilePreviewFactory previewFactory, RedisClient redisClient, FileManager fileManager) {
            this.previewFactory = previewFactory;
            this.redisClient = redisClient;
            this.fileManager = fileManager;
        }

        @Override
        public void run() {
            while (true) {
                try {
                    KeyValue<String,String> keyValue = redisClient.connect().sync().brpop(3000,FileConverQueueTask.queueTaskName);
                    String url = keyValue.getValue();
                    if (url != null) {
                        FileAttribute fileAttribute = fileManager.getFileAttribute(url);
                        logger.info("正在处理转换任务，文件名称【{}】", fileAttribute.getName());
                        FileType fileType = fileAttribute.getType();
                        if (fileType.equals(FileType.compress) || fileType.equals(FileType.office)) {
                            FilePreview filePreview = previewFactory.get(url);
                            filePreview.filePreviewHandle(url, new ExtendedModelMap());
                        }
                    }
                } catch (RedisCommandTimeoutException e){

                } catch (Exception e) {
                    try {
                        Thread.sleep(1000 * 10);
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                    e.printStackTrace();
                }
            }
        }
    }

}
