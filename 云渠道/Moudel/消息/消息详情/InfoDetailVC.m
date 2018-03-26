//
//  InfoDetailVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "InfoDetailVC.h"

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
}

-(void)initUI
{
    
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
    
    
    static NSString *CellIdentifier = @"SystemMessageCell";
    
    SystemMessageCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SystemMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoDetailVC * next_vc =[[InfoDetailVC alloc]init];
    [self.navigationController pushViewController:next_vc animated:YES];
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
        _toolview  = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_Height-TAB_BAR_HEIGHT, 360, TAB_BAR_HEIGHT)];
    }
    return _toolview;
}

@end
