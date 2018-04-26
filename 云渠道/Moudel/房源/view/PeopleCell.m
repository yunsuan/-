//
//  PeopleCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "PeopleCell.h"

@implementation PeopleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(11.7*SIZE,16.3*SIZE, 100*SIZE, 88.3*SIZE)];
        _imageview.contentMode = UIViewContentModeScaleAspectFill;
        _imageview.clipsToBounds = YES;
        [self.contentView addSubview:_imageview];
        _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(123.3*SIZE, 16*SIZE, 200*SIZE, 14*SIZE)];
        _titlelab.textColor = YJTitleLabColor;
        _titlelab.font = [UIFont boldSystemFontOfSize:13.3*SIZE];
        [self.contentView addSubview:_titlelab];
        _contentlab = [[UILabel alloc]initWithFrame:CGRectMake(124.3*SIZE, 52.7*SIZE, 200*SIZE, 11*SIZE)];
        _contentlab.textColor = YJContentLabColor;
        _contentlab.font =[UIFont systemFontOfSize:10.7*SIZE];
        [self.contentView addSubview:_contentlab];
        
        _rankView = [[RankView alloc] initWithFrame:CGRectMake(123 *SIZE, 36 *SIZE, 80 *SIZE, 12 *SIZE)];
        _rankView.rankL.text = @"佣金:第5名";
        [_rankView.rankL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_rankView).offset(0);
            make.top.equalTo(_rankView).offset(0);
            make.height.equalTo(@(10 *SIZE));
            make.width.equalTo(@(_rankView.rankL.mj_textWith + 5 *SIZE));
        }];
        _rankView.statusImg.image = [UIImage imageNamed:@"falling"];
        [self.contentView addSubview:_rankView];
        
        _getLevel = [[LevelView alloc] initWithFrame:CGRectMake(217 *SIZE, 36 *SIZE, 80 *SIZE, 12 *SIZE)];
        _getLevel.titleL.text = @"结佣";
        [self.contentView addSubview:_getLevel];
        
        _statulab = [[UILabel alloc]initWithFrame:CGRectMake(327.7*SIZE, 15.7*SIZE, 30*SIZE, 13*SIZE)];
        _statulab.textColor = COLOR(27, 152, 255, 1);
        _statulab.font = [UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_statulab];
        _surelab = [[UILabel alloc]initWithFrame:CGRectMake(309.7*SIZE, 52.7*SIZE, 50*SIZE, 11*SIZE)];
        _surelab.textColor = COLOR(255, 165, 29, 1);
        _surelab.font = [UIFont systemFontOfSize:10.7*SIZE];
        _surelab.text = @"保证结佣";
        [self.contentView addSubview:_surelab];
        UIView *lane = [[UIView alloc]initWithFrame:CGRectMake(0*SIZE, 119*SIZE, 360*SIZE, 1*SIZE)];
        lane.backgroundColor = YJBackColor;
        [self.contentView addSubview:lane];
        
    }
    return self;
}

-(void)SetTitle:(NSString *)title image:(NSString *)imagename contentlab:(NSString *)content statu:(NSString *)statu
{
    [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_Net,imagename]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            [UIImage imageNamed:@""];
        }
    }];
    _titlelab.text = title;
    _statulab.text = statu;
    _contentlab.text = content;
}

-(void)settagviewWithdata:(NSArray *)data
{
    _wuyeview = [[TagView alloc]initWithFrame:CGRectMake(124.7*SIZE, 66.7*SIZE, 200*SIZE, 16.7*SIZE) DataSouce:data[0] type:@"0"];
    [self.contentView addSubview:_wuyeview];
    
    _tagview = [[TagView alloc]initWithFrame:CGRectMake(124.7*SIZE, 88*SIZE, 200*SIZE, 16.7*SIZE) DataSouce:data[1] type:@"1"];
    [self.contentView addSubview:_tagview];
}

@end
