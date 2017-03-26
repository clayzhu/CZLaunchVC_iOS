//
//  AppDelegate.m
//  CZLaunchVCDemo
//
//  Created by ug19 on 2017/3/11.
//  Copyright © 2017年 Ugood. All rights reserved.
//

#import "AppDelegate.h"
#import "CZLaunchVC.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window.backgroundColor = [UIColor whiteColor];
	
	// 设置启动页视频
//	[self setupLaunchMovie];
	// 设置启动页多张图片
//	[self setupLaunchImages];
	// 设置启动页单张图片
//	[self setupLaunchImage];
	// 设置启动页 GIF 图
	[self setupLaunchGIF];
	
	[self.window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/** 设置启动页视频 */
- (void)setupLaunchMovie {
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
}

/** 设置启动页多张图片 */
- (void)setupLaunchImages {
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
}

/** 设置启动页单张图片 */
- (void)setupLaunchImage {
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
}

/** 设置启动页 GIF 图 */
- (void)setupLaunchGIF {
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
}

@end
