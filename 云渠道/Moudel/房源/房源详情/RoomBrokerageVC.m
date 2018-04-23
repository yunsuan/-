//
//  RoomBrokerageVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomBrokerageVC.h"

@interface RoomBrokerageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *brokerageTable;

@end

@implementation RoomBrokerageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    
    _brokerageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _brokerageTable.backgroundColor = self.view.backgroundColor;
    _brokerageTable.delegate = self;
    _brokerageTable.dataSource = self;
    _brokerageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_brokerageTable];
}



@end
