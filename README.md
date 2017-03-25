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

#### 3.1.1 使用视频播放的启动画面

```objc
/**
 使用视频播放的启动画面

 @param url 视频的 URL，可以为本地或远程的视频
 @param configBlock 如果要显示一个完成视频播放，点击执行 enterBlock 的按钮，则实现这个 configBlock；设置为 nil，则不显示按钮，等待播放完毕后自动执行 enterBlock
 @param enterBlock 点击完成按钮或播放完毕后，执行的功能，一般为设置 window.rootViewController
 */
- (void)launchWithMovieURL:(NSURL *)url
					config:(void (^)(UIButton *enterButton))configBlock
					 enter:(void (^)(void))enterBlock;
```

#### 3.1.2 使用多张图片滑动展示的启动画面

```objc
/**
 使用多张图片滑动展示的启动画面

 @param images 图片数组
 @param configEnterButtonBlock 如果要在最后一张图片上显示一个完成图片展示，点击执行 enterBlock 的按钮，则实现这个 configEnterButtonBlock；设置为 nil，则不显示按钮，滑动到最后一张图片，再向左滑时，自动执行 enterBlock
 @param configPageControlBlock 如果要显示一个指示当前滑动到的图片位置的 UIPageControl，则实现这个 configPageControlBlock；设置为 nil，则不显示
 @param enterBlock 点击完成按钮或滑动完毕后，执行的功能，一般为设置 window.rootViewController
 */
- (void)launchWithImages:(NSArray<UIImage *> *)images
	   configEnterButton:(void (^)(UIButton *enterButton))configEnterButtonBlock
	   configPageControl:(void (^)(UIPageControl *pageControl))configPageControlBlock
				   enter:(void (^)(void))enterBlock;
```

#### 3.1.3 使用单张图片倒计时展示的启动画面

```objc
/**
 使用单张图片倒计时展示的启动画面

 @param image 图片
 @param duration 启动画面的展示时长
 @param configBlock 如果要显示一个显示倒计时，点击执行 enterBlock 的按钮，则实现这个 configBlock；设置为 nil，则不显示按钮，等待倒计时完毕后自动执行 enterBlock
 @param enterBlock 点击完成按钮或倒计时完毕后，执行的功能，一般为设置 window.rootViewController
 */
- (void)launchWithImage:(UIImage *)image
			   duration:(NSUInteger)duration
				 config:(void (^)(UIButton *enterButton))configBlock
				  enter:(void (^)(void))enterBlock;
```

#### 3.1.4 使用 GIF 图片的启动画面

```objc
/**
 使用 GIF 图片的启动画面

 @param name GIF 图片名称。“.gif”后缀可传可不传
 @param repeatCount GIF 图片重复次数
 @param configBlock 如果要显示一个完成 GIF 图片动画，点击执行 enterBlock 的按钮，则实现这个 configBlock；设置为 nil，则不显示按钮，等待播放完毕后自动执行 enterBlock
 @param enterBlock 点击完成按钮或 GIF 图片动画完毕后，执行的功能，一般为设置 window.rootViewController
 */
- (void)launchWithGIFNamed:(NSString *)name
			   repeatCount:(NSUInteger)repeatCount
					config:(void (^)(UIButton *enterButton))configBlock
					 enter:(void (^)(void))enterBlock;
```

### 3.2 CALayer+CZLaunchTransition


### 3.3 UIImage+CZLaunchGIF

