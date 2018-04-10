//
//  HouseSearchVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseSearchVC.h"

@interface HouseSearchVC ()///<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UICollectionView *<#class#>;

@property (nonatomic , strong) UITableView *searchTable;

@property (nonatomic, strong) UITextField *searchBar;

@end

@implementation HouseSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
}

- (void)initUI{
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, STATUS_BAR_HEIGHT + 42 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(40 *SIZE, 6 *SIZE + STATUS_BAR_HEIGHT, 263 *SIZE, 30 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"请输入楼盘地址或名称";
    _searchBar.font = [UIFont systemFontOfSize:11 *SIZE];
    _searchBar.returnKeyType = UIReturnKeySearch;
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.image = [UIImage imageNamed:@"search_2"];
    _searchBar.leftView = rightImg;
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    [whiteView addSubview:self.leftButton];
}

@end
