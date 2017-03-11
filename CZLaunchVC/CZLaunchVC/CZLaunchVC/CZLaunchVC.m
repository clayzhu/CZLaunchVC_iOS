//
//  CZLaunchVC.m
//  CZLaunchVCDemo
//
//  Created by Apple on 2017/2/28.
//  Copyright © 2017年 Ugoodtech. All rights reserved.
//

#import "CZLaunchVC.h"
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import "AppDelegate.h"

#define kCZLaunchScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kCZLaunchScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface CZLaunchVC () <UIScrollViewDelegate>
/** 播放完成或点击完成按钮的回调 */
@property (copy, nonatomic) void (^enterBlock)(void);
@property (strong, nonatomic) UIButton *enterButton;

// 多张图片滑动展示
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSArray<UIImage *> *imageList;

// 单张图片倒计时展示
@property (strong, nonatomic) NSString *enterButtonTitle;
@property (assign, nonatomic) NSUInteger timerCountDown;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CZLaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	NSLog(@"%@", NSStringFromClass(self.class));
}

- (void)dealloc {
	NSLog(@"dealloc:%@", NSStringFromClass(self.class));
}

- (BOOL)prefersStatusBarHidden {
	return YES;	// 隐藏状态栏
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 启动配置
- (void)launchWithMovieURL:(NSURL *)url
					config:(void (^)(UIButton *))configBlock
					 enter:(void (^)(void))enterBlock {
	[self setupAVPlayer:url];
	if (configBlock) {	// 实现了按钮配置的 block，则显示一个自定义配置的完成按钮，点击按钮执行 enterBlock
		configBlock([self setupEnterButtonInView:self.view]);
	} else {	// 未实现按钮配置的 block，则在视频播放完成后，自动执行 enterBlock
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterAction) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
	}
	if (enterBlock) {
		self.enterBlock = enterBlock;
	}
}

- (void)launchWithImages:(NSArray<UIImage *> *)images
	   configEnterButton:(void (^)(UIButton *))configEnterButtonBlock
	   configPageControl:(void (^)(UIPageControl *))configPageControlBlock
				   enter:(void (^)(void))enterBlock {
	self.imageList = images;
	[self setupImagesScrollView];
	// 绘制 UIImageView
	[images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(kCZLaunchScreenWidth * idx, 0.0, kCZLaunchScreenWidth, kCZLaunchScreenHeight)];
		iv.contentMode = UIViewContentModeScaleAspectFill;
		iv.clipsToBounds = YES;
		iv.image = obj;
		[self.scrollView addSubview:iv];
		
		if (configEnterButtonBlock) {	// 实现了按钮配置的 block，则在最后一张图片上显示一个自定义配置的完成按钮，点击按钮执行 enterBlock
			if (idx == images.count - 1) {
				iv.userInteractionEnabled = YES;
				configEnterButtonBlock([self setupEnterButtonInView:iv]);
			}
		}
	}];
	if (configPageControlBlock) {	// 实现了 pageControl 配置的 block，则显示一个指示当前滑动到的图片位置的 UIPageControl
		configPageControlBlock([self setupPageControl]);
	}
	if (enterBlock) {
		self.enterBlock = enterBlock;
	}
}

- (void)launchWithImage:(UIImage *)image
			   duration:(NSUInteger)duration
				 config:(void (^)(UIButton *enterButton))configBlock
				  enter:(void (^)(void))enterBlock {
	// 绘制 UIImageView
	UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, kCZLaunchScreenWidth, kCZLaunchScreenHeight)];
	iv.contentMode = UIViewContentModeScaleAspectFill;
	iv.clipsToBounds = YES;
	iv.image = image;
	[self.view addSubview:iv];
	
	self.timerCountDown = duration;
	
	if (configBlock) {	// 实现了按钮配置的 block，则显示一个自定义配置的完成按钮，点击按钮执行 enterBlock
		configBlock([self setupEnterButtonInView:self.view]);
		self.enterButtonTitle = [self.enterButton titleForState:UIControlStateNormal];
		[self.enterButton setTitle:[NSString stringWithFormat:@"%@ %@s", self.enterButtonTitle == nil ? @"" : self.enterButtonTitle, @(self.timerCountDown)] forState:UIControlStateNormal];	// 设置按钮的倒计时显示
	}
	if (enterBlock) {
		self.enterBlock = enterBlock;
	}
	
	// 显示倒计时
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(launchCountDownAction:) userInfo:nil repeats:YES];
}

