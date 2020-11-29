//
//  ZJProgressHUD.h
//  ZJProgressHUD
//
//  Created by eafy on 2015/11/24.
//  Copyright © 2015 ZJ. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZJProgressHUD : UIView

+ (instancetype _Nonnull )shared;

/// 进度框提示进度值
@property (nonatomic,assign) CGFloat progress;
/// 成功图片，不设置使用默认图片
@property (nonatomic,strong) UIImage *_Nullable successImage;
/// 失败或错误图片，不设置使用默认图片
@property (nonatomic,strong) UIImage * _Nullable errorImage;
/// 显示文字字体大小，默认：常规16
@property (nonatomic,strong) UIFont * _Nullable font;
/// 显示文字颜色，默认白色
@property (nonatomic,strong) UIColor * _Nullable titleColor;

/// 隐藏
+ (void)hide;

/// 影藏进度提示框
+ (void)hideProcess;

/// 移除
+ (void)dismiss;

/// 显示带遮罩层提示框
/// @param title 提示语
+ (void)message:(NSString *_Nonnull)title;

/// 显示带遮罩层提示框（横屏）
/// @param title 提示语
+ (void)lanMessage:(NSString * _Nonnull)title;

/// 显示不带遮罩层提示框
/// @param title 提示语
+ (void)messageForNoMark:(NSString * _Nonnull)title;

/// 显示不带遮罩层提示框（横屏）
/// @param title 提示语
+ (void)lanMessageForNoMark:(NSString * _Nonnull)title;

/// 显示加载框，文字：Loading...
+ (void)loading;
/// 显示横屏加载框，文字：Loading...
+ (void)loadingForNoMark;

/// 显示设置框，文字：Setting...
+ (void)setting;
/// 显示横屏设置框，文字：Setting...
+ (void)settingForNoMark;

/// 显示提交框，文字：submitting...
+ (void)submitting;
/// 显示横屏提交框，文字：submitting...
+ (void)lanSubmitting;
+ (void)submittingForNoMark;
+ (void)lanSubmittingForNoMark;

/// 显示状态提示框
/// @param title 提示语
/// @param duration 多少秒之后隐藏
+ (void)statusWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;

/// 显示状态提示框
/// @param title 提示语
/// @param duration 多少秒之后隐藏
/// @param yOffset 相对于中心点垂直偏移值
+ (void)statusWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;

/// 显示在某个视图上的状态提示框（非遮罩）
/// @param title 提示语
/// @param duration 多少秒之后隐藏
/// @param view 需要加载的那个视图
+ (void)statusWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration view:(UIView * _Nullable)view;

/// 显示在某个视图上的状态提示框（非遮罩）
/// @param title 提示语
/// @param duration 多少秒之后隐藏
/// @param view 需要加载的那个视图
/// @param yOffset 相对于中心点垂直偏移值
+ (void)statusWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration view:(UIView * _Nullable)view yOffset:(CGFloat)yOffset;

/// 成功提示框
/// @param title 提示语
/// @param duration 多少秒后隐藏
+ (void)successWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)successWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)lanSuccessWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)lanSuccessWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;

/// 成功提示框
/// @param title 提示语
/// @param duration 多少秒后隐藏
/// @param yOffset 相对于中心点垂直偏移值
+ (void)successWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;
+ (void)successWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;

/// 错误/失败提示框
/// @param title 提示语
/// @param duration 多少秒后隐藏
+ (void)errorWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)lanErrorWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)errorWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)lanErrorWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;

/// 错误/失败提示框
/// @param title 提示语
/// @param duration 多少秒后隐藏
/// @param yOffset 相对于中心点垂直偏移值
+ (void)errorWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;
+ (void)errorWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;

/// 显示进度加载框
/// @param title 加载提示语
/// @param view 需要加载的父类视图
+ (ZJProgressHUD * _Nonnull)annularHubWithWithTitle:(NSString * _Nonnull)title view:(UIView * _Nullable)view;

@end