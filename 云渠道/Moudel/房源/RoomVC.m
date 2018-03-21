//
//  RoomVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomVC.h"
#import "CompanyCell.h"
#import "PeopleCell.h"

@interface RoomVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *MainTableView;
@property (nonatomic , strong) UIView *headerView;



-(void)initUI;
-(void)initDateSouce;
@end

@implementation RoomVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    [self initDateSouce];
    [self initUI];
    
}

-(void)initDateSouce
{
    
}

-(void)initUI
{
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.MainTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 1) {
        static NSString *CellIdentifier = @"CompanyCell";
        
        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //    [cell setTitle:_namelist[indexPath.row] content:@"123" img:@""];
        [cell SetTitle:@"新希望国际" image:@"" contentlab:@"高新区——天府三街" statu:@"在售"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *CellIdentifier = @"PeopleCell";
        
        PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //    [cell setTitle:_namelist[indexPath.row] content:@"123" img:@""];
        [cell SetTitle:@"新希望国际" image:@"" contentlab:@"高新区——天府三街" statu:@"在售"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                NSLog(@"");
            }

            default:
                break;
        }
}



#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+105*SIZE, 360*SIZE, SCREEN_Height-STATUS_BAR_HEIGHT-105*SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    }
    return _MainTableView;
}

-(UIView *)headerView
{
    if (!_headerView ) {
        _headerView = [[UIView alloc ]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT,360*SIZE , 102*SIZE)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

@end
