//
//  BaseViewController.h
//  易家
//
//  Created by xiaoq on 2017/11/8.
//  Copyright © 2017年 xiaoq. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
//Nav背景
@property (nonatomic, strong)UIView *navBackgroundView;
//Nav标题
@property (nonatomic, strong)UILabel *titleLabel;
//返回按钮
@property (nonatomic, strong)UIButton *leftButton;
//给返回按钮蒙上一层 使其好点击
@property (nonatomic, strong)UIButton *maskButton;

@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic , strong)UIButton *leftviewBtn;

@property (nonatomic, strong) UIView *line;

//弹出框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithCancelBlack:(void(^)(void))CancelBlack WithDefaultBlack:(void(^)(void))defaultBlack;

//没有点击效果的弹出框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1;

//lable自适应宽度
- (CGFloat)setIntroductionText:(NSString *)text fontSize:(CGFloat)fontSize labelWidth:(CGFloat)labelWidth;

//判断是否登录
- (BOOL)isLogin;

//判断是否登陆,没有登陆去登陆
- (BOOL)goToLogin;

/**
 *  检查输入的手机号正确与否
 */
- (BOOL)checkTel:(NSString *)str;


- (BOOL)checkPassword:(NSString *)str;


- (NSString *)isSplitHTTP:(NSString *)string;

- (NSString *)convertToJsonData:(NSDictionary *)dict;

/**
 *  md5加密
 */
-(NSString *)md5:(NSString *)str;

- (void)showContent:(NSString *)str;

//图片压缩至希望的大小
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;

//拍照后对图片进行处理
- (UIImage *)fixOrientation:(UIImage *)aImage;


@end

