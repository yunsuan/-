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
    NSMutableArray *_titlelist;
    NSMutableArray *_contentlist;
    NSString *_projectId;
}
@property (nonatomic , strong) UITableView *Mytableview;
-(void)initUI;
-(void)initDataSouce;
@end

@implementation BuildingInfoVC

- (instancetype)initWithProjectId:(NSString *)projectId
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text =@"楼栋详情";

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)initUI
{
    [self.view addSubview:self.Mytableview];
}

-(void)initDataSouce
{
    _titlelist = [NSMutableArray arrayWithArray:@[@[@"项目名称",@"楼盘状态",@"开发商",@"区域位置",@"设计公司",@"楼盘地址",@"售楼处地址"],@[@"建筑类型",@"均价",@"价格区间",@"占地面积",@"装修标准",@"建筑面积",@"容积率",@"绿化率",@"规划户数",@"规划车位"],@[@"物业类型",@"物业公司",@"物业费",@"供暖方式",@"供水类型",@"供电类型"]]];
    _contentlist = [@[] mutableCopy];
//    contentlist = @[@[@"项目名称",@"楼盘状态",@"开发商",@"区域位置",@"设计公司",@"楼盘地址",@"售楼处地址jslfjsdjflsdjflsjdlfjsdlkfjlfjsladjklasjfl"],@[@"建筑类型",@"均价",@"价格区间",@"占地面积物业费物业费物业费物业费物业费物业费物业费物业费物业费物业费物业费物业费物业费",@"装修标准",@"建筑面积",@"容积率",@"绿化率",@"规划户数",@"规划车位"],@[@"物业类型",@"物业公司",@"物业费",@"供暖方式",@"供水类型",@"供电类型"],@[@"发证时间",@"2016-06-08"]];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectBuildInfo_URL parameters:@{@"project_id":_projectId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    
    NSArray *arr1 = @[data[@"project_name"],data[@"sale_state"],data[@"developer_name"],[NSString stringWithFormat:@"%@-%@-%@",data[@"province_name"],data[@"city_name"],data[@"district_name"]],data[@"decoration_company"],data[@"absolute_address"],data[@"sale_address"]];
    NSArray *arr2 = @[data[@"build_type"],[NSString stringWithFormat:@"%@元/㎡",data[@"average_price"]],[NSString stringWithFormat:@"%@万-%@万",data[@"min_price"],data[@"max_price"]],[NSString stringWithFormat:@"%@㎡ ",data[@"floor_space"]],data[@"decoration_standard"],[NSString stringWithFormat:@"%@㎡",data[@"covered_area"]],[NSString stringWithFormat:@"%@",data[@"plot_retio"]],[NSString stringWithFormat:@"%@%@",data[@"greening_rate"],@"%"],[NSString stringWithFormat:@"%@",data[@"households_num"]],[NSString stringWithFormat:@"%@",data[@"parking_num"]]];
    NSArray *arr3 = @[[data[@"property"] componentsJoinedByString:@","],data[@"property_company_name"],[NSString stringWithFormat:@"%@元/㎡/月",data[@"property_cost"]],data[@"heat_supply"],data[@"water_supply"],data[@"power_supply"]];
    
    NSArray *tempArr = @[@"发证时间"];
    NSMutableArray *arr4 = [NSMutableArray arrayWithArray:tempArr];
    for (NSDictionary *dic in data[@"sale_permit"]) {
        
        [arr4 addObject:dic[@"permit_time"]];
    }
    NSArray *tempArr1 = @[@"预售许可证"];
    NSMutableArray *arr5 = [NSMutableArray arrayWithArray:tempArr1];
    for (NSDictionary *dic in data[@"sale_permit"]) {
        
        [arr5 addObject:dic[@"sale_permit"]];
    }
    
    [_titlelist addObject:arr5];
    
    
    [_contentlist addObject:arr1];
    [_contentlist addObject:arr2];
    [_contentlist addObject:arr3];
    [_contentlist addObject:arr4];
    
    [_Mytableview reloadData];
}

#pragma mark  ---  delegate  ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section !=3) {
        NSArray *arr= _titlelist[section];
        return arr.count;
//    }
//    else{
//        return 1;
//    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _contentlist.count;
    
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
        [cell settitle:_titlelist[indexPath.section][indexPath.row] content:_contentlist[indexPath.section][indexPath.row]];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"LicenceCell";
        LicenceCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[LicenceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if (indexPath.row == 0) {
            
            cell.titlelab.textColor = YJContentLabColor;
            cell.contentlab.textColor = YJContentLabColor;
        }else{
            
            cell.titlelab.textColor = YJTitleLabColor;
            cell.contentlab.textColor = YJTitleLabColor;
        }
        [cell settitle:_titlelist[indexPath.section][indexPath.row] content:_contentlist[indexPath.section][indexPath.row]];
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


        
        _Mytableview =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _Mytableview.rowHeight = UITableViewAutomaticDimension;
        _Mytableview.estimatedRowHeight = 34.4 *SIZE;
        _Mytableview.backgroundColor = YJBackColor;
        _Mytableview.delegate = self;
        _Mytableview.dataSource = self;

        [_Mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _Mytableview;
}


@end
