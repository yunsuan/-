//
//  RoomDetailTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableHeader.h"

@implementation RoomDetailTableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    _imgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 183 *SIZE)];
    _imgScroll.backgroundColor = YJGreenColor;
    [self.contentView addSubview:_imgScroll];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 11 *SIZE + CGRectGetMaxY(_imgScroll.frame), 280 *SIZE, 13 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(321 *SIZE, 11 *SIZE + CGRectGetMaxY(_imgScroll.frame), 30 *SIZE, 12 *SIZE)];
    _statusL.textColor = COLOR(27, 152, 255, 1);
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _attentL = [[UILabel alloc] initWithFrame:CGRectMake(269 *SIZE, 32 *SIZE + CGRectGetMaxY(_imgScroll.frame), 80 *SIZE, 12 *SIZE)];
    _attentL.textColor = YJContentLabColor;
    _attentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _attentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_attentL];
    
    _payL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 100 *SIZE + CGRectGetMaxY(_imgScroll.frame), 300 *SIZE, 12 *SIZE)];
    _payL.textColor = YJContentLabColor;
    _payL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_payL];
    
    _priceL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 123 *SIZE + CGRectGetMaxY(_imgScroll.frame), 280 *SIZE, 17 *SIZE)];
    _priceL.textColor = YJContentLabColor;
    _priceL.font = [UIFont systemFontOfSize:10 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _addressL = [[UILabel alloc] initWithFrame:CGRectMake(31 *SIZE, 155 *SIZE + CGRectGetMaxY(_imgScroll.frame), 300 *SIZE, 11 *SIZE)];
    _addressL.textColor = YJContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_addressL];
    
}

@end
