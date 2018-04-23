//
//  RoomBrokerageTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RuleView.h"

@interface RoomBrokerageTableCell : UITableViewCell

@property (nonatomic, strong) RuleView *ruleView;

@property (nonatomic, strong) RuleView *standView;

@property (nonatomic, strong) UILabel *ruleL;

@property (nonatomic, strong) UILabel *standL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIImageView *rankImg1;

@property (nonatomic, strong) UIImageView *rankImg2;

@property (nonatomic, strong) UIImageView *rankImg3;

@property (nonatomic, strong) UIImageView *rankImg4;

@property (nonatomic, strong) UIImageView *rankImg5;

@property (nonatomic, strong) UIImageView *speedImg1;

@property (nonatomic, strong) UIImageView *speedImg2;

@property (nonatomic, strong) UIImageView *speedImg3;

@property (nonatomic, strong) UIImageView *speedImg4;

@property (nonatomic, strong) UIImageView *speedImg5;

@end
