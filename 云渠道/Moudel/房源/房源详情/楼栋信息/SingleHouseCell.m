//
//  SingleHouseCell.m
//  云渠道
//
//  Created by xiaoq on 2018/5/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SingleHouseCell.h"

@implementation SingleHouseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 66 *SIZE, 14 *SIZE)];
    _title.textColor = YJTitleLabColor;
    _title.font = [UIFont systemFontOfSize:15 *SIZE];
    _title.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_title];
    

   
}


@end
