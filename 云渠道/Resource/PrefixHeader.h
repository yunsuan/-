//
//  PrefixHeader.h
//  易家
//
//  Created by xiaoq on 2017/11/8.
//  Copyright © 2017年 xiaoq. All rights reserved.
//

///
//  Header.h
//  云算
//
//  Created by xiaoq on 2017/3/27.
//  Copyright © 2017年 xiaoqcd. All rights reserved.
//


#ifndef PrefixHeader_pch
#define PrefixHeader_pch
#import <Availability.h>

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif

#import "MJRefresh.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Radar/BMKRadarOption.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "NetConfig.h"
//#import <BaiduMapAPI_Map/BMKMapView.h>

#import <Masonry.h>
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "UserModel.h"
#import "UserInfoModel.h"
#import "UserModelArchiver.h"
#import "BaseRequest.h"
#import "GZQGifHeader.h"
#import "GZQGifFooter.h"
#import "WaitAnimation.h"
#import <UMShare/UMShare.h>
#import "TransmitView.h"
#import "SelectWorkerView.h"
#import "ReportCustomConfirmView.h"
#import "ReportCustomSuccessView.h"



#ifndef deviceVersion
#define deviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#endif
#define sIZE [UIScreen mainScreen].bounds.size.width/360
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
#define IMAGE_WITH_NAME(x) [UIImage imageNamed:[NSString stringWithFormat:@"%@",x]]



#define TestBase_Net  [[[NSMutableArray alloc]initWithContentsOfFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"ServerControl.plist"]] objectAtIndex:0]


#define COLOR_RGB(_R,_G,_B,_A)[UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:_A]

#define cycleScrollViewHeight 170 * SIZE
#define FROMFORLEFT  20 * SIZE
#define PLINEHEIGHT    0.5*SIZE

#define JpushAppKey @"2dd909361c253b51e0cd05a9"

#define YQDversion @"2.6"

#define ACCESSROLE @"agent"

// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
#define TAB_BAR_MORE (iPhoneX ? 34.f : 0)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

#define LOGINENTIFIER @"logIndentifier"
#define LOGINSUCCESS @"logInSuccessdentifier"
#define HUANPASSWORD @"1111"

#define UmengAppkey @"5ac9debcb27b0a2147000050"
#define QQAPPID @"1106811849"
#define QQAppkey @"Yik2oC5WcDQ5IOrpc"
#define WechatAppId @"wx3e34d92e8b8cb53e"
#define WechatSecret @"200ee15186843d67c0d9ba6a66f3a6ba"
#define redirectUrl @"http://www.ccsoft.com.cn/"

#define __KPropretyLaebl(key) @property(nonatomic,copy) UILabel *key;
#define __KPropretyImageView(key) @property(nonatomic,copy) UIImageView *key;
#define __KPropretyButton(key) @property(nonatomic,copy) UIButton *key;
#define __KPropretyString(key) @property(nonatomic,copy) NSString *key;


#define CGM(_X,_Y,_W,_H) CGRectMake(_X,_Y,_W,_H)
#define CGP(_X,_Y) CGPointMake(_X,_Y)
#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )

#define NAV_Height [[UIScreen mainScreen] bounds].size.width * 38/320.0
#define TABBAR_Height [[UIScreen mainScreen] bounds].size.width * 30/320.0
#define CGRM(_X,_Y,_W,_H)  CGRectMake(_X, _Y, _W, _H)
#define CGPM(_X,_Y)  CGPointMake(_X, _Y)
#define CGSM(_w,_h) CGSizeMake(_w, _h)
#define COLOR_a [UIColor colorWithRed:arc4random() % 250 / 255.0f green:arc4random() % 250 / 255.0f blue:arc4random() % 250 / 255.0f alpha:1]
#define COLOR(_R,_G,_B,_A) [UIColor colorWithRed:_R / 255.0f green: _G / 255.0f blue:_B / 255.0f alpha:_A]
#define IMAGE(_NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:_NAME]]
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)
//设置字体
#define FONT(a) [UIFont systemFontOfSize:a]

