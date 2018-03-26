
//
//  RoomDetailCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailCollCell.h"

@implementation RoomDetailCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 *SIZE, 64 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        _titleL.textColor = COLOR(27, 152, 255, 1);
    }else{
        
        _titleL.textColor = YJTitleLabColor;
    }
}

@end
