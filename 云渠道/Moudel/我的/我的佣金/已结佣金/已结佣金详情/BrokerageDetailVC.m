//
//  BrokerageDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageDetailVC.h"

@interface BrokerageDetailVC ()

@property (nonatomic, strong) UITableView *brokerTable;

@end

@implementation BrokerageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

- (void)initUI{
    
    self.titleLabel.text = @"已结佣金详情";
    
    
}

@end
