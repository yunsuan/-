//
//  DynamicListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DynamicListVC.h"

@interface DynamicListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTable;

@end

@implementation DynamicListVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _listTable.backgroundColor = self.view.backgroundColor;
    _listTable.delegate = self;
    _listTable.dataSource = self;
    
    [self.view addSubview:_listTable];
}

@end
