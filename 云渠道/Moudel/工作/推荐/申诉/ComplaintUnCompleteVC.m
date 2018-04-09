//
//  ComplaintUnCompleteVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ComplaintUnCompleteVC.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"
#import "BrokerageDetailTableCell3.h"

@interface ComplaintUnCompleteVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_data;
    NSArray *_titleArr;
}
@property (nonatomic , strong) UITableView *unCompleteTable;

@property (nonatomic , strong) UIButton *cancelBtn;

@end

@implementation ComplaintUnCompleteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSouce];
    [self initUI];
}


-(void)initDataSouce
{
    
    _titleArr = @[@"推荐编号",@"处理信息",@"申诉信息",@"失效信息",@"委托人信息"];
    _data = @[@"项目名称：凤凰国际",@"项目地址：dafdsfasdfasdfsadfasfasfasdf高新区-天府三街-000号",@"推荐时间：2017-10-23  19:00:00"];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 4) {
        
        return 6;
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
    return 5;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0 && indexPath.row ==2) {
        static NSString *CellIdentifier = @"CountDownCell";
        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setcountdownbyday:0 hours:0 min:0 sec:30];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 4 && indexPath.row > 2){
        
        BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
        if (!cell) {
            
            cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleL.text = @"推荐  ——  推荐时间：2017-10-08 18:00";
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
        [cell SetCellContentbystring:_data[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"申诉详情";
    
    
    _unCompleteTable.rowHeight = 150 *SIZE;
    _unCompleteTable.estimatedRowHeight = UITableViewAutomaticDimension;
    
    _unCompleteTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT- 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _unCompleteTable.backgroundColor = YJBackColor;
    _unCompleteTable.delegate = self;
    _unCompleteTable.dataSource = self;
    [_unCompleteTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_unCompleteTable];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"取消申诉" forState:UIControlStateNormal];
    [_cancelBtn setBackgroundColor:YJBlueBtnColor];
    [_cancelBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_cancelBtn];
    
}

@end
