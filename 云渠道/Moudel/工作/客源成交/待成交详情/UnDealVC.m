//
//  UnDealVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "UnDealVC.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"
#import "CompleteCustomVC1.h"
#import "InvalidView.h"

@interface UnDealVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_str;
    NSString *_endtime;
    NSString *_name;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic , strong) UITableView *Maintableview;
@property (nonatomic , strong) UIButton *confirmBtn;
@property (nonatomic, strong) InvalidView *invalidView;

@end

@implementation UnDealVC

- (instancetype)initWithString:(NSString *)str
{
    self = [super init];
    if (self) {
        
        _str = str;
        
    }
    return self;
}

-(void)post{
    [BaseRequest GET:WaitConfirmDetail_URL parameters:@{
                                                        @"client_id":_str
                                                        }
             success:^(id resposeObject) {
                 NSLog(@"%@",resposeObject);
                 if ([resposeObject[@"code"] integerValue]==200) {
                     _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
                     _titleArr = @[[NSString stringWithFormat:@"推荐编号：%@",_str],@"客户信息",@"项目信息",@"委托人信息"];
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
                     
                     _data = @[@[[NSString stringWithFormat:@"推荐时间：%@",resposeObject[@"data"][@"create_time"]],@""],@[[NSString stringWithFormat:@"you：%@",resposeObject[@"data"][@"name"]],sex,tel],@[[NSString stringWithFormat:@"客户姓名：%@",resposeObject[@"data"][@"name"]],sex,tel],@[[NSString stringWithFormat:@"项目名称：%@",resposeObject[@"data"][@"project_name"]],adress,[NSString stringWithFormat:@"物业类型：%@",resposeObject[@"data"][@"property_type"]]],@[[NSString stringWithFormat:@"委托人：%@",resposeObject[@"data"][@"butter_name"]],[NSString stringWithFormat:@"联系方式：%@",resposeObject[@"data"][@"butter_tel"]]]];
                     _endtime = resposeObject[@"data"][@"timeLimit"];
                     [_Maintableview reloadData];
                     
                 }
             }
             failure:^(NSError *error) {
                 
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
    self.titleLabel.text = @"待确认详情";
    _Maintableview.rowHeight = 150 *SIZE;
    _Maintableview.estimatedRowHeight = UITableViewAutomaticDimension;
    
    _Maintableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _Maintableview.backgroundColor = YJBackColor;
    _Maintableview.delegate = self;
    _Maintableview.dataSource = self;
    [_Maintableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_Maintableview];
    
}

- (InvalidView *)invalidView{
    
    if (!_invalidView) {
        
        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    }
    return _invalidView;
}

-(void)refresh{
    
    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
