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
#import "DynamicDetailVC.h"

@interface SystemMessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataarr;
    int page;
}

@property (nonatomic , strong) UITableView *systemmsgtable;


-(void)initUI;
-(void)initDateSouce;

@end

@implementation SystemMessageVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self postWithpage:@"1"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"系统消息";
    [self initDateSouce];
    [self initUI];
}

- (void)ActionDismiss{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)postWithpage:(NSString *)page{
    
    [BaseRequest GET:SystemInfoList_URL parameters:@{
                                                     @"page":page}
             success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue]==200) {
            
            if ([page isEqualToString:@"1"]) {
                
                [_systemmsgtable.mj_footer endRefreshing];
                dataarr = [resposeObject[@"data"] mutableCopy];
                
                if (dataarr.count < 15) {
                    
                    _systemmsgtable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                [_systemmsgtable reloadData];
            }
            else{
                
                NSArray *arr =resposeObject[@"data"];
                if (arr.count ==0) {
                    [_systemmsgtable.mj_footer setState:MJRefreshStateNoMoreData];
                }
                else{
                    [dataarr addObjectsFromArray:[arr mutableCopy]];
                    [_systemmsgtable reloadData];
                    [_systemmsgtable.mj_footer endRefreshing];
                    
                }
            }
            
            [_systemmsgtable.mj_header endRefreshing];
        }
        
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
        [_systemmsgtable.mj_footer endRefreshing];
        [_systemmsgtable.mj_header endRefreshing];
    }];
}

-(void)initDateSouce
{
    dataarr = [[NSMutableArray alloc]init];
    page = 1;
}

-(void)initUI
{
    [self.view addSubview:self.systemmsgtable];
    [self.maskButton addTarget:self action:@selector(ActionDismiss) forControlEvents:UIControlEventTouchUpInside];
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

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 110*SIZE;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"SystemMessageCell";
    SystemMessageCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SystemMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if ([dataarr[indexPath.row][@"type"] integerValue] == 2) {
//
//        [cell SetCellbytitle:dataarr[indexPath.row][@"title"] content:@"" time:dataarr[indexPath.row][@"create_time"] messageimg:[dataarr[indexPath.row][@"is_read"] boolValue]];
//    }else{
    
        [cell SetCellbytitle:dataarr[indexPath.row][@"title"] content:dataarr[indexPath.row][@"content"] time:dataarr[indexPath.row][@"create_time"] messageimg:[dataarr[indexPath.row][@"is_read"][@"is_read"] boolValue]];
//    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [BaseRequest GET:SystemInfoisread_URL parameters:@{
                                                       @"message_id":dataarr[indexPath.row][@"is_read"][@"message_id"]
                                                       }
             success:^(id resposeObject) {
                 NSLog(@"%@",resposeObject);
                 
                                                       }
             failure:^(NSError *error) {
                     NSLog(@"%@",error);
                                                       }];
    
    if ([dataarr[indexPath.row][@"is_read"][@"url"] isEqual:@""]  ) {
        
    }
    else{
        DynamicDetailVC *nextVC = [[DynamicDetailVC alloc] initWithStr:dataarr[indexPath.row][@"is_read"][@"url"] titleStr:@"消息详情"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}



#pragma mark  ---  懒加载   ---
-(UITableView *)systemmsgtable
{
    if(!_systemmsgtable)
    {
        _systemmsgtable =   [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _systemmsgtable.rowHeight = UITableViewAutomaticDimension;
        _systemmsgtable.estimatedRowHeight = 110 *SIZE;
        _systemmsgtable.backgroundColor = YJBackColor;
        _systemmsgtable.delegate = self;
        _systemmsgtable.dataSource = self;
        _systemmsgtable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            [self postWithpage:@"1"];
        }];
        _systemmsgtable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            page++;
            [self postWithpage:[NSString stringWithFormat:@"%d",page]];
        }];
        [_systemmsgtable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _systemmsgtable;
}



@end
