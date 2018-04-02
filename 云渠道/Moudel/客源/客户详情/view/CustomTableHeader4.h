//
//  CustomTableHeader4.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTableHeader4;

typedef void (^showBtnBlock)(NSInteger index);

@interface CustomTableHeader4 : UITableViewHeaderFooterView

@property (nonatomic , copy) showBtnBlock showBtnBlock;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UIButton *showBtn;

@end
