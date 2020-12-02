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
            _shared.marginUpDown = 20.f;
            _shared.marginLeftRight = 20.f;
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
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    
    if (self.mainWindow) {
        [self.mainWindow makeKeyAndVisible];
    }
    
    if (_overlayWindow) {
        self.overlayWindow.userInteractionEnabled = NO;
        if (self.isShowLan) {
            self.isShowLan = NO;
        }
        _overlayWindow.transform = CGAffineTransformIdentity;
        [self.overlayWindow resignKeyWindow];
        [self.overlayWindow removeFromSuperview];
        _overlayWindow = nil;
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
    [[ZJProgressHUD shared] hudWasHidden:nil];
}

+ (void)imHide
{
    [[ZJProgressHUD shared] hideHubWithAnmotion:NO];
}

+ (void)imHideProcess
{
    [[ZJProgressHUD shared] hideHubWithAnmotion:NO];
}

+ (void)message:(NSString *)title
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title mark:YES];
}

+ (void)lanMessage:(NSString *)title
{
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title mark:YES];
}

+ (void)messageForNoMark:(NSString *)title
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title mark:NO];
}

+ (void)lanMessageForNoMark:(NSString *)title
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title mark:NO];
}

+ (void)loading
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"加载中...", nil) mark:YES];
}

+ (void)lanLoading
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"加载中...", nil) mark:YES];
}

+ (void)loadingForNoMark
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"加载中...", nil) mark:NO];
}

+ (void)lanLoadingForNoMark
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"加载中...", nil) mark:NO];
}

+ (void)setting
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"设置中...", nil) mark:YES];
}

+ (void)lanSetting
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"设置中...", nil) mark:YES];
}

+ (void)settingForNoMark
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"设置中...", nil) mark:NO];
}

+ (void)lanSettingForNoMark
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"设置中...", nil) mark:NO];
}

+ (void)submitting
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"提交中...", nil) mark:YES];
}

+ (void)lanSubmitting
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"提交中...", nil) mark:YES];
}

+ (void)submittingForNoMark
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"提交中...", nil) mark:NO];
}

+ (void)lanSubmittingForNoMark
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:NSLocalizedString(@"提交中...", nil) mark:NO];
}

+ (void)statusWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:YES view:nil yOffset:0];
}

+ (void)lanStatusWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:YES view:nil yOffset:0];
}

+ (void)statusWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:YES view:nil yOffset:yOffset];
}

+ (void)statusWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration view:(UIView *)view
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:NO view:view yOffset:0];
}

+ (void)lanStatusWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration view:(UIView *)view
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:NO view:view yOffset:0];
}

+ (void)statusWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration view:(UIView *)view yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:0 mark:NO view:view yOffset:0];
}

+ (void)successWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:YES view:nil yOffset:0];
}

+ (void)lanSuccessWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:YES view:nil yOffset:0];
}

+ (void)successWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:YES view:nil yOffset:yOffset];
}

+ (void)successWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:0];
}

+ (void)lanSuccessWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:0];
}

+ (void)successWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:yOffset];
}

+ (void)lanSuccessWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:yOffset];
}

+ (void)errorWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:YES view:nil yOffset:0];
}

+ (void)errorWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:YES view:nil yOffset:yOffset];
}

+ (void)lanErrorWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:0];
}

+ (void)errorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:0];
}

+ (void)lanErrorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showLan];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:0];
}

+ (void)errorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHide];
    [[ZJProgressHUD shared] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:yOffset];
}

+ (ZJProgressHUD *)annularHubWithWithTitle:(NSString *)title view:(UIView *)view
{
    [ZJProgressHUD imHide];
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

+ (UIWindow *)keyWindow
{
    UIWindow *keyWindow = [[[UIApplication sharedApplication].windows sortedArrayUsingComparator:^NSComparisonResult(UIWindow *win1, UIWindow *win2) {
        return win1.windowLevel < win2.windowLevel || !win1.isOpaque;
    }] lastObject];
    
    if (!keyWindow) {
        keyWindow = [UIApplication sharedApplication].delegate.window;
    }
    return keyWindow;
}

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
        
        if (_mainWindow) {
            [_mainWindow addSubview:_overlayWindow];
        }
    }
    return _overlayWindow;
}

