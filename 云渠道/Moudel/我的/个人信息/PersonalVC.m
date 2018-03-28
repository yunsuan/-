//
//  PersonalVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "PersonalVC.h"

@interface PersonalVC ()///<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *personTable;

@end

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    
//    _personTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE) style:UITableViewStylePlain];
//    _personTable.backgroundColor = self.view.backgroundColor;
//    _personTable.delegate = self;
//    _personTable.dataSource = self;
//    [self.view addSubview:_personTable];
}


@end
