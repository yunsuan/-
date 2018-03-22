//
//  UnpaidBrokerageVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "UnpaidBrokerageVC.h"

@interface UnpaidBrokerageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_arr;
}
@property (nonatomic , strong) UITableView *MainTableView;




-(void)initUI;
-(void)initDateSouce;
@end

@implementation UnpaidBrokerageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    [self.leftButton addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
    self.titleLabel.text = @"未结列表";
    [self initDateSouce];
    [self initUI];
    
}

-(void)initDateSouce
{
    _arr = @[@[@"学区房",@"投资房"],@[@"简单的",@"送礼物",@"欧美风"],@[@"简单的",@"送礼物",@"欧美风"]];
}

-(void)initUI
{
 
    [self.view addSubview:self.MainTableView];
}

-(void)action_back
{
    
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
    return 133.3*SIZE;
}



//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    if (indexPath.row == 1) {
//        static NSString *CellIdentifier = @"CompanyCell";
//
//        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (!cell) {
//            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        //    [cell setTitle:_namelist[indexPath.row] content:@"123" img:@""];
//        [cell SetTitle:@"新希望国际" image:@"" contentlab:@"高新区——天府三街" statu:@"在售"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }else
//    {
//        static NSString *CellIdentifier = @"PeopleCell";
//
//        PeopleCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (!cell) {
//            cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        //    [cell setTitle:_namelist[indexPath.row] content:@"123" img:@""];
//        [cell SetTitle:@"新希望国际" image:@"" contentlab:@"高新区——天府三街" statu:@"在售"];
//        [cell settagviewWithdata:_arr[indexPath.row]];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
//
//
//}

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
        _MainTableView =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    }
    return _MainTableView;
}



@end
