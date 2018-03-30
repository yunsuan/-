//
//  CustomDetailTableCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomDetailTableCell3.h"

@implementation CustomDetailTableCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)settagviewWithdata:(NSArray *)data{
    
    _wuyeview = [[TagView alloc]initWithFrame:CGRectMake(124.7*SIZE, 66.7*SIZE, 150*SIZE, 16.7*SIZE) DataSouce:data[0] type:@"0"];
    [self.contentView addSubview:_wuyeview];
    
    _tagview = [[TagView alloc]initWithFrame:CGRectMake(124.7*SIZE, 88*SIZE, 150*SIZE, 16.7*SIZE) DataSouce:data[1] type:@"1"];
    [self.contentView addSubview:_tagview];
    
    [_tagview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(125 *SIZE);
        make.top.equalTo(self.contentView).offset(88 *SIZE);
        make.width.equalTo(@(150 *SIZE));
        make.height.equalTo(@(17 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
        
    }];
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(11.7*SIZE,16.3*SIZE, 100*SIZE, 88.3*SIZE)];
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc]initWithFrame:CGRectMake(123.3*SIZE, 16*SIZE, 200*SIZE, 14*SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:13.3*SIZE];
    [self.contentView addSubview:_titleL];
    
    _addressL = [[UILabel alloc]initWithFrame:CGRectMake(124.3*SIZE, 37*SIZE, 200*SIZE, 11*SIZE)];
    _addressL.textColor = YJContentLabColor;
    _addressL.font =[UIFont systemFontOfSize:10.7*SIZE];
    [self.contentView addSubview:_addressL];
    
    _rateL = [[UILabel alloc]initWithFrame:CGRectMake(327.7*SIZE, 15.7*SIZE, 30*SIZE, 13*SIZE)];
    _rateL.textColor = COLOR(27, 152, 255, 1);
    _rateL.font = [UIFont systemFontOfSize:12*SIZE];
    [self.contentView addSubview:_rateL];

    UIView *lane = [[UIView alloc]initWithFrame:CGRectMake(0*SIZE, 119*SIZE, 360*SIZE, 1*SIZE)];
    lane.backgroundColor = YJBackColor;
    [self.contentView addSubview:lane];

}

@end
