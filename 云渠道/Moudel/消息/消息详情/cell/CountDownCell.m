//
//  CountDownCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CountDownCell.h"

@implementation CountDownCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    _day = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20*SIZE, 20*SIZE)];
    _day.textColor = YJTitleLabColor;
    [self.contentView addSubview:_day];

}

-(void)setcountdownbytime:(NSInteger)day
{
    if (!_days) {
        _days = day;
        _day.text = [NSString stringWithFormat:@"%ld",day];
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerUpdate) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [timer fire];
    }
}

-(void)timerUpdate
{
    NSInteger a = [_day.text integerValue];
    if (a>0) {
        a--;
        _day.text =  [NSString stringWithFormat:@"%ld",a];
    }
}


@end
