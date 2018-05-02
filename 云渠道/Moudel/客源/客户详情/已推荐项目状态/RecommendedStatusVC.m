//
//  RecommendedStatusVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendedStatusVC.h"
#import "ReStatusTableCell.h"

@interface RecommendedStatusVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *reStatusTable;

@end

@implementation RecommendedStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReStatusTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReStatusTableCell"];
    if (!cell) {
        
        cell = [[ReStatusTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReStatusTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"已推荐项目状态";
    
    _reStatusTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
//    _reStatusTable.direc
    _reStatusTable.backgroundColor = self.view.backgroundColor;
    _reStatusTable.delegate = self;
    _reStatusTable.dataSource = self;
    [self.view addSubview:_reStatusTable];
}

@end
