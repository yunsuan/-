//
//  BorderTF.m
//  云渠道
//
//  Created by xiaoq on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BorderTF.h"

@implementation BorderTF

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5*SIZE;
        self.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
        self.layer.borderWidth = 1*SIZE;
        [self addSubview:self.textfield];
  
    }
    return self;
}

-(UITextField *)textfield
{
    if (!_textfield) {
        _textfield = [[UITextField alloc]initWithFrame:CGRectMake(10.7*SIZE, 10.7*SIZE, self.frame.size.width-21.4*SIZE, 14*SIZE)];
        _textfield.textColor = YJContentLabColor;
        _textfield.font = [UIFont systemFontOfSize:13.3*SIZE];
    }
    return _textfield;
}

@end
