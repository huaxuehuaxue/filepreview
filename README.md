# file-online-preview
此项目为文件文档在线预览项目解决方案，对标业内付费产品有【[永中office](http://dcs.yozosoft.com/)】【[office365](http://www.officeweb365.com/)】【[idocv](https://www.idocv.com/)】等，在取得公司高层同意后以Apache协议开源出来反哺社区，在此特别感谢@唐老大的支持以及@端木详笑的贡献。该项目使用流行的spring boot搭建，易上手和部署，基本支持主流办公文档的在线预览，如doc,docx,Excel,pdf,txt,zip,rar,图片等等
### 项目特性

1. 支持office，pdf等办公文档
1. 支持txt,java,php,py,md,js,css等所有纯文本
1. 支持zip,rar,jar,tar,gzip等压缩包
1. 支持jpg，jpeg，png，gif等图片预览（翻转，缩放，镜像）
1. 使用spring boot开发，预览服务搭建部署非常简便
1. rest接口提供服务，跨平台特性(java,php,python,go,php，....)都支持，应用接入简单方便
1. 抽象预览服务接口，方便二次开发，非常方便添加其他类型文件预览支持
1. 最最重要Apache协议开源，代码pull下来想干嘛就干嘛

### 在线体验
> 请善待公共服务，会不定时停用

地址：https://mp.jxtobacco.gov.cn/fop


### 快速开始
> 项目使用技术
- spring boot：
- freemarker
- redisson 
- jodconverter
> 依赖外部环境
- redis 
- OpenOffice或者LibreOffice