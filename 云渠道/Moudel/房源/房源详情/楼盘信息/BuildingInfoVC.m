//
//  BuildingInfoVC.m
//  云渠道
//
//  Created by xiaoq on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BuildingInfoVC.h"
#import "BuildinginfoCell.h"
#import "LicenceCell.h"

@interface BuildingInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titlelist;
    NSArray *contentlist;
}
@property (nonatomic , strong) UITableView *Mytableview;
-(void)initUI;
-(void)initDataSouce;
@end

@implementation BuildingInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text =@"楼栋详情";
//    _Mytableview.rowHeight = 34.4 *SIZE;
//    _Mytableview.estimatedRowHeight = UITableViewAutomaticDimension;

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //设置隐藏
}

-(void)initUI
{
    [self.view addSubview:self.Mytableview];
}

-(void)initDataSouce
{
    titlelist = @[@[@"项目名称",@"楼盘状态",@"开发商",@"区域位置",@"设计公司",@"楼盘地址",@"售楼处地址"],@[@"建筑类型",@"均价",@"价格区间",@"占地面积",@"装修标准",@"建筑面积",@"容积率",@"绿化率",@"规划户数",@"规划车位"],@[@"物业类型",@"物业公司",@"物业费",@"供暖方式",@"供水类型",@"供电类型"],@[@"预售许可证",@"成房预售中心城区字第2365号"]];
    contentlist = @[@[@"项目名称",@"楼盘状态",@"开发商",@"区域位置",@"设计公司",@"楼盘地址",@"售楼处地址jslfjsdjflsdjflsjdlfjsdlkfjlfjsladjklasjfl"],@[@"建筑类型",@"均价",@"价格区间",@"占地面积物业费物业费物业费物业费物业费物业费物业费物业费物业费物业费物业费物业费物业费",@"装修标准",@"建筑面积",@"容积率",@"绿化率",@"规划户数",@"规划车位"],@[@"物业类型",@"物业公司",@"物业费",@"供暖方式",@"供水类型",@"供电类型"],@[@"发证时间",@"2016-06-08"]];
}

#pragma mark  ---  delegate  ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section !=3) {
        NSArray *arr= titlelist[section];
        return arr.count;
//    }
//    else{
//        return 1;
//    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 43.3*SIZE;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (!section) {
        
        return 2 *SIZE;
    }
    return 7 *SIZE;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 10*SIZE)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section !=3) {
        static NSString *CellIdentifier = @"BuildinginfoCell";
        
        BuildinginfoCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[BuildinginfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        [cell settitle:titlelist[indexPath.section][indexPath.row] content:contentlist[indexPath.section][indexPath.row]];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
    static NSString *CellIdentifier = @"LicenceCell";
    LicenceCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LicenceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell settitle:titlelist[indexPath.section][indexPath.row] content:contentlist[indexPath.section][indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
}

#pragma mark  ---  懒加载   ---

-(UITableView *)Mytableview
{
    if(!_Mytableview)
    {
        _Mytableview.rowHeight = 34.4 *SIZE;
        _Mytableview.estimatedRowHeight = UITableViewAutomaticDimension;
        _Mytableview =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _Mytableview.backgroundColor = YJBackColor;
        _Mytableview.delegate = self;
        _Mytableview.dataSource = self;

        [_Mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _Mytableview;
}


@end
