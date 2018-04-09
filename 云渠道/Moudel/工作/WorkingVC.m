//
//  WorkingVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "WorkingVC.h"
#import "WorkingCell.h"
#import "RecommendVC.h"

@interface WorkingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_namelist;
    NSArray *_imglist;
}

@property (nonatomic , strong) UITableView *MainTableView;

-(void)initUI;
-(void)initDateSouce;
@end

@implementation WorkingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"工作";
     self.leftButton.hidden = YES;
    [self initDateSouce];
    [self initUI];

}

-(void)initDateSouce
{
    _namelist = @[@"推荐",@"被推荐的客户"];
    _imglist = @[@"recommended",@"client"];
}

-(void)initUI
{
    
    [self.view addSubview:self.MainTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WorkingCell";
    
    WorkingCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[WorkingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setTitle:_namelist[indexPath.row] content:@"今日新增 2，有效 21，修改 39" img:_imglist[indexPath.row]];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        RecommendVC *nextVC = [[RecommendVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}



#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1*SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-1*SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        _MainTableView.scrollEnabled = NO;
    }
    return _MainTableView;
}



@end
