//
//  InfoDetailVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "InfoDetailVC.h"
#import "InfoDetailCell.h"

@interface InfoDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *Maintableview;
@property (nonatomic , strong) UIView *toolview;

-(void)initUI;
-(void)initDataSouce;
@end

@implementation InfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"消息详情";
    _Maintableview.rowHeight = 150 *SIZE;
    _Maintableview.estimatedRowHeight = UITableViewAutomaticDimension;
    [self initDataSouce];
    [self initUI];
}

-(void)initUI
{
    [self.view addSubview:self.Maintableview];
    [self.view addSubview:self.toolview];
}

-(void)initDataSouce
{
    
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"InfoDetailCell";
    
    InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell SetCellContentbyarr:@[@"项目名称：凤凰国际",@"项目地址：高新区-天府三街-000号",@"推荐时间：2017-10-23  19:00:00"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}


#pragma mark    -----  懒加载    ------

-(UITableView *)Maintableview
{
    if (!_Maintableview) {
        _Maintableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-46.3*SIZE) style:UITableViewStylePlain];
        _Maintableview.backgroundColor = YJBackColor;
        _Maintableview.delegate = self;
        _Maintableview.dataSource = self;
        [_Maintableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _Maintableview;
}


-(UIView *)toolview
{
    if (!_toolview) {
        _toolview  = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_Height-TAB_BAR_HEIGHT, 360*SIZE, TAB_BAR_HEIGHT)];
        _toolview.backgroundColor = YJLoginBtnColor;
    }
    return _toolview;
}

@end
