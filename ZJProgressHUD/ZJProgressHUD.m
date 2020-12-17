//
//  ZJProgressHUD.m
//  ZJProgressHUD
//
//  Created by eafy on 2015/11/24.
//  Copyright © 2015 ZJ. All rights reserved.
//

#import "ZJProgressHUD.h"
#import "MBProgressHUD.h"

#ifndef kScreenHeight
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)   //屏幕高度
#endif
#ifndef kScreenWidth
#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)     //屏幕宽度
#endif

@interface ZJProgressHUD() <MBProgressHUDDelegate>

@property (nonatomic, strong) UIWindow *mainWindow;
@property (nonatomic, strong) UIWindow *overlayWindow;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, assign) BOOL isShowLan;

@property (nonatomic, strong) NSString *defaultBundleImagePath;

@end

@implementation ZJProgressHUD
static ZJProgressHUD *_shared;

+ (instancetype)shared {
    if (!_shared) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^ {
            _shared = [[ZJProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            _shared.successImage = [[ZJProgressHUD shared] imageNamed:@"icon_zj_hud_success"];
            _shared.errorImage = [[ZJProgressHUD shared] imageNamed:@"icon_zj_hud_error"];
            _shared.font = [UIFont systemFontOfSize:16];
            _shared.titleColor = [UIColor whiteColor];
            _shared.textSpace = 6.f;
            _shared.cornerRadius = 10.f;
            _shared.opacity = 0.8f;
            _shared.paddingSpace = 6.f;
            _shared.marginUpDown = 12.f;
            _shared.marginLeftRight = 12.f;
            _shared.isSquare = YES;
        });
    }
    return _shared;
}

- (void)configHubPara:(MBProgressHUD *)hud
{
    if (!hud) return;
    hud.labelFont = self.font;
    hud.labelColor = self.titleColor;
    hud.cornerRadius = self.cornerRadius;
    hud.color = self.windowColor;
    hud.opacity = self.opacity;
    hud.padding = self.paddingSpace;
    hud.marginUpDown = self.marginUpDown;
    hud.marginLeftRight = self.marginLeftRight;
    hud.minSize = self.minSize;
    hud.square = self.isSquare;
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (self.mainWindow) {
        if (NSThread.isMainThread) {
            [self.mainWindow makeKeyAndVisible];
            _mainWindow = nil;
        } else {
            __weak ZJProgressHUD *weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.mainWindow makeKeyAndVisible];
                weakSelf.mainWindow = nil;
            });
        }
    }
    
    [self removeFromSuperview];
    if (_subView) {
        [self.subView removeFromSuperview];
        _subView = nil;
    }
    if (_hud) {
        self.hud.delegate = nil;
        [self.hud removeFromSuperview];
        _hud = nil;
    }
    
    if (_overlayWindow) {
        self.overlayWindow.userInteractionEnabled = NO;
        [self.overlayWindow resignKeyWindow];
        [self.overlayWindow removeFromSuperview];
        self.overlayWindow.hidden = YES;
        _overlayWindow = nil;
    }
    
    if (self.isShowLan) {
        self.transform = CGAffineTransformIdentity;
        self.frame = [[UIScreen mainScreen] bounds];
        self.isShowLan = NO;
    }
}

#pragma mark _______________________________________________
#pragma mark 单例类--外部调用方法

+ (void)hide
{
    [[ZJProgressHUD shared] hideHubWithAnmotion:YES];
}

+ (void)dismiss
{
    [ZJProgressHUD shared].hud.delegate = nil;
    [[ZJProgressHUD shared] hudWasHidden:nil];
}

+ (void)isLan {
    [ZJProgressHUD shared].isShowLan = YES;
}

+ (void)message:(NSString *)title
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title mark:YES];
}

+ (void)lanMessage:(NSString *)title
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title mark:YES];
}

+ (void)messageForNoMark:(NSString *)title
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title mark:NO];
}

+ (void)lanMessageForNoMark:(NSString *)title
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title mark:NO];
}

+ (void)loading
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"加载中...", nil) mark:YES];
}

+ (void)lanLoading
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"加载中...", nil) mark:YES];
}

+ (void)loadingForNoMark
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"加载中...", nil) mark:NO];
}

+ (void)lanLoadingForNoMark
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"加载中...", nil) mark:NO];
}

+ (void)setting
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"设置中...", nil) mark:YES];
}

+ (void)lanSetting
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"设置中...", nil) mark:YES];
}

+ (void)settingForNoMark
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"设置中...", nil) mark:NO];
}

+ (void)lanSettingForNoMark
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"设置中...", nil) mark:NO];
}

+ (void)submitting
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"提交中...", nil) mark:YES];
}

+ (void)lanSubmitting
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"提交中...", nil) mark:YES];
}

+ (void)submittingForNoMark
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"提交中...", nil) mark:NO];
}

+ (void)lanSubmittingForNoMark
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"提交中...", nil) mark:NO];
}

+ (void)statusWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:YES view:nil yOffset:0];
}

+ (void)lanStatusWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:YES view:nil yOffset:0];
}

