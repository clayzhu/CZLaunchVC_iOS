# CZLaunchVC_iOS
自定义启动画面，支持视频、多张图片左右滑动、单张图片倒计时。

## 1. 介绍

开发 iOS 应用过程中，经常会需要呈现一个不一样的启动画面。例如淘宝、京东等 App，都在启动画面中给用户介绍最新的活动。但是 iOS 项目框架默认提供的 `Assets.xcassets` 或 `LaunchScreen.storyboard` 都比较简单。

CZLaunchVC_iOS 提供4种启动画面的方式：

* 视频播放
* 多张图片滑动
* 单张图片倒计时
* GIF 图片播放

在上述方式的启动画面结束后，还提供了一个便捷的方法，使页面能平滑地过渡到主界面。

## 2. 安装

[下载 CZLaunchVC_iOS](https://github.com/clayzhu/CZLaunchVC_iOS/archive/master.zip)，将 `/CZLaunchVCDemo/CZLaunchVC` 文件夹拖入项目中，记得在 `Destination: Copy items if needed` 前面打勾。

## 3. 说明

`/CZLaunchVCDemo/CZLaunchVC` 文件夹下的 `CZLaunchVC.h`、`CZLaunchVC.m`，是主要实现文件，其中包含三个类：

* CZLaunchVC：启动画面功能实现类
* CALayer+CZLaunchTransition：用于完成启动画面后，平滑过渡到主界面
* UIImage+CZLaunchGIF：借助于 [SDWebImage](https://github.com/rs/SDWebImage)，实现 GIF 图转 UIImage 的功能

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

```objc
/**
 给 CALayer 增加过渡动画

 @param type 过渡动画类型，包括：kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal（另有一些私有 API，比如：rippleEffect, suckEffect 等）
 @param subtype 过渡动画方向，包括：kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 @param timingFunctionName 动画速率函数名称，包括：kCAMediaTimingFunctionLinear, kCAMediaTimingFunctionEaseIn, kCAMediaTimingFunctionEaseOut, kCAMediaTimingFunctionEaseInEaseOut, kCAMediaTimingFunctionDefault
 @param duration 动画时长
 */
- (void)transitionWithType:(NSString *)type
                   subtype:(NSString *)subtype
        timingFunctionName:(NSString *)timingFunctionName
                  duration:(CGFloat)duration;
```

### 3.3 UIImage+CZLaunchGIF

```objc
/**
 通过 GIF 文件名称解析出一张包含每一帧图片的动画图片

 @param name GIF 图片名称。“.gif”后缀可传可不传
 @return 一张包含 GIF 每一帧图片的动画图片
 */
+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;
```

## 4. 示例

1. 在项目的 `TARGETS` 中，删除 `Main Interface`，关闭 Xcode 默认配置的 `rootViewController`。

2. 在 `AppDelegate` 的 `- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions` 方法中，重新设置 App 的 `window`：

   ```objc
   self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
   self.window.backgroundColor = [UIColor whiteColor];
   [self.window makeKeyAndVisible];
   ```

3. 导入头文件：`#import "CZLaunchVC.h"`，根据项目需要设置相应类型的启动画面。下面给出示例代码：

   **3.1 使用视频播放的启动画面**
   
   ```objc
    CZLaunchVC *vc = [[CZLaunchVC alloc] init];
    // 视频 URL
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Hotel California_ Short - The Eagles" withExtension:@"mp4"];   // 本地视频 URL
 //	NSURL *url = [NSURL URLWithString:@"http://omployphm.bkt.clouddn.com/Hotel%20California_%20Short%20-%20The%20Eagles.mp4"];  // 远程视频 URL
    [vc launchWithMovieURL:url
                    config:^(UIButton *enterButton) {
                        enterButton.frame = CGRectMake(0.0, 0.0, 100.0, 30.0);
                        enterButton.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 100.0);
                        [enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
                        [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    }
                     enter:^{
                         // 应用首页
                         ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
                         self.window.rootViewController = vc;
                         // 显示新的 rootViewController 时的过渡动画
                         [self.window.layer transitionWithType:kCATransitionFade subtype:kCATransitionFromTop timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut duration:2.0];
                     }];
    self.window.rootViewController = vc;
   ```
   
   **3.2 使用多张图片滑动展示的启动画面**
   
   ```objc
    CZLaunchVC *vc = [[CZLaunchVC alloc] init];
    [vc launchWithImages:@[[UIImage imageNamed:@"launch0"],
                           [UIImage imageNamed:@"launch1"],
                           [UIImage imageNamed:@"launch2"]]
       configEnterButton:^(UIButton *enterButton) {
           enterButton.frame = CGRectMake(0.0, 0.0, 100.0, 30.0);
           enterButton.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 100.0);
           [enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
           [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       }
       configPageControl:^(UIPageControl *pageControl) {
           pageControl.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 15.0 - 37.0 / 2.0);
           pageControl.hidesForSinglePage = YES;
       }
                   enter:^{
                       // 应用首页
                       ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
                       self.window.rootViewController = vc;
                       // 显示新的 rootViewController 时的过渡动画
                       [self.window.layer transitionWithType:kCATransitionFade subtype:kCATransitionFromTop timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut duration:2.0];
                   }];
    self.window.rootViewController = vc;
   ```
   
   **3.3 使用单张图片倒计时展示的启动画面**
   
   ```objc
    CZLaunchVC *vc = [[CZLaunchVC alloc] init];
    [vc launchWithImage:[UIImage imageNamed:@"launch0"] duration:3
                 config:^(UIButton *enterButton) {
                     enterButton.frame = CGRectMake(0.0, 0.0, 100.0, 30.0);
                     enterButton.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 100.0);
                     [enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
                     [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                 }
                  enter:^{
                      // 应用首页
                      ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
                      self.window.rootViewController = vc;
                      // 显示新的 rootViewController 时的过渡动画
                      [self.window.layer transitionWithType:kCATransitionFade subtype:kCATransitionFromTop timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut duration:2.0];
                  }];
    self.window.rootViewController = vc;
   ```
   
   **3.4 使用 GIF 图片的启动画面**
   
   ```objc
    CZLaunchVC *vc = [[CZLaunchVC alloc] init];
    [vc launchWithGIFNamed:@"Hotel-California_-Short-The-Eagles"
               repeatCount:2
                    config:^(UIButton *enterButton) {
                        enterButton.frame = CGRectMake(0.0, 0.0, 100.0, 30.0);
                        enterButton.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) - 100.0);
                        [enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
                        [enterButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    }
                     enter:^{
                         // 应用首页
                         ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
                         self.window.rootViewController = vc;
                         // 显示新的 rootViewController 时的过渡动画
                         [self.window.layer transitionWithType:kCATransitionFade subtype:kCATransitionFromTop timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut duration:2.0];
                     }];
    self.window.rootViewController = vc;
   ```