#pragma mark - Private
- (UIButton *)setupEnterButtonInView:(UIView *)view {
	// 点击完成的按钮
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:button];
	self.enterButton = button;
	return button;
}

#pragma mark 视频
/** 设置播放器 */
- (void)setupAVPlayer:(NSURL *)url {
	// 创建 AVPlayerItem
	AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
	// 创建 AVPlayer
	AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
	// 添加 AVPlayerLayer
	AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
	layer.videoGravity = AVLayerVideoGravityResizeAspectFill;	// 填充模式
	layer.frame = CGRectMake(0.0, 0.0, kCZLaunchScreenWidth, kCZLaunchScreenHeight);
	[self.view.layer addSublayer:layer];
	// 开始播放：默认不会自动播放
	[player play];
}

#pragma mark 图片
/** 根据 image 数组，设置左右滑动的 scrollView */
- (void)setupImagesScrollView {
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, kCZLaunchScreenWidth, kCZLaunchScreenHeight)];
	scrollView.contentSize = CGSizeMake(kCZLaunchScreenWidth * self.imageList.count, 0.0);
	scrollView.pagingEnabled = YES;
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.delegate = self;
	self.scrollView = scrollView;
	[self.view addSubview:scrollView];
}

/** 设置 pageControl */
- (UIPageControl *)setupPageControl {
	UIPageControl *pageControl = [[UIPageControl alloc] init];
	pageControl.numberOfPages = self.imageList.count;
	self.pageControl = pageControl;
	[self.view addSubview:pageControl];
	return pageControl;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	NSInteger index = (NSInteger)round(scrollView.contentOffset.x / self.view.bounds.size.width);	// 计算当前页
	if (self.pageControl) {
		self.pageControl.currentPage = index;
	}
	if (!self.enterButton && self.enterBlock) {	// 没有设置完成按钮 enterButton 且设置了 enterBlock，在最后一张图片，再向左滑时，执行 enterBlock
		if (scrollView.contentOffset.x > CGRectGetWidth(self.view.bounds) * (_imageList.count - 1)) {	// 在最后一页，再向左滑时
			self.enterBlock();
		}
	}
}

#pragma mark - Action
/** 按钮点击事件 */
- (void)buttonAction:(UIButton *)sender {
	[self enterAction];
}

/** 执行完成的 enterBlock */
- (void)enterAction {
	if (!self.enterButton) {	// 没有完成按钮，播放完毕执行 enterBlock，需要 remove 播放完毕的通知
		[[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
	}
	if (self.timer) {
		[self.timer invalidate];
	}
	if (self.enterBlock) {
		self.enterBlock();
	}
}

- (void)launchCountDownAction:(NSTimer *)sender {
	self.timerCountDown --;
	if (self.enterButton) {
		[self.enterButton setTitle:[NSString stringWithFormat:@"%@ %@s", self.enterButtonTitle == nil ? @"" : self.enterButtonTitle, @(self.timerCountDown)] forState:UIControlStateNormal];	// 设置按钮的倒计时显示
	}
	if (self.timerCountDown == 0) {
		[sender invalidate];
		if (self.enterBlock) {
			self.enterBlock();
		}
	}
}

@end

@implementation CALayer (CZLaunchTransition)

- (void)transitionWithType:(NSString *)type subtype:(NSString *)subtype timingFunctionName:(NSString *)timingFunctionName duration:(CGFloat)duration {
	static NSString *key = @"CZLaunchTransition";
	if ([self animationForKey:key] != nil) {
		[self removeAnimationForKey:key];
	}
	
	CATransition *transition = [CATransition animation];
	// 动画类型
	transition.type = type;
	// 动画方向
	transition.subtype = subtype;
	// 动画速率函数
	transition.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
	// 动画时长
	transition.duration = duration;
	// 完成动画删除
	transition.removedOnCompletion = YES;
	[self addAnimation:transition forKey:key];
}

@end
