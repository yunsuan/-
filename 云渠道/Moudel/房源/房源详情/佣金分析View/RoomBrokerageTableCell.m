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

- (void)SetLevel:(NSInteger)level{
    
    switch (level) {
        case 0:
        {
            _speedImg1.image = [UIImage imageNamed:@"lightning_1"];
            _speedImg2.image = [UIImage imageNamed:@"lightning_1"];
            _speedImg3.image = [UIImage imageNamed:@"lightning_1"];
            _speedImg4.image = [UIImage imageNamed:@"lightning_1"];
            _speedImg5.image = [UIImage imageNamed:@"lightning_1"];
            break;
        }
        case 1:
        {
            _speedImg1.image = [UIImage imageNamed:@"lightning"];
            _speedImg2.image = [UIImage imageNamed:@"lightning_1"];
            _speedImg3.image = [UIImage imageNamed:@"lightning_1"];
            _speedImg4.image = [UIImage imageNamed:@"lightning_1"];
            _speedImg5.image = [UIImage imageNamed:@"lightning_1"];
            break;
        }
        case 2:
        {
            _speedImg1.image = [UIImage imageNamed:@"lightning"];
            _speedImg2.image = [UIImage imageNamed:@"lightning"];
            _speedImg3.image = [UIImage imageNamed:@"lightning_1"];
            _speedImg4.image = [UIImage imageNamed:@"lightning_1"];
            _speedImg5.image = [UIImage imageNamed:@"lightning_1"];
            break;
        }
        case 3:
        {
            _speedImg1.image = [UIImage imageNamed:@"lightning"];
            _speedImg2.image = [UIImage imageNamed:@"lightning"];
            _speedImg3.image = [UIImage imageNamed:@"lightning"];
            _speedImg4.image = [UIImage imageNamed:@"lightning_1"];
            _speedImg5.image = [UIImage imageNamed:@"lightning_1"];
            break;
        }
        case 4:
        {
            _speedImg1.image = [UIImage imageNamed:@"lightning"];
            _speedImg2.image = [UIImage imageNamed:@"lightning"];
            _speedImg3.image = [UIImage imageNamed:@"lightning"];
            _speedImg4.image = [UIImage imageNamed:@"lightning"];
            _speedImg5.image = [UIImage imageNamed:@"lightning_1"];
            break;
        }
        case 5:
        {
            _speedImg1.image = [UIImage imageNamed:@"lightning"];
            _speedImg2.image = [UIImage imageNamed:@"lightning"];
            _speedImg3.image = [UIImage imageNamed:@"lightning"];
            _speedImg4.image = [UIImage imageNamed:@"lightning"];
            _speedImg5.image = [UIImage imageNamed:@"lightning"];
            break;
        }
        default:
            _speedImg1.image = [UIImage imageNamed:@"lightning"];
            _speedImg2.image = [UIImage imageNamed:@"lightning"];
            _speedImg3.image = [UIImage imageNamed:@"lightning"];
            _speedImg4.image = [UIImage imageNamed:@"lightning"];
            _speedImg5.image = [UIImage imageNamed:@"lightning"];
            break;
    }
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
        
        if (i < 1) {
            
            UILabel *label = [[UILabel alloc] init];
            label.textColor = YJTitleLabColor;
            label.font = [UIFont systemFontOfSize:13 *SIZE];
            _rankL = label;
            [self.contentView addSubview:_rankL];
            
            UIImageView *img = [[UIImageView alloc] init];
            img.image = [UIImage imageNamed:@"rising"];
            _statusImg = img;
            [self.contentView addSubview:_statusImg];
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
    
    
    
    _ruleView = [[UIView alloc] init];
    _ruleView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_ruleView];
    
    UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(11 *SIZE, 12 *SIZE, 17 *SIZE, 17 *SIZE)];
    titleImg.image = [UIImage imageNamed:@"rules"];
    [_ruleView addSubview:titleImg];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(42 *SIZE, 13 *SIZE, 200 *SIZE, 14 *SIZE)];
    titleL.textColor = YJTitleLabColor;
    titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    titleL.text = @"佣金规则";
    [_ruleView addSubview:titleL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [_ruleView addSubview:line];
    
    _ruleL = [[UILabel alloc] init];
    _ruleL.textColor = YJ86Color;
    _ruleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _ruleL.numberOfLines = 0;
    [_ruleView addSubview:_ruleL];
    
    _standView = [[UIView alloc] init];
    _standView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_standView];
    
    UIImageView *titleImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(11 *SIZE, 12 *SIZE, 17 *SIZE, 17 *SIZE)];
    titleImg2.image = [UIImage imageNamed:@"commission4"];
    [_standView addSubview:titleImg2];
    
    UILabel *titleL2 = [[UILabel alloc] initWithFrame:CGRectMake(42 *SIZE, 13 *SIZE, 200 *SIZE, 14 *SIZE)];
    titleL2.textColor = YJTitleLabColor;
    titleL2.font = [UIFont systemFontOfSize:15 *SIZE];
    titleL2.text = @"结佣标准";
    [_standView addSubview:titleL2];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 39 *SIZE, SCREEN_Width, SIZE)];
    line2.backgroundColor = YJBackColor;
    [_standView addSubview:line2];
    
    _standL = [[UILabel alloc] init];
    _standL.textColor = YJ86Color;
    _standL.font = [UIFont systemFontOfSize:12 *SIZE];
    _standL.numberOfLines = 0;
    [_standView addSubview:_standL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_rankL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(114 *SIZE);
        make.height.equalTo(@(13 *SIZE));
        make.top.equalTo(self.contentView).offset(50 *SIZE);
        make.width.equalTo(@(_rankL.mj_textWith + 5 *SIZE));
    }];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_rankL.mas_right).offset(0);
        make.top.equalTo(self.contentView).offset(50 *SIZE);
        make.height.equalTo(@(17 *SIZE));
        make.width.equalTo(@(17 *SIZE));
    }];
    
    [_ruleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(134 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_ruleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_ruleView).offset(41 *SIZE);
        make.top.equalTo(_ruleView).offset(58 *SIZE);
        make.width.mas_equalTo(304 *SIZE);
        make.bottom.equalTo(_ruleView).offset(-31 *SIZE);
    }];
    
    [_standView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_ruleView.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_standL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_standView).offset(41 *SIZE);
        make.top.equalTo(_standView).offset(58 *SIZE);
        make.width.mas_equalTo(304 *SIZE);
        make.bottom.equalTo(_standView).offset(-31 *SIZE);
    }];
}

@end
