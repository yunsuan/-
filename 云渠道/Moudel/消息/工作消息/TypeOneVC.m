//
//  TypeOneVC.m
//  云渠道
//
//  Created by xiaoq on 2018/5/7.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TypeOneVC.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"
#import "CompleteCustomVC1.h"
#import "InvalidView.h"

@interface TypeOneVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_endtime;
    NSString *_name;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic , strong) UITableView *Maintableview;
@property (nonatomic , strong) UIButton *confirmBtn;
@property (nonatomic, strong) InvalidView *invalidView;

@end

@implementation TypeOneVC



-(void)post{
    [BaseRequest GET:WaitConfirminfo_URL parameters:@{
                                                        @"client_id":_client_id,
                                                        @"message_id":_message_id
                                                        }
             success:^(id resposeObject) {
                 NSLog(@"%@",resposeObject);
                 if ([resposeObject[@"code"] integerValue]==200) {
                     _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
                     if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
                         
                         _titleArr = @[[NSString stringWithFormat:@"推荐编号：%@",_client_id],@"客户信息",@"项目信息",@"到访确认人信息"];
                     }else{
                         
                         _titleArr = @[[NSString stringWithFormat:@"推荐编号：%@",_client_id],@"客户信息",@"项目信息",@"推荐人信息"];
                     }
                     NSString *sex = @"客户性别：无";
                     if ([resposeObject[@"data"][@"sex"] integerValue] == 1) {
                         sex = @"客户性别：男";
                     }
                     if([resposeObject[@"data"][@"sex"] integerValue] == 2)
                     {
                         sex =@"客户性别：女";
                     }
                     _name = resposeObject[@"data"][@"city_name"];
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
                     
                     if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
                         
                         _data = @[@[[NSString stringWithFormat:@"推荐时间：%@",resposeObject[@"data"][@"create_time"]],@""],@[[NSString stringWithFormat:@"客户姓名：%@",resposeObject[@"data"][@"name"]],sex,tel],@[[NSString stringWithFormat:@"项目名称：%@",resposeObject[@"data"][@"project_name"]],adress,[NSString stringWithFormat:@"物业类型：%@",resposeObject[@"data"][@"property_type"]]],@[[NSString stringWithFormat:@"到访确认人：%@",resposeObject[@"data"][@"butter_name"]],[NSString stringWithFormat:@"联系方式：%@",resposeObject[@"data"][@"butter_tel"]]]];
                     }else{
                         
                         _data = @[@[[NSString stringWithFormat:@"推荐时间：%@",resposeObject[@"data"][@"create_time"]],@""],@[[NSString stringWithFormat:@"客户姓名：%@",resposeObject[@"data"][@"name"]],sex,tel],@[[NSString stringWithFormat:@"项目名称：%@",resposeObject[@"data"][@"project_name"]],adress,[NSString stringWithFormat:@"物业类型：%@",resposeObject[@"data"][@"property_type"]]],@[[NSString stringWithFormat:@"推荐人：%@",resposeObject[@"data"][@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",resposeObject[@"data"][@"broker_tel"]]]];
                     }
                     if ([resposeObject[@"data"][@"is_deal"] integerValue] == 1) {
                         
                         _confirmBtn.hidden = YES;
                         _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
                     }else{
                         
                         _confirmBtn.hidden = NO;
                         _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT- 40 *SIZE - TAB_BAR_MORE);
                     }
                     _endtime = resposeObject[@"data"][@"timeLimit"];
                     [_Maintableview reloadData];
                     
                 }else{
                     
                     _confirmBtn.hidden = YES;
                     _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
                 }
             }
             failure:^(NSError *error) {
                 
                 NSLog(@"%@",error);
                 [self showContent:@"网络错误"];
                 _confirmBtn.hidden = YES;
                 _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
             }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
    [self post];
    
}


-(void)initDataSouce
{
    _titleArr = @[];
    _data =@[];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *valid = [UIAlertAction actionWithTitle:@"有效到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CompleteCustomVC1 *nextVC = [[CompleteCustomVC1 alloc] initWithClientID:_client_id name:_name dataDic:_dataDic];
        
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"无效到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.invalidView.client_id = _client_id;
        [[UIApplication sharedApplication].keyWindow addSubview:self.invalidView];
    }];
    
    [alert addAction:valid];
    [alert addAction:invalid];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = _data[section];
    return arr.count;
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
    title.text = _titleArr[section];
    [backview addSubview:title];
    return backview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 53*SIZE;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _data.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0 && indexPath.row ==1) {
        static NSString *CellIdentifier = @"CountDownCell";
        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //        [cell setcountdownbyday:0 hours:0 min:0 sec:30];
        [cell setcountdownbyendtime:_endtime];
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
        [cell SetCellContentbystring:_data[indexPath.section][indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text =_titleinfo;
    
    
    
    _Maintableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT- 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _Maintableview.rowHeight = UITableViewAutomaticDimension;
    _Maintableview.estimatedRowHeight = 150 *SIZE;
    _Maintableview.backgroundColor = YJBackColor;
    _Maintableview.delegate = self;
    _Maintableview.dataSource = self;
    [_Maintableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
    }
    [self.view addSubview:_Maintableview];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    if ([[UserModel defaultModel].agent_identity integerValue] == 2) {
        
        [self.view addSubview:_confirmBtn];
    }
    
    
}

- (InvalidView *)invalidView{
    
    if (!_invalidView) {
        
        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        
    }
    return _invalidView;
}

-(void)refresh{
    
    _confirmBtn.hidden = YES;
    _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
//    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
//        [self.navigationController popViewControllerAnimated:YES];
//    } failure:^(NSError *error) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
}
@end
