//
//  ValidVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ValidVC.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"
#import "BrokerageDetailTableCell3.h"

@interface ValidVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_clientid;
    NSString *_endtime;
    NSString *_name;
    NSArray *_Pace;
}
@property (nonatomic , strong) UITableView *validTable;

@property (nonatomic , strong) UIButton *printBtn;

@end

@implementation ValidVC

-(instancetype)initWithClientId:(NSString *)ClientID
{
    self =[super init];
    if (self) {
        _clientid = ClientID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self post];
    [self initDataSouce];
    [self initUI];
}

-(void)post{
    [BaseRequest GET:ValueDetail_URL
          parameters:@{
                @"client_id":_clientid
                        }
             success:^(id resposeObject) {
                 NSLog(@"%@",resposeObject);
                 if ([resposeObject[@"code"] integerValue] ==200) {
                    
                     _titleArr = @[@"推荐信息",@"到访信息"];
                     
                     NSString *sex = @"客户性别：无";
                     if ([resposeObject[@"data"][@"sex"] integerValue] == 1) {
                         sex = @"客户性别：男";
                     }
                     if([resposeObject[@"data"][@"sex"] integerValue] == 2)
                     {
                         sex =@"客户性别：女";
                     }
                     _name = resposeObject[@"data"][@"name"];
                     NSString *tel = resposeObject[@"data"][@"tel"];
                     NSArray *arr = [tel componentsSeparatedByString:@","];
                     if (arr.count>0) {
                         tel = [NSString stringWithFormat:@"联系方式：%@",arr[0]];
                     }
                     else{
                         tel = @"联系方式：无";
                     }
                     NSString *adress = resposeObject[@"data"][@"absolute_address"];
                     adress = [NSString stringWithFormat:@"项目地址：%@-%@-%@ %@",resposeObject[@"data"][@"province_name"],resposeObject[@"data"][@"city_name"],resposeObject[@"data"][@"district_name"],adress];
                     
                     _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",resposeObject[@"data"][@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",resposeObject[@"data"][@"create_time"]],[NSString stringWithFormat:@"推荐人：%@",_name],tel,[NSString stringWithFormat:@"项目名称：%@",resposeObject[@"data"][@"project_name"]],adress],@[[NSString stringWithFormat:@"客户姓名：%@",resposeObject[@"data"][@"name"]],sex,tel,[NSString stringWithFormat:@"到访人数：%@",resposeObject[@"data"][@"name"]],[NSString stringWithFormat:@"到访时间：%@",resposeObject[@"data"][@"name"]],[NSString stringWithFormat:@"接待人员：%@",resposeObject[@"data"][@"name"]],[NSString stringWithFormat:@"到访确认人：%@",resposeObject[@"data"][@"name"]],[NSString stringWithFormat:@"确认人电话：%@",resposeObject[@"data"][@"name"]]]];
                     
                     _endtime = resposeObject[@"data"][@"timeLimit"];
                     _Pace = resposeObject[@"data"][@"process"];
                     [_validTable reloadData];
                     
                 }
                
                
             }
             failure:^(NSError *error) {
                 [self showContent:@"网络错误"];
             }];
}


-(void)initDataSouce
{
    
    _titleArr = @[@"推荐信息",@"到访信息"];
    _data = @[];
}

- (void)ActionPrintBtn:(UIButton *)btn{
    
    
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 2) {
        
        return _Pace.count;
    }
    else
    {
        NSArray *arr = _data[section];
        return arr.count;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = YJTitleLabColor;
    if (section < 2) {
        
        title.text = _titleArr[section];
    }
    [backview addSubview:title];
    return backview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section < 2) {
        
        return 53*SIZE;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _data.count ? _Pace.count?_data.count + 1:_data.count:0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2){
        
        BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
        if (!cell) {
            cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",_Pace[indexPath.row][@"process_name"],_Pace[indexPath.row][@"time"]];
        if (indexPath.row == 0) {
            
            cell.upLine.hidden = YES;
        }else{
            
            cell.upLine.hidden = NO;
        }
        if (indexPath.row == _Pace.count - 1) {
            
            cell.downLine.hidden = YES;
        }else{
            
            cell.downLine.hidden = NO;
        }
        return cell;
    }else{
        static NSString *CellIdentifier = @"InfoDetailCell";
        InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetCellContentbystring:_data[indexPath.section][indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客户到访详情";

    _validTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _validTable.rowHeight = UITableViewAutomaticDimension;
    _validTable.estimatedRowHeight = 150 *SIZE;
    _validTable.backgroundColor = YJBackColor;
    _validTable.delegate = self;
    _validTable.dataSource = self;
    [_validTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_validTable];
    
}

@end