#define YJBackColor  COLOR(240, 240, 240, 1)
#define YJTitleLabColor  COLOR(51, 51, 51, 1)
#define YJContentLabColor  COLOR(115, 115, 115, 1)
#define YJ86Color   COLOR(86, 86, 86, 1)
#define YJ170Color   COLOR(170, 170, 170, 1)
#define YJGreenColor  COLOR(60, 191, 75, 1)
#define YJLoginBtnColor   COLOR(0x1b, 0x80, 0xfe, 1)
#define YJBlueBtnColor   COLOR(27, 152, 255, 1)

/**
 *  第一部分,颜色部分
 */
#define CH_COLOR_normal(_R,_G,_B) [UIColor colorWithRed:_R / 255.0f green:_G / 255.0f blue:_B / 255.0f alpha:1]
#define CH_COLOR_alpha(_R,_G,_B,_A) [UIColor colorWithRed:_R / 255.0f green:_G / 255.0f blue:_B / 255.0f alpha:_A]
#define CH_COLOR_gray(_light,_alpha) [UIColor colorWithRed:_light green:_light blue:_light alpha:_alpha]
#define CH_COLOR_white [UIColor whiteColor]
#define CH_COLOR_clear [UIColor clearColor]
#define CH_COLOR_image(_imageName) [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:_imageName]]]

/**
 *  第二部分,关于屏幕尺寸
 */
#define SIZE ([UIScreen mainScreen].bounds.size.width/360)
#define CH_SCREEN_width [[UIScreen mainScreen] bounds].size.width
#define CH_SCREEN_height [[UIScreen mainScreen] bounds].size.height
#define CH_SCREEN_ipadWidth 1024
#define CH_SCREEN_ipadHight 768
#define CH_SCREEN_frame [[UIScreen mainScreen] bounds]
#define CH_SCREEN_size [[UIScreen mainScreen] bounds].size
#define CH_SCREEN_4 [[UIScreen mainScreen] bounds].size.height > 500 ? YES : NO

#define CH_Status_height 20
#define CH_Navbar_height 64
#define CH_Tabbar_height 48
#define BVERSION @"version"
/**
 *  第三部分,关于系统
 */
#define CH_IOS7 ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define CH_AppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define CH_RootController [[[UIApplication sharedApplication] delegate] window].rootViewController
#define CH_UserDefaults [NSUserDefaults standardUserDefaults]
#define CH_FileManager [NSFileManager defaultManager]

/**
 *  第四部分,关于视图尺寸
 */
#define CH_VIEW_size(_view) _view.frame.size
#define CH_VIEW_centerX(_view) _view.center.x
#define CH_VIEW_centerY(_view) _view.center.y
#define CH_VIEW_width(_view) _view.frame.size.width
#define CH_VIEW_height(_view) _view.frame.size.height

/**
 *  第五部分,关于文件缓存管理
 */
#define CH_Caches_Temp [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/Temp"]
#define CH_Caches_Temp_Voice [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/Temp/VoiceNoteCache"]
#define CH_Caches_Temp_VidioCahe [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/Temp/VideoCache"]
#define CH_Caches_Temp_UserData [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/Temp/UserData"]
#define CH_Documents_Dicrectory [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()]
#define CH_FileManager [NSFileManager defaultManager]

/**
 *  第六部分,关于简单方法
 */
#define CH_IMAGE(_name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:_name]]
#define CH_Font_Sys(_size) [UIFont systemFontOfSize:_size]
#define CH_Font_Bold(_size) [UIFont boldSystemFontOfSize:_size]
#define CH_CGRM(_x,_y,_w,_h) CGRectMake(_x, _y, _w, _h)
#define CH_CGPM(_x,_y) CGPointMake(_x, _y)
#define CH_CGSM(_w,_h) CGSizeMake(_w, _h)

/**
 *新增
 */
#define FyColor_ZhutiColor  COLOR(18, 183, 245, 1)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf)  __strong __typeof(&*self)strongSelf = self;

#endif /* Header_h */
