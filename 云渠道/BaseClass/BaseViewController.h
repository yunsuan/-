//
//  BaseViewController.h
//  易家
//
//  Created by xiaoq on 2017/11/8.
//  Copyright © 2017年 xiaoq. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ConfigState){
    BANK_TYPE=1, //银行类型
    CARD_TYPE=2, //证件类型
    COMMISSION_TYPE=3, //提成方式
    COMPLAINT_TYPE=4, //投诉方式
    COMPLAINT_RESOLVE_TYPE=5, //投诉解决方式
    CONTRACT_END_REASON=6, //合同终止原因
    ENABLED_TYPE=7, //禁用类型
    HOUSE_OLD=8,//房龄
    HOUSE_TYPE=9,//住房类型
    MONEY_TYPE=10,//货币类型
    OPEN_TYPE=11,//开盘方式
    BUY_TYPE=12,//置业目的
    PAY_WAY=13,//支付方式
    PROJECT_IMG_TYPE=14,//项目图片类型
    PROJECT_TAGS_DEFAULT=15,//项目标签默认
    PROPERTY_TYPE=16,//物业类型
    BUILD_TYPE=17,//建筑类型
    USER_DISABLED_TYPE=18,//用户失效类型
    FACE=19,//朝向
    LADDER_RATIO=20,//梯户比
    DECORATE=21, //装修标准、
    AVERAGE=22, //均价
    FOLLOW_TYPE=23,//跟进方式
    APPEAL_TYPE=24,   //申述类型
    TOTAL_PRICE = 25,    //总价
    AREA = 26   //面积
};


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

//返回按钮；
- (void)ActionMaskBtn:(UIButton *)btn;

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

- (BOOL)isEmpty:(NSString *)str;

//图片压缩至希望的大小
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;

//拍照后对图片进行处理
- (UIImage *)fixOrientation:(UIImage *)aImage;

-(NSString * _Nonnull)gettime:(NSDate * _Nonnull)date;//服务器时间转字符转

-(NSArray *)getDetailConfigArrByConfigState:(ConfigState)configState;

@end

