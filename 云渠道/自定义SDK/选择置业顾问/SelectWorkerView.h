//
//  SelectWorkerView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/8/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SinglePickView.h"

typedef void(^SelectWorkerRecommendBlock)(void);

@interface SelectWorkerView : UIView

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) SinglePickView *pick;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, copy)  SelectWorkerRecommendBlock selectWorkerRecommendBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIView *nameView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *dropImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIButton *nameBtn;

@property (nonatomic, strong) UIButton *recommendBtn;

@end
