//
//  SystemMessageVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SystemMessageVC.h"
#import "SystemMessageCell.h"
#import "InfoDetailVC.h"

@interface SystemMessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataarr;
}

@property (nonatomic , strong) UITableView *systemmsgtable;


-(void)initUI;
-(void)initDateSouce;

@end

@implementation SystemMessageVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self post];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"系统消息";
    [self initDateSouce];
    [self initUI];

    
}

-(void)post{
    
    [BaseRequest GET:SystemInfoList_URL parameters:nil success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue]==200) {
            dataarr = resposeObject[@"data"];
            [_systemmsgtable reloadData];
        }
        
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
    }];
}

-(void)initDateSouce
{
    dataarr = [[NSMutableArray alloc]init];
}

-(void)initUI
{
    [self.view addSubview:self.systemmsgtable];
    
}




#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataarr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"SystemMessageCell";
        
        SystemMessageCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[SystemMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    [cell SetCellbytitle:dataarr[indexPath.row][@"title"] content:dataarr[indexPath.row][@"content"] time:dataarr[indexPath.row][@"create_time"] messageimg:[dataarr[indexPath.row][@"is_read"][@"is_read"] boolValue]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoDetailVC * next_vc =[[InfoDetailVC alloc]init];
    next_vc.url = dataarr[indexPath.row][@"api_url"];
    next_vc.extra_param = dataarr[indexPath.row][@"extra_param"];
    next_vc.type = dataarr[indexPath.row][@"is_read"][@"type"];
    [BaseRequest GET:SystemRead_URL parameters:@{
                                                 @"type":dataarr[indexPath.row][@"is_read"][@"type"],
                                                 @"message_id":dataarr[indexPath.row][@"is_read"][@"message_id"]
                                                 }
             success:^(id resposeObject) {
                 if ([resposeObject[@"code"] integerValue] == 200) {
                     [self.navigationController pushViewController:next_vc animated:YES];
                 }
                                                 }
             failure:^(NSError *error) {
                                                     
                                                 }];
    
    
}



#pragma mark  ---  懒加载   ---
-(UITableView *)systemmsgtable
{
    if(!_systemmsgtable)
    {
        _systemmsgtable =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _systemmsgtable.backgroundColor = YJBackColor;
        _systemmsgtable.delegate = self;
        _systemmsgtable.dataSource = self;
        [_systemmsgtable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _systemmsgtable;
}



@end
