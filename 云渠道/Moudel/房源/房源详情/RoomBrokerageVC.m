//
//  RoomBrokerageVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomBrokerageVC.h"
#import "RoomBrokerageTableCell.h"
#import "RoomBrokerageTableCell2.h"
#import "RoomBrokerageTableHeader.h"
#import "BrokerModel.h"

@interface RoomBrokerageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSMutableArray *_selectArr;
    RoomListModel *_roomModel;
    BrokerModel *_model;
    

}
@property (nonatomic, strong) UITableView *brokerageTable;

@end

@implementation RoomBrokerageVC

- (instancetype)initWithModel:(RoomListModel *)model
{
    self = [super init];
    if (self) {
        
        _roomModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _selectArr = [@[] mutableCopy];
    _dataArr = [@[] mutableCopy];
    _selectArr = [NSMutableArray arrayWithArray:@[@1,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]];

    
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetRule_URL parameters:@{@"project_id":_roomModel.project_id} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            _model = [[BrokerModel alloc]initWithdata:resposeObject[@"data"][@"basic"]];
            [_brokerageTable reloadData];
            
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
    return _model.dataarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }
    return 51 *SIZE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_selectArr[section] integerValue]) {
        
        return 1;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return nil;
    }
    RoomBrokerageTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomBrokerageTableHeader"];
    if (!header) {
        
        header = [[RoomBrokerageTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 51 *SIZE)];
    }
    
    header.titleL.text = [NSString stringWithFormat:@"%@至%@",_model.dataarr[section][@"act_start"],_model.dataarr[section][@"act_end"]];//@"2017-07-11至2017-08-10";
    header.dropBtn.tag = section;
    if ([_selectArr[section] integerValue]) {
        
        [header.dropBtn setImage:[UIImage imageNamed:@"uparrow"] forState:UIControlStateNormal];
    }else{
        
        [header.dropBtn setImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
    }
    header.dropBtnBlock = ^(NSInteger index) {
        
        if ([_selectArr[index] integerValue]) {
            
            [_selectArr replaceObjectAtIndex:index withObject:@0];
        }else{
            
            [_selectArr replaceObjectAtIndex:index withObject:@1];
        }
        [tableView reloadData];
    };
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        RoomBrokerageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomBrokerageTableCell"];
        if (!cell) {
            
            cell = [[RoomBrokerageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomBrokerageTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.rankL.text = [NSString stringWithFormat:@"第%@名",_roomModel.sort];
        [cell.rankL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView).offset(114 *SIZE);
            make.height.equalTo(@(13 *SIZE));
            make.top.equalTo(cell.contentView).offset(50 *SIZE);
            make.width.equalTo(@(cell.rankL.mj_textWith + 5 *SIZE));
        }];
        [cell SetLevel:[_roomModel.cycle integerValue]];
        cell.ruleView.titleImg.image = [UIImage imageNamed:@"rules"];
        cell.ruleView.titleL.text = @"佣金规则";
        cell.ruleView.contentL.text = _model.bsicarr[indexPath.section][@"basic"];
        cell.standView.titleImg.image = [UIImage imageNamed:@"commission4"];
        cell.standView.titleL.text = @"结佣标准";
        NSMutableArray *arr = [_model getbreakinfo];
        cell.standView.contentL.text = arr[indexPath.section];
        return cell;
    }else{
        
        RoomBrokerageTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomBrokerageTableCell2"];
        if (!cell) {
            
            cell = [[RoomBrokerageTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomBrokerageTableCell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ruleView.titleImg.image = [UIImage imageNamed:@"rules"];
        cell.ruleView.titleL.text = @"佣金规则";
        cell.ruleView.contentL.text = _model.bsicarr[indexPath.section][@"basic"];
        cell.standView.titleImg.image = [UIImage imageNamed:@"commission4"];
        cell.standView.titleL.text = @"结佣标准";
        NSMutableArray *arr = [_model getbreakinfo];
        cell.standView.contentL.text = arr[indexPath.section];
        
        return cell;
    }
}

- (void)initUI{
    
    _brokerageTable.rowHeight = UITableViewAutomaticDimension;
    _brokerageTable.estimatedRowHeight = 214 *SIZE;
    _brokerageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _brokerageTable.backgroundColor = CH_COLOR_white;;
    _brokerageTable.delegate = self;
    _brokerageTable.dataSource = self;
    _brokerageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_brokerageTable];
}



@end
