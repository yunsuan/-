//
//  NoInvalidVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "NoInvalidVC.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"
#import "ComplaintVC.h"

@interface NoInvalidVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_clientId;
    NSMutableDictionary *_dataDic;
}

@property (nonatomic , strong) UITableView *invalidTable;

@property (nonatomic , strong) UIButton *complaintBtn;


@end

@implementation NoInvalidVC

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
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _titleArr = @[@"推荐编号",@"失效信息",@"客户信息",@"项目信息",@"到访确认人信息"];
    }else{
        
        _titleArr = @[@"推荐编号",@"失效信息",@"客户信息",@"项目信息",@"推荐人信息"];
    }
    
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectDisabledDetail_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [_invalidTable reloadData];
        }
        else
        {
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionComplaintBtn:(UIButton *)btn{
    
    ComplaintVC *nextVC = [[ComplaintVC alloc] initWithProjectId:_clientId];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
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
        
        title.text = _titleArr[section];
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
        
        return 3;
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"InfoDetailCell";
    InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            [cell SetCellContentbystring:[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]]];
        }else if (indexPath.row == 1){
            
            [cell SetCellContentbystring:[NSString stringWithFormat:@"项目地址：%@-%@-%@-%@",_dataDic[@"province_name"],_dataDic[@"city_name"],_dataDic[@"district_name"],_dataDic[@"absolute_address"]]];
        }else{
            
            [cell SetCellContentbystring:[NSString stringWithFormat:@"物业类型：%@",_dataDic[@"property_type"]]];
        }
    }else{
        
        if (indexPath.row == 0) {
            
            [cell SetCellContentbystring:[NSString stringWithFormat:@"失效类型：%@",_dataDic[@"disabled_state"]]];
        }else if (indexPath.row == 1){
            
            [cell SetCellContentbystring:[NSString stringWithFormat:@"失效描述：%@",_dataDic[@"disabled_reason"]]];
        }else{
            
            [cell SetCellContentbystring:[NSString stringWithFormat:@"失效描述：%@",_dataDic[@"disabled_reason"]]];
        }
    }
    return cell;
    
}

-(void)initUI
{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"失效详情";
    
    
    _invalidTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _invalidTable.rowHeight = UITableViewAutomaticDimension;
    _invalidTable.estimatedRowHeight = 150 *SIZE;
    _invalidTable.backgroundColor = YJBackColor;
    _invalidTable.delegate = self;
    _invalidTable.dataSource = self;
    [_invalidTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_invalidTable];
    
    _complaintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _complaintBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 360 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _complaintBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_complaintBtn addTarget:self action:@selector(ActionComplaintBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_complaintBtn setTitle:@"申诉" forState:UIControlStateNormal];
    [_complaintBtn setBackgroundColor:COLOR(191, 191, 191, 1)];
    [_complaintBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_complaintBtn];
    
}

@end
