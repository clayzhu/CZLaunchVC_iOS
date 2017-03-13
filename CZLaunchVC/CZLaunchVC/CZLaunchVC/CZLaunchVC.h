//
//  CZLaunchVC.h
//  CZLaunchVCDemo
//
//  Created by Apple on 2017/2/28.
//  Copyright © 2017年 Ugoodtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZLaunchVC : UIViewController

/**
 使用视频播放的启动画面

 @param url 视频的 URL，可以为本地或远程的视频
 @param configBlock 如果要显示一个完成视频播放，点击执行 enterBlock 的按钮，则实现这个 configBlock；设置为 nil，则不显示按钮，等待播放完毕后自动执行 enterBlock
 @param enterBlock 点击完成按钮或播放完毕后，执行的功能，一般为设置 window.rootViewController
 */
- (void)launchWithMovieURL:(NSURL *)url
					config:(void (^)(UIButton *enterButton))configBlock
					 enter:(void (^)(void))enterBlock;

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

@end

@interface CALayer (CZLaunchTransition)

/**
 给 CALayer 增加过渡动画

 @param type 过渡动画类型，包括：kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal（另有一些私有 API，比如：rippleEffect, suckEffect 等）
 @param subtype 过渡动画方向，包括：kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 @param timingFunctionName 动画速率函数名称，包括：kCAMediaTimingFunctionLinear, kCAMediaTimingFunctionEaseIn, kCAMediaTimingFunctionEaseOut, kCAMediaTimingFunctionEaseInEaseOut, kCAMediaTimingFunctionDefault
 @param duration 动画时长
 */
- (void)transitionWithType:(NSString *)type subtype:(NSString *)subtype timingFunctionName:(NSString *)timingFunctionName duration:(CGFloat)duration;

@end

@interface UIImage (CZLaunchGIF)

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;

@end
