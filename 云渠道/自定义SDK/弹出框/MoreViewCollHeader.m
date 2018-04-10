//
//  MoreViewCollHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MoreViewCollHeader.h"

@implementation MoreViewCollHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 13 *SIZE, SCREEN_Width, 12 *SIZE)];
        label.textColor = YJ86Color;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = @"特色";
        [self addSubview:label];
    }
    return self;
}

@end
