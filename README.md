# 金山云KSYVRPlayer iOS SDK使用手册

## 阅读对象  
本文档面向所有使用该SDK的开发人员, 测试人员等, 要求读者具有一定的iOS编程开发经验。

## 1. 概述  
金山云VR播放内核是基于[金山云播放SDK](https://github.com/ksvc/KSYMediaPlayer_iOS)开发的VR播放器 SDK，在保持与播放SDK接口一致的基础上增加全景视频的播放功能。  

## 2. KSYVRPlayer SDK 功能说明

* 支持金山云播放SDK支持的全部音视频格式和封装格式的媒体文件
* 支持单双目播放全景视频的切换
* 支持触摸和运动感应的交互方式的切换

## 3. 运行环境
KSY VRPlayer iOS SDK可运行于 iPhone/iPod Touch/iPad，支持 iOS 7.0 及以上版本; 支持 armv7/arm64以及虚拟机运行。

## 4.下载工程
本SDK提供如下两种获取方式：  

* 从github下载：[https://github.com/ksvc/KVrPlayer_iOS](https://github.com/ksvc/KVrPlayer_iOS);    
* 使用Cocoapods安装;

更新日志查看地址：[https://github.com/ksvc/KVrPlayer_iOS/releases](https://github.com/ksvc/KVrPlayer_iOS/releases);

### 4.1 github下载SDK 
如果获取到zip格式的压缩包，解压缩后包含demo、doc、framework、README.md四个部分, 目录结构如下所示:  

* domo/ 目录存放KSYVRPlayerDemo，双击打开KSYPlayerDemo.xcodeproj即可使用iOS示例工程，用于帮助开发都快速了解如何使用SDK。  
* doc/ 目录存放接口参考文档，双击打开html/index.html即可看到相关appledoc风格的接口说明，也可以查看[在线版](https://ksvc.github.io/KVrPlayer_iOS/html/index.html)。 
* framework/ 目录存放了KSYVRPlayer.framework，该库支持armv7/arm64/x86_64和i386四种体系结构。 
* README.md 即本文档。

### 4.2 Cocoapods安装  
通过Cocoapods能将SDK的静态库framework下载到本地，只需要将如下语句加入你的Podfile(播放SDK和VRSDK):

   <pre>
   pod 'KSYVRPlayer_iOS', :git => 'https://github.com/ksvc/KSYMediaPlayer_iOS.git'</pre>
   pod 'KSYVRPlayer_iOS', :git => 'https://github.com/ksvc/KVrPlayer_iOS.git'</pre>
   
执行pod install或者pod update后，将SDK加入工程。  

## 5. 快速集成
[快速集成](https://github.com/ksvc/KVrPlayer_iOS/wikis/快速集成)中提供了集成金山云播放SDK的基本方法。
具体可以参考demo工程中的相应文件。

## 6. 详细介绍
关于集成本SDK更详细的介绍请参考：[https://github.com/ksvc/KSYMediaPlayer_iOS/wiki](https://github.com/ksvc/KSYMediaPlayer_iOS/wiki)  
主要接口说明请参考：[金山云VR播放SDK接口](https://github.com/ksvc/KVrPlayer_iOS/html/index.html)及[金山云播放SDK接口](http://ksvc.github.io/KSYMediaPlayer_iOS/html/index.html)

## 7. 反馈与建议
- 主页：[金山云](http://www.ksyun.com/)
- 邮箱：<zengfanping@kingsoft.com>
