//
//  RoomBrokerageTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomBrokerageTableCell.h"

@implementation RoomBrokerageTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 128 *SIZE)];
    view.backgroundColor = CH_COLOR_white;
    [self.contentView addSubview:view];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 14 *SIZE, 200 *SIZE, 13 *SIZE)];
    _timeL.textColor = YJ86Color;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_timeL];
    
    for (int i = 0; i < 5; i++) {
        
        if (i < 2) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(42 *SIZE, 50 *SIZE + i * 35 *SIZE, 80 *SIZE, 13 *SIZE)];
            label.textColor = YJTitleLabColor;
            label.font = [UIFont systemFontOfSize:13 *SIZE];
            if (i == 0) {
                
                label.text = @"佣金排名：";
            }else{
                
                label.text = @"结佣速度：";
            }
            [self.contentView addSubview:label];
        }
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(114 *SIZE + i * 31 *SIZE, 47 *SIZE, 17 *SIZE, 17 *SIZE)];
        img.image = [UIImage imageNamed:@"star_1"];
        switch (i) {
            case 0:
            {
                _rankImg1 = img;
                [self.contentView addSubview:_rankImg1];
                break;
            }
            case 1:
            {
                _rankImg2 = img;
                [self.contentView addSubview:_rankImg2];
                break;
            }
            case 2:
            {
                _rankImg3 = img;
                [self.contentView addSubview:_rankImg3];
                break;
            }
            case 3:
            {
                _rankImg4 = img;
                [self.contentView addSubview:_rankImg4];
                break;
            }
            case 4:
            {
                _rankImg5 = img;
                [self.contentView addSubview:_rankImg5];
                break;
            }
            default:
                break;
        }
        
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(114 *SIZE + i * 31 *SIZE, 83 *SIZE, 17 *SIZE, 17 *SIZE)];
        img1.image = [UIImage imageNamed:@"lightning_1"];
        switch (i) {
            case 0:
            {
                _speedImg1 = img1;
                [self.contentView addSubview:_speedImg1];
                break;
            }
            case 1:
            {
                _speedImg2 = img1;
                [self.contentView addSubview:_speedImg2];
                break;
            }
            case 2:
            {
                _speedImg3 = img1;
                [self.contentView addSubview:_speedImg3];
                break;
            }
            case 3:
            {
                _speedImg4 = img1;
                [self.contentView addSubview:_speedImg4];
                break;
            }
            case 4:
            {
                _speedImg5 = img1;
                [self.contentView addSubview:_speedImg5];
                break;
            }
            default:
                break;
        }
    }
    
    _ruleView = [[RuleView alloc] initWithFrame:CGRectMake(0, 134 *SIZE, SCREEN_Width, 40 *SIZE)];
    [self.contentView addSubview:_ruleView];
    [_ruleView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(134 *SIZE);
    }];
    
    _standView = [[RuleView alloc] initWithFrame:CGRectMake(0, 180 *SIZE, SCREEN_Width, 40 *SIZE)];
    [self.contentView addSubview:_standView];
    [_standView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(_ruleView.mas_bottom).offset(8 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
