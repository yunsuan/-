//
//  InvalidVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "InvalidVC.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"
#import "ComplaintVC.h"
#import "RecommendView.h"
#import "TransmitView.h"
#import "FailView.h"
#import <UMShare/UMShare.h>

@interface InvalidVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_clientId;
    NSMutableDictionary *_dataDic;
}

@property (nonatomic , strong) UITableView *invalidTable;

@property (nonatomic , strong) UIButton *recommendBtn;

@property (nonatomic , strong) UIButton *complaintBtn;

@property (nonatomic, strong) RecommendView *recommendView;

@property (nonatomic, strong) FailView *failView;

@property (nonatomic, strong) TransmitView *transmitView;

@property (nonatomic, strong) NSDateFormatter *formatter;
@end

@implementation InvalidVC

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
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    _data = @[@"项目名称：凤凰国际",@"项目地址：dafdsfasdfasdfsadfasfasfasdf高新区-天府三街-000号",@"推荐时间：2017-10-23  19:00:00"];
    _titleArr = @[[NSString stringWithFormat:@"推荐编号：%@",_clientId],@"无效信息",@"客户信息",@"项目信息",@"委托人信息"];
    _dataDic = [@{} mutableCopy];
    [self InValidRequestMethod];
}

- (void)InValidRequestMethod{
    
    [BaseRequest GET:DisabledDetail_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
               
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_dataDic setObject:@"" forKey:key];
                }
            }];
            [_invalidTable reloadData];
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

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    [BaseRequest POST:RecommendClient_URL parameters:@{@"project_id":_dataDic[@"project_id"],@"client_need_id":_dataDic[@"client_need_id"],@"client_id":_clientId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self.recommendView.codeL.text = [NSString stringWithFormat:@"推荐编号:%@",_clientId];
            self.recommendView.nameL.text = [NSString stringWithFormat:@"客户：%@",_dataDic[@"name"]];
            self.recommendView.projectL.text = [NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]];
            self.recommendView.addressL.text = [NSString stringWithFormat:@"项目地址：%@-%@-%@-%@",_dataDic[@"province_name"],_dataDic[@"city_name"],_dataDic[@"district_name"],_dataDic[@"absolute_address"]];
            self.recommendView.contactL.text = [NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"butter_name"]];
            self.recommendView.phoneL.text = [NSString stringWithFormat:@"联系方式：%@",_dataDic[@"butter_tel"]];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"失效时间:%@",@"asd"]];
            [attr addAttribute:NSForegroundColorAttributeName value:YJContentLabColor range:NSMakeRange(0, 5)];
            self.recommendView.timeL.attributedText = attr;
            [[UIApplication sharedApplication].keyWindow addSubview:self.recommendView];
        }else{
            
            self.failView.reasonL.text = resposeObject[@"msg"];
            self.failView.timeL.text = [_formatter stringFromDate:[NSDate date]];
            [[UIApplication sharedApplication].keyWindow addSubview:self.failView];
        }
    } failure:^(NSError *error) {
        
        self.failView.reasonL.text = @"网络错误";
        self.failView.timeL.text = [_formatter stringFromDate:[NSDate date]];
        [[UIApplication sharedApplication].keyWindow addSubview:self.failView];
        NSLog(@"%@",error);
    }];
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    }else if (section == 4){
        
        return 2;
    }else{
        
        return 3;
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
    title.text = _titleArr[section];
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
        
        return 5;
    }else{
        
        return 0;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"InfoDetailCell";
    InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    [cell SetCellContentbystring:_data[indexPath.row]];
    switch (indexPath.section) {
        case 0:
        {
            [cell SetCellContentbystring:[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]]];
            break;
        }
        case 1:{
            
            if (indexPath.row == 0) {
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"失效类型：%@",_dataDic[@"disabled_state"]]];
            }else if (indexPath.row == 1){
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"失效原因：%@",_dataDic[@"disabled_reason"]]];
            }else{
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"失效时间：%@",_dataDic[@"state_change_time"]]];
            }
            break;
        }
        case 2:{
            
            if (indexPath.row == 0) {
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]]];
            }else if (indexPath.row == 1){
                
                if ([_dataDic[@"sex"] integerValue] == 1) {
                    
                    [cell SetCellContentbystring:[NSString stringWithFormat:@"客户性别：男"]];
                }else if ([_dataDic[@"sex"] integerValue] == 2){
                    
                    [cell SetCellContentbystring:[NSString stringWithFormat:@"客户性别：女"]];
                }else{
                    
                    [cell SetCellContentbystring:[NSString stringWithFormat:@"客户性别："]];
                }
            }else{
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"tel"]]];
            }
            break;
        }
        case 3:{
            
            if (indexPath.row == 0) {
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]]];
            }else if (indexPath.row == 1){
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"项目地址：%@-%@-%@-%@",_dataDic[@"province_name"],_dataDic[@"city_name"],_dataDic[@"district_name"],_dataDic[@"absolute_address"]]];
            }else{
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"物业类型：%@",_dataDic[@"state_change_time"]]];
            }
            break;
        }
        case 4:{
            
            if (indexPath.row == 0) {
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"butter_name"]]];
            }else if (indexPath.row == 1){
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"butter_tel"]]];
            }
            break;
        }
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    return cell;

}

-(void)initUI
{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"无效详情";
    
    _invalidTable.rowHeight = 150 *SIZE;
    _invalidTable.estimatedRowHeight = UITableViewAutomaticDimension;
    _invalidTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _invalidTable.backgroundColor = YJBackColor;
    _invalidTable.delegate = self;
    _invalidTable.dataSource = self;
    [_invalidTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_invalidTable];
    
    _complaintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _complaintBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 120 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _complaintBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_complaintBtn addTarget:self action:@selector(ActionComplaintBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_complaintBtn setTitle:@"申诉" forState:UIControlStateNormal];
    [_complaintBtn setBackgroundColor:COLOR(191, 191, 191, 1)];
    [_complaintBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_complaintBtn];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_recommendBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"重新推荐" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    [_recommendBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_recommendBtn];
}

- (FailView *)failView{
    
    if (!_failView) {
        
        _failView = [[FailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    }
    return _failView;
}

- (RecommendView *)recommendView{
    
    if (!_recommendView) {
        
        _recommendView = [[RecommendView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        WS(weakSelf)
        _recommendView.tranmitBtnBlock = ^{
            
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.transmitView];
        };
        
        _recommendView.recommendViewConfirmBlock = ^{
          
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    return _recommendView;
}

- (TransmitView *)transmitView{
    
    if (!_transmitView) {
        
        _transmitView = [[TransmitView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        WS(weakSelf);
        _transmitView.transmitTagBtnBlock = ^(NSInteger index) {
          
            if (index == 0) {
                
                [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            }
        };
    }
    return _transmitView;
}

//
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
            [self showContent:@"分享成功"];
            [self.transmitView removeFromSuperview];
            [self.recommendView removeFromSuperview];
        }
    }];
}
@end