+ (void)statusWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:YES view:nil yOffset:yOffset];
}

+ (void)statusWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration view:(UIView *)view
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:NO view:view yOffset:0];
}

+ (void)lanStatusWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration view:(UIView *)view
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:NO view:view yOffset:0];
}

+ (void)statusWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration view:(UIView *)view yOffset:(CGFloat)yOffset
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:NO view:view yOffset:0];
}

+ (void)successWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:YES view:nil yOffset:0];
}

+ (void)lanSuccessWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:YES view:nil yOffset:0];
}

+ (void)successWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:YES view:nil yOffset:yOffset];
}

+ (void)successWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:0];
}

+ (void)lanSuccessWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:0];
}

+ (void)successWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:yOffset];
}

+ (void)lanSuccessWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:yOffset];
}

+ (void)errorWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:YES view:nil yOffset:0];
}

+ (void)errorWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:YES view:nil yOffset:yOffset];
}

+ (void)lanErrorWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:0];
}

+ (void)errorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:0];
}

+ (void)lanErrorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD isLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:0];
}

+ (void)errorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:yOffset];
}

+ (ZJProgressHUD *)annularHubWithWithTitle:(NSString *)title view:(UIView *)view
{
    [[ZJProgressHUD shared] showAnnularHubWithWithTitle:title mark:NO view:view];
    return [ZJProgressHUD shared];
}

#pragma mark _______________________________________________
#pragma mark PrivateAPI

- (void)setProgress:(CGFloat)progress
{
    if (self.hud && self.hud.mode == MBProgressHUDModeAnnularDeterminate) {
        self.hud.progress = progress;
    }
}

#pragma mark _______________________________________________
#pragma mark 单例类--内部使用方法

- (UIWindow *)overlayWindow
{
    if (!_overlayWindow) {
        if (!_mainWindow) {
            _mainWindow = [ZJProgressHUD keyWindow];
        }
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
                                | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.userInteractionEnabled = NO;
        _overlayWindow.windowLevel = UIWindowLevelNormal;
        
        if (_mainWindow) {
            [[ZJProgressHUD keyWindow] addSubview:_overlayWindow];
        }
    }
    return _overlayWindow;
}

- (void)hideHubWithAnmotion:(BOOL)anmotion
{
    __weak ZJProgressHUD *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.hud.delegate = anmotion?weakSelf:nil;
        if (weakSelf.subView) {
            [MBProgressHUD hideHUDForView:weakSelf.subView animated:anmotion];
            [ZJProgressHUD shared].subView = nil;
        } else {
            [MBProgressHUD hideHUDForView:weakSelf animated:anmotion];
        }
    });
}

- (void)showHubMessageWithTitle:(NSString *)string mark:(BOOL)isMask
{
    __weak ZJProgressHUD *weakSelf = self;
    __block BOOL isShowLan = self.isShowLan;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.hud) {
            [ZJProgressHUD dismiss];
        }
        
        if (weakSelf.superview) {
            [weakSelf removeFromSuperview];
        }
        [weakSelf.overlayWindow addSubview:weakSelf];
        [weakSelf.overlayWindow makeKeyAndVisible];
        if (isShowLan) {
            weakSelf.frame = CGRectMake(0, 0, kScreenHeight, kScreenWidth);
            weakSelf.center = weakSelf.overlayWindow.center;
            weakSelf.transform = CGAffineTransformMakeRotation(M_PI_2);
        } else {
            weakSelf.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
        }
        
        weakSelf.hud = [MBProgressHUD showHUDAddedTo:weakSelf animated:YES];
        [weakSelf configHubPara:weakSelf.hud];
        
        weakSelf.hud.labelText = string;
        weakSelf.hud.delegate = nil;
        // 隐藏时候从父控件中移除
        weakSelf.hud.removeFromSuperViewOnHide = YES;
        weakSelf.hud.dimBackground = NO;   // YES代表需要蒙版效果
        weakSelf.overlayWindow.userInteractionEnabled = isMask;
    });
}