- (void)dismiss
{
    if (_overlayWindow) {
        if (self.superview) {
            [self removeFromSuperview];
        }
        
        if (self.mainWindow) {
            [self.mainWindow makeKeyAndVisible];
        }
        
        self.overlayWindow.hidden = YES;
        self.overlayWindow.userInteractionEnabled = NO;
        _overlayWindow = nil;
    }
}

- (void)hideHubWithAnmotion:(BOOL)anmotion
{
    self.hud.delegate = anmotion?self:nil;
    self.overlayWindow.userInteractionEnabled = NO;
    if (self.subView) {
        [MBProgressHUD hideHUDForView:self.subView animated:anmotion];
        _subView = nil;
    } else {
        [MBProgressHUD hideHUDForView:self animated:anmotion];
    }
}

- (void)showHubMessageWithTitle:(NSString *)string mark:(BOOL)isMask
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [self.overlayWindow addSubview:self];
    [self.overlayWindow makeKeyAndVisible];
    if (self.isShowLan) {
        self.overlayWindow.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    self.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
    
    self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [self configHubPara:self.hud];
    
    self.hud.labelText = string;
    self.hud.delegate = nil;
    // 隐藏时候从父控件中移除
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.dimBackground = NO;   // YES代表需要蒙版效果
    self.overlayWindow.userInteractionEnabled = isMask;
}

- (void)showHubMessageWithTitle:(NSString *)title duration:(NSTimeInterval)duration state:(NSInteger)suState mark:(BOOL)isMark view:(UIView *)view yOffset:(CGFloat)yOffset
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    if (view) {
        [view addSubview:self];
        if (self.isShowLan) {
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        self.center = CGPointMake(kScreenHeight/2.0, kScreenWidth/2.0);
    } else {
        [self.overlayWindow addSubview:self];
        [self.overlayWindow makeKeyAndVisible];
        if (self.isShowLan) {
            self.overlayWindow.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        self.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
    }
    
    // 快速显示一个提示信息
    self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    if (suState == 1) {
        if (self.successImage) {
            self.hud.customView = [[UIImageView alloc] initWithImage:self.successImage];
        }
    } else if (suState == 2) {
        if (self.errorImage) {
            self.hud.customView = [[UIImageView alloc] initWithImage:self.errorImage];
        }
    }
    [self configHubPara:self.hud];
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.labelText = title;
    self.hud.delegate = self;
    self.hud.yOffset = yOffset;
    [self.hud show:YES];
    [self.hud hide:YES afterDelay:duration];
    
    // 隐藏时候从父控件中移除
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.dimBackground = NO;   // YES代表需要蒙版效果
    self.overlayWindow.userInteractionEnabled = isMark;
}

- (void)showAnnularHubWithWithTitle:(NSString *)title mark:(BOOL)isMark view:(UIView *)view
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    if (view) {
        self.subView = view;
        self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    } else {
        [self.overlayWindow addSubview:self];
        [self.overlayWindow makeKeyAndVisible];
        if (self.isShowLan) {
            self.overlayWindow.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        self.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
        self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    }
    
    [self configHubPara:self.hud];
    self.hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = title;
    self.hud.progress = 0;
    self.hud.color = [UIColor clearColor];
    self.hud.delegate = self;
    
    // 隐藏时候从父控件中移除
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.dimBackground = NO;   // YES代表需要蒙版效果
    self.overlayWindow.userInteractionEnabled = isMark;
}

- (void)showLan
{
    _isShowLan = YES;
}

#pragma mark -

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
