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

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return 1;
//}

- (void)initUI{
    
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
    [backView addGestureRecognizer:tap];
    [self addSubview:backView];
    
//    _mainTable = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
//    _mainTable.backgroundColor = YJBackColor;;
//    _mainTable.delegate = self;
//    _mainTable.dataSource = self;
//    [self addSubview:_mainTable];
}

- (void)ActionTap{
    if (self.superview) {
        [self removeFromSuperview];
    }
}


@end
