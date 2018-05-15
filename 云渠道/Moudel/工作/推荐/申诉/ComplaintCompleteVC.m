//
//  ComplaintCompleteVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ComplaintCompleteVC.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"
#import "BrokerageDetailTableCell3.h"

@interface ComplaintCompleteVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
    NSMutableArray *_titleArr;
    NSString *_clientId;
    NSString *_appealId;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic , strong) UITableView *completeTable;

@property (nonatomic , strong) UIButton *continueBtn;

@end

@implementation ComplaintCompleteVC

- (instancetype)initWithAppealId:(NSString *)appealId
{
    self = [super init];
    if (self) {
        
        _appealId = appealId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSouce];
    [self initUI];
}


-(void)initDataSouce
{
    
    _titleArr = [NSMutableArray arrayWithArray:@[@"推荐编号",@"处理信息",@"申诉信息",@"失效信息",@"到访确认人信息"]];
    _data = @[@"项目名称：凤凰国际",@"项目地址：dafdsfasdfasdfsadfasfasfasdf高新区-天府三街-000号",@"推荐时间：2017-10-23  19:00:00"];
    [self AppealRequestMethod];
}

- (void)AppealRequestMethod{
    
    [BaseRequest GET:BrokerAppealDetail_URL parameters:@{@"appeal_id":_appealId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
 
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_dataDic setObject:@"" forKey:key];
                }
            }];
            [_completeTable reloadData];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionContinueBtn:(UIButton *)btn{
    
    
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 4) {
        
        return 6;
    }else if (section == 0){
        
        return 1;
    }else if (section == 1){
        
        return 2;
    }else if (section == 2){
        
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
    if (section == 0) {
        
        title.text = [NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]];
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
    

    if (indexPath.section == 4 && indexPath.row > 2) {
        
        BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
        if (!cell) {
            
            cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *arr = _dataDic[@"process"];
        cell.titleL.text = [NSString stringWithFormat:@"%@：%@",arr[indexPath.row - 3][@"process_name"],arr[indexPath.row - 3][@"time"]];
        if (indexPath.row == 3) {
            
            cell.upLine.hidden = YES;
        }else{
            
            cell.upLine.hidden = NO;
        }
        if (indexPath.row == 5) {
            
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
        if (indexPath.section == 0) {
            
            [cell SetCellContentbystring:[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"recommend_time"]]];
        }else if (indexPath.section == 1){
            
            if (indexPath.row == 0) {
                
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"状态：%@",_dataDic[@"state"]]];
                [attr addAttribute:NSFontAttributeName value:YJBlueBtnColor range:NSMakeRange(3, attr.length - 3)];
                [cell SetCellContentbystring:[NSString stringWithFormat:@"状态：%@",_dataDic[@"state"]]];
            }else{
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"处理描述：%@",_dataDic[@"solve_info"]]];
            }
        }else if (indexPath.section == 2){
            
            if (indexPath.row == 0) {
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"申诉类型：%@",_dataDic[@"type"]]];
            }else{
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"申诉描述：%@",_dataDic[@"comment"]]];
            }
        }else if (indexPath.section == 3){
            
            if (indexPath.row == 0) {
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"失效类型：%@",_dataDic[@"disabled_state"]]];
            }else if (indexPath.row == 1){
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"失效描述：%@",_dataDic[@"disabled_reason"]]];
            }else{
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"失效时间：%@",_dataDic[@"recommend_time"]]];
            }
        }else if (indexPath.section == 4){
            
            if (indexPath.row == 0) {
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"recommend_time"]]];
            }else if (indexPath.row == 1){
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"recommend_time"]]];
            }else if (indexPath.row == 2){
                
                [cell SetCellContentbystring:[NSString stringWithFormat:@"到访时间：%@",_dataDic[@"visit_time"]]];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"申诉详情";
    
    
    _completeTable.rowHeight = 150 *SIZE;
    _completeTable.estimatedRowHeight = UITableViewAutomaticDimension;
    
    _completeTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _completeTable.backgroundColor = YJBackColor;
    _completeTable.delegate = self;
    _completeTable.dataSource = self;
    [_completeTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_completeTable];
    
    
}

@end
