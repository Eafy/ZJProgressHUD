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

/// 进度框提示进度值
@property (nonatomic,assign) CGFloat progress;
/// 成功图片，不设置使用默认图片
@property (nonatomic,strong) UIImage *_Nullable successImage;
/// 失败或错误图片，不设置使用默认图片
@property (nonatomic,strong) UIImage * _Nullable errorImage;

/// 隐藏
+ (void)hideHUD;
/// 影藏进度提示框
+ (void)hideProcessHUD;

/// 显示带遮罩层提示框
/// @param title 提示语
+ (void)showMessage:(NSString *_Nonnull)title;

/// 显示带遮罩层提示框（横屏）
/// @param title 提示语
+ (void)showLanMessage:(NSString * _Nonnull)title;

/// 显示不带遮罩层提示框
/// @param title 提示语
+ (void)showMessageForNoMark:(NSString * _Nonnull)title;

/// 显示不带遮罩层提示框（横屏）
/// @param title 提示语
+ (void)showLanMessageForNoMark:(NSString * _Nonnull)title;

/// 显示加载框，文字：Loading...
+ (void)showLoading;
/// 显示横屏加载框，文字：Loading...
+ (void)showLoadingForNoMark;

/// 显示设置框，文字：Setting...
+ (void)showSetting;
/// 显示横屏设置框，文字：Setting...
+ (void)showSettingForNoMark;

/// 显示提交框，文字：submitting...
+ (void)showSubmitting;
/// 显示横屏提交框，文字：submitting...
+ (void)showLanSubmitting;
+ (void)showSubmittingForNoMark;
+ (void)showLanSubmittingForNoMark;

/// 显示状态提示框
/// @param title 提示语
/// @param duration 多少秒之后隐藏
+ (void)showStatusWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;

/// 显示状态提示框
/// @param title 提示语
/// @param duration 多少秒之后隐藏
/// @param yOffset 相对于中心点垂直偏移值
+ (void)showStatusWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;

/// 显示在某个视图上的状态提示框（非遮罩）
/// @param title 提示语
/// @param duration 多少秒之后隐藏
/// @param view 需要加载的那个视图
+ (void)showStatusWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration view:(UIView * _Nullable)view;

/// 显示在某个视图上的状态提示框（非遮罩）
/// @param title 提示语
/// @param duration 多少秒之后隐藏
/// @param view 需要加载的那个视图
/// @param yOffset 相对于中心点垂直偏移值
+ (void)showStatusWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration view:(UIView * _Nullable)view yOffset:(CGFloat)yOffset;

/// 成功提示框
/// @param title 提示语
/// @param duration 多少秒后隐藏
+ (void)showSuccessWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)showSuccessWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)showLanSuccessWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)showLanSuccessWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;

/// 成功提示框
/// @param title 提示语
/// @param duration 多少秒后隐藏
/// @param yOffset 相对于中心点垂直偏移值
+ (void)showSuccessWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;
+ (void)showSuccessWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;

/// 错误/失败提示框
/// @param title 提示语
/// @param duration 多少秒后隐藏
+ (void)showErrorWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)showLanErrorWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)showErrorWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;
+ (void)showLanErrorWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration;

/// 错误/失败提示框
/// @param title 提示语
/// @param duration 多少秒后隐藏
/// @param yOffset 相对于中心点垂直偏移值
+ (void)showErrorWithTitle:(NSString * _Nonnull)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;
+ (void)showErrorWithTitleForNoMark:(NSString * _Nonnull)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;

/// 显示进度加载框
/// @param title 加载提示语
/// @param view 需要加载的父类视图
+ (ZJProgressHUD * _Nonnull)showAnnularHubWithWithTitle:(NSString * _Nonnull)title view:(UIView * _Nullable)view;

@end
