//
//  BoxView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BoxView.h"

@interface BoxView()//<UITableViewDelegate,UITableViewDataSource>



@end

@implementation BoxView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)initUI{
    
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
    [backView addGestureRecognizer:tap];
    [self addSubview:backView];

}

- (void)ActionTap{
    if (self.superview) {
        [self removeFromSuperview];
    }
}


@end