- (void)showHubMessageWithTitle:(NSString *)title duration:(NSTimeInterval)duration state:(NSInteger)suState mark:(BOOL)isMark view:(UIView *)view yOffset:(CGFloat)yOffset
{
    __weak ZJProgressHUD *weakSelf = self;
    __block BOOL isShowLan = self.isShowLan;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.hud) {
            [ZJProgressHUD dismiss];
        }
        
        if (weakSelf.superview) {
            [weakSelf removeFromSuperview];
        }
        if (view) {
            [view addSubview:weakSelf];
            if (isShowLan) {
                weakSelf.transform = CGAffineTransformMakeRotation(M_PI_2);
            }
            weakSelf.center = CGPointMake(kScreenHeight/2.0, kScreenWidth/2.0);
        } else {
            [weakSelf.overlayWindow addSubview:weakSelf];
            [weakSelf.overlayWindow makeKeyAndVisible];
            if (isShowLan) {
                weakSelf.frame = CGRectMake(0, 0, kScreenHeight, kScreenWidth);
                weakSelf.center = weakSelf.overlayWindow.center;
                weakSelf.transform = CGAffineTransformMakeRotation(M_PI_2);
            } else {
                weakSelf.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
            }
        }
        
        // 快速显示一个提示信息
        weakSelf.hud = [MBProgressHUD showHUDAddedTo:weakSelf animated:YES];
        if (suState == 1) {
            if (weakSelf.successImage) {
                weakSelf.hud.customView = [[UIImageView alloc] initWithImage:weakSelf.successImage];
            }
        } else if (suState == 2) {
            if (weakSelf.errorImage) {
                weakSelf.hud.customView = [[UIImageView alloc] initWithImage:weakSelf.errorImage];
            }
        }
        [weakSelf configHubPara:weakSelf.hud];
        weakSelf.hud.mode = MBProgressHUDModeCustomView;
        weakSelf.hud.labelText = title;
        weakSelf.hud.delegate = weakSelf;
        weakSelf.hud.yOffset = yOffset;
        [weakSelf.hud show:YES];
        [weakSelf.hud hide:YES afterDelay:duration];
        
        // 隐藏时候从父控件中移除
        weakSelf.hud.removeFromSuperViewOnHide = YES;
        weakSelf.hud.dimBackground = NO;   // YES代表需要蒙版效果
        weakSelf.overlayWindow.userInteractionEnabled = isMark;
    });
}

- (void)showAnnularHubWithWithTitle:(NSString *)title mark:(BOOL)isMark view:(UIView *)view
{
    __weak ZJProgressHUD *weakSelf = self;
    __block BOOL isShowLan = self.isShowLan;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.hud) {
            [ZJProgressHUD dismiss];
        }
        
        if (weakSelf.superview) {
            [weakSelf removeFromSuperview];
        }
        if (view) {
            weakSelf.subView = view;
            weakSelf.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        } else {
            [weakSelf.overlayWindow addSubview:weakSelf];
            [weakSelf.overlayWindow makeKeyAndVisible];
            if (isShowLan) {
                weakSelf.frame = CGRectMake(0, 0, kScreenHeight, kScreenWidth);
                weakSelf.center = weakSelf.overlayWindow.center;
                weakSelf.transform = CGAffineTransformMakeRotation(M_PI_2);
            } else {
                weakSelf.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
            }
            
            weakSelf.hud = [MBProgressHUD showHUDAddedTo:weakSelf animated:YES];
        }
        
        [weakSelf configHubPara:weakSelf.hud];
        weakSelf.hud.mode = MBProgressHUDModeAnnularDeterminate;
        weakSelf.hud.labelText = title;
        weakSelf.hud.progress = 0;
        weakSelf.hud.color = [UIColor clearColor];
        weakSelf.hud.delegate = weakSelf;
        
        // 隐藏时候从父控件中移除
        weakSelf.hud.removeFromSuperViewOnHide = YES;
        weakSelf.hud.dimBackground = NO;   // YES代表需要蒙版效果
        weakSelf.overlayWindow.userInteractionEnabled = isMark;
    });
}

#pragma mark -

+ (UIWindow *)keyWindow
{
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    if (keyWindow) return keyWindow;
    
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL isMainScreen = window.screen == UIScreen.mainScreen;
        BOOL isVisible = !window.hidden && window.alpha > 0;
        BOOL isLevelNormal = window.windowLevel == UIWindowLevelNormal;
        BOOL isKeyWindow = window.isKeyWindow;
            
        if (isMainScreen && isVisible && isLevelNormal && isKeyWindow) {
            return window;
        }
    }
    
    return nil;
}

- (nullable UIImage *)imageNamed:(NSString * _Nullable)imageName
{
    if (!_defaultBundleImagePath) {
        NSBundle *bundle = [self bundleWithBundleName:NSStringFromClass([self class])];
        if (!bundle) {
            _defaultBundleImagePath = @"";
            return nil;
        }
        _defaultBundleImagePath = bundle.bundlePath;
    } else if (_defaultBundleImagePath.length == 0) {
        return nil;
    }
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", _defaultBundleImagePath, imageName];
    return [[UIImage alloc] initWithContentsOfFile:filePath];
}

/// 获取pod方式下的资源包路径
/// @param bundleName 资源包名称
- (NSBundle *)bundleWithBundleName:(NSString *)bundleName {
    
    NSURL *associateBundleURL = nil;
    if (bundleName) {
        if ([bundleName containsString:@".bundle"]) {
            bundleName = [bundleName componentsSeparatedByString:@".bundle"].firstObject;
        }
        
        associateBundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];  //没使用framwork的情况下
        
        if (!associateBundleURL) {  //使用framework形式
            associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
            associateBundleURL = [associateBundleURL URLByAppendingPathComponent:bundleName];
            associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
            
            if (!associateBundleURL) {
                NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
                associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
            }
        }
    }
    
    if (!associateBundleURL) {
        NSLog(@"%@默认资源包bundle为空!", NSStringFromClass([self class]));
        return nil;
    } else {
        return [NSBundle bundleWithURL:associateBundleURL];
    }
}

@end
