//
//  CustomMatchListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomMatchListVC.h"
#import "RoomDetailTableCell5.h"

@interface CustomMatchListVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic , strong) UITableView *matchTable;

@property (nonatomic, strong) UITextField *searchBar;

@end

@implementation CustomMatchListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomDetailTableCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetailTableCell5"];
    if (!cell) {
        
        cell = [[RoomDetailTableCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetailTableCell5"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameL.text = @"张三";
    cell.priceL.text = @"80 - 100";
    cell.typeL.text = @"三室一厅";
    cell.areaL.text = @"郫都区-德源大道";
    cell.intentionRateL.text = @"23";
    cell.urgentRateL.text = @"43";
    cell.matchRateL.text = @"83";
    cell.phoneL.text = @"13438339177";
    
    return cell;
}

- (void)initUI{
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, STATUS_BAR_HEIGHT + 62 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(38 *SIZE, 14 *SIZE + STATUS_BAR_HEIGHT, 283 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"客户姓名/电话";
    _searchBar.font = [UIFont systemFontOfSize:11 *SIZE];
    _searchBar.returnKeyType = UIReturnKeySearch;
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.backgroundColor = YJGreenColor;
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    _matchTable = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 62 *SIZE, SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 62 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];;
    _matchTable.backgroundColor = self.view.backgroundColor;
    _matchTable.delegate = self;
    _matchTable.dataSource = self;
    _matchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_matchTable];
}

@end
