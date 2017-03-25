# CZLaunchVC_iOS
自定义启动画面，支持视频、多张图片左右滑动、单张图片倒计时。

## 1. 介绍

开发 iOS 应用过程中，经常会需要呈现一个不一样的启动画面。例如淘宝、京东等 App，都在启动画面中给用户介绍最新的活动。但是 iOS 项目框架默认提供的 `Assets.xcassets` 或 `LaunchScreen.storyboard` 都比较简单。

CZLaunchVC_iOS 提供4种启动画面的方式：

1. 视频播放
2. 多张图片滑动
3. 单张图片倒计时
4. GIF 图片播放

在上述方式的启动画面结束后，还提供了一个便捷的方法，使页面能平滑地过渡到主界面。

## 2. 安装

[下载 CZLaunchVC_iOS](https://github.com/clayzhu/CZLaunchVC_iOS/archive/master.zip)，将 `/CZLaunchVCDemo/CZLaunchVC` 文件夹拖入项目中，记得在 `Destination: Copy items if needed` 前面打勾。

## 3. 说明

`/CZLaunchVCDemo/CZLaunchVC` 文件夹下的 `CZLaunchVC.h`、`CZLaunchVC.m`，是主要实现文件，其中包含三个类：

1. CZLaunchVC：功能实现类
2. CALayer+CZLaunchTransition：用于完成启动画面后，平滑过渡到主界面
3. UIImage+CZLaunchGIF：借助于 [SDWebImage](https://github.com/rs/SDWebImage)，实现 GIF 图转 UIImage 的功能

### 3.1 CZLaunchVC

### 3.2 CALayer+CZLaunchTransition

### 3.3 UIImage+CZLaunchGIF

