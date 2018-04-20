//
//  HouseSearchVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseSearchVC.h"
#import "CompanyCell.h"
#import "PeopleCell.h"
#import "RoomDetailVC.h"

@interface HouseSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSArray *_arr;
}
@property (nonatomic , strong) UITableView *searchTable;

@end

@implementation HouseSearchVC

- (instancetype)initWithTitle:(NSString *)str
{
    self = [super init];
    if (self) {
        
        self.title = str;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr = @[@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区dd房",@"投资房"]],@[@[@"住宅",@"写字楼",@"商铺",@"别墅",@"公寓"],@[@"学区房",@"投资房的"]]];
    [self initUI];
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
        [cell settagviewWithdata:_arr[indexPath.row]];
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
        [cell settagviewWithdata:_arr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RoomDetailVC *nextVC = [[RoomDetailVC alloc] init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
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

- (void)initUI{
    
    _searchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, SCREEN_Height - STATUS_BAR_HEIGHT) style:UITableViewStylePlain];
    _searchTable.backgroundColor = YJBackColor;
    _searchTable.delegate = self;
    _searchTable.dataSource = self;
    [_searchTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_searchTable];
}

@end
