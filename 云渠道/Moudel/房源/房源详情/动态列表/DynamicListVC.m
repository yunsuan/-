//
//  DynamicListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DynamicListVC.h"
#import "DynamicListTableCell.h"

@interface DynamicListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTable;

@end

@implementation DynamicListVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DynamicListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DynamicListTableCell"];
    if (!cell) {
        
        cell = [[DynamicListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DynamicListTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = @"云算公馆参考价格5000元/㎡";
    cell.timeL.text = @"2017-02-23   12:45:03";
    cell.contentL.text = @"2017年11月28日讯：云算公馆现房在售，在售房源建筑面积188㎡只余底层且只余一套，三室一厅一卫。";
    cell.cellBtnBlock = ^(NSInteger index) {
        
        
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _listTable.backgroundColor = self.view.backgroundColor;
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_listTable];
}

@end
