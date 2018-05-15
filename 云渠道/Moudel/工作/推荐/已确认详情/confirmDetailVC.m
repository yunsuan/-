//
//  confirmDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "confirmDetailVC.h"
#import "InfoDetailCell.h"
#import "CountDownCell.h"

@interface confirmDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_clientId;
    NSMutableDictionary *_dataDic;
}

@property (nonatomic , strong) UITableView *confirmTable;

@end

@implementation confirmDetailVC

- (instancetype)initWithClientId:(NSString *)clientId
{
    self = [super init];
    if (self) {
        
        _clientId = clientId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
}

-(void)initDateSouce
{
    
    _data = @[@"项目名称：凤凰国际",@"项目地址：dafdsfasdfasdfsadfasfasfasdf高新区-天府三街-000号",@"推荐时间：2017-10-23  19:00:00"];
    _titleArr = @[@"客户信息",@"项目信息",@"推荐人信息"];
    _dataDic = [@{} mutableCopy];
    [self WaitConfirmRequest];
}

- (void)WaitConfirmRequest{
    
    [BaseRequest GET:ProjectWaitConfirmDetail_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [_confirmTable reloadData];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 3) {
        
        return 2;
    }
    return 3;

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
    if (section == 0) {
        
        title.text = [NSString stringWithFormat:@"推荐编号：%@",_clientId];
    }else{
        
        title.text = _titleArr[section - 1];
    }
    [backview addSubview:title];
    return backview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 53*SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 5 *SIZE)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (_dataDic.count) {
        
        return 4;
    }else{
        
        return 0;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0 && indexPath.row ==1) {
        static NSString *CellIdentifier = @"CountDownCell";
        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
//                [cell setcountdownbyday:0 hours:0 min:0 sec:30];
        [cell setcountdownbyendtime:_dataDic[@"timeLimit"]];
        cell.countdownblock = ^{
            
            [self refresh];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"InfoDetailCell";
        InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            
            [cell SetCellContentbystring:[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]]];
        }else if (indexPath.section == 1){
            
            if (indexPath.row == 0) {
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]]];
            }else if (indexPath.row == 1){
                
                if ([_dataDic[@"sex"] integerValue] == 0) {
                    
                    [cell SetCellContentbystring:@"客户性别："];
                }else if ([_dataDic[@"sex"] integerValue] == 1) {
                    
                    [cell SetCellContentbystring:[NSString stringWithFormat:@"客户性别：%@",@"男"]];
                }else{
                    
                    [cell SetCellContentbystring:[NSString stringWithFormat:@"客户性别：%@",@"女"]];
                }
                
            }else{
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"联系方式：%@",[_dataDic[@"tel"] componentsSeparatedByString:@","][0]]];
            }
        }else if (indexPath.section == 2){
            
            if (indexPath.row == 0) {
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]]];
            }else if (indexPath.row == 1){
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"项目地址：%@-%@-%@-%@",_dataDic[@"province_name"],_dataDic[@"city_name"],_dataDic[@"district_name"],_dataDic[@"absolute_address"]]];
            }else{
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"物业类型：%@", _dataDic[@"property_type"]]];
            }
        }else{
            
            if (indexPath.row == 0) {
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"butter_name"]]];
            }else{
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"butter_tel"]]];
            }
        }
        return cell;
    }
    
}

-(void)initUI
{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"待确认详情";
    
    _confirmTable.rowHeight = 200 *SIZE;
    _confirmTable.estimatedRowHeight = UITableViewAutomaticDimension;
    
     if ([[UserModelArchiver unarchive].agent_identity integerValue]==2) {
    _confirmTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
     }
     else{
         _confirmTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
     }
    _confirmTable.backgroundColor = YJBackColor;
    _confirmTable.delegate = self;
    _confirmTable.dataSource = self;
    [_confirmTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_confirmTable];
  
}

-(void)refresh{
    
    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
@end
