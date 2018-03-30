//
//  CustomDetailTableCell3.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagView.h"

@interface CustomDetailTableCell3 : UITableViewCell

@property (nonatomic , strong) UILabel *titleL;

@property (nonatomic , strong) UIImageView *headImg;

@property (nonatomic , strong) UILabel *addressL;

@property (nonatomic , strong) UILabel *rateL;

@property (nonatomic, strong) UIButton *recommentBtn;

@property (nonatomic , strong) TagView *tagview;

@property (nonatomic , strong) TagView *wuyeview;

- (void)settagviewWithdata:(NSArray *)data;

@end
