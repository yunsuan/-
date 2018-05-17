//
//  InvalidView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BorderTF.h"
#import "DropDownBtn.h"
#import "SinglePickView.h"
#import "DateChooseView.h"

@class InvalidView;

typedef void(^InvalidViewBlock)(void);

typedef void(^InvalidViewBlockFail)(NSString *str);

@interface InvalidView : UIView

@property (nonatomic, copy) InvalidViewBlockFail invalidViewBlockFail;

@property (nonatomic, copy) InvalidViewBlock invalidViewBlock;

@property (nonatomic , strong) NSString *client_id;

@property (nonatomic , strong) NSString *type_id;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UIButton *confirmBtn;

@end
