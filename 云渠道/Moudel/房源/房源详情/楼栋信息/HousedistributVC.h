//
//  HousedistributVC.h
//  云渠道
//
//  Created by xiaoq on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "KyoRowIndexView.h"
#import "KyoCenterLineView.h"
@protocol SMCinameSeatScrollViewDelegate;
@interface HousedistributVC : BaseViewController
@property (weak, nonatomic) id<SMCinameSeatScrollViewDelegate> SMCinameSeatScrollViewDelegate;

@property (nonatomic , strong)NSMutableArray *myarr;
@property (nonatomic , strong)NSMutableArray *LDinfo;

//status 0 有返回按钮
@property(nonatomic,strong)NSString * statusStr;

@end

@protocol SMCinameSeatScrollViewDelegate <NSObject>

@optional
- (KyoCinameSeatState)kyoCinameSeatScrollViewSeatStateWithRow:(NSUInteger)row withColumn:(NSUInteger)column;
- (void)kyoCinameSeatScrollViewDidTouchInSeatWithRow:(NSUInteger)row withColumn:(NSUInteger)column;
//返回选中行的数据
-(void)ReturnSelectData:(NSDictionary *)datasource;

@end
