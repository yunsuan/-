//
//  WorkMessageVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "WorkMessageVC.h"
#import "WorkMessageCell.h"
#import "InfoDetailVC.h"
#import "TypeZeroVC.h"
#import "TypeOneVC.h"
#import "TypeTwoVC.h"

@interface WorkMessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_data;
    int page;
}

@property (nonatomic , strong) UITableView *systemmsgtable;


-(void)initUI;
-(void)initDateSouce;

@end

@implementation WorkMessageVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self postWithpage:@"1"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"推荐成功";
    
    [self initDateSouce];
    [self initUI];

}

- (void)ActionDismiss{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)postWithpage:(NSString *)page{
    
    [BaseRequest GET:WorkingInfoList_URL parameters:@{
                                                      @"page":page
                                                      }
             success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue]==200) {
            if ([page isEqualToString:@"1"]) {
          
                [_systemmsgtable.mj_footer endRefreshing];
                _data = [resposeObject[@"data"][@"data"] mutableCopy];
                if (_data.count < 15) {
                    
                    _systemmsgtable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                [_systemmsgtable reloadData];
            }
            else{
                NSArray *arr =resposeObject[@"data"][@"data"];
                if (arr.count ==0) {
                    [_systemmsgtable.mj_footer setState:MJRefreshStateNoMoreData];
                }
                else{
                    [_data addObjectsFromArray:[arr mutableCopy]];
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
    _data = [NSMutableArray arrayWithArray:@[]];
}

-(void)initUI
{
    [self.view addSubview:self.systemmsgtable];
    
    [self.maskButton addTarget:self action:@selector(ActionDismiss) forControlEvents:UIControlEventTouchUpInside];
}




#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 127*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WorkMessageCell";
    
    WorkMessageCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[WorkMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell SetCellbytitle:_data[indexPath.row][@"title"] num:[NSString stringWithFormat:@"推荐编号：%@",_data[indexPath.row][@"client_id"]]  name:[NSString stringWithFormat:@"姓名：%@",_data[indexPath.row][@"name"]] project:[NSString stringWithFormat:@"项目：%@",_data[indexPath.row][@"project_name"]] time: _data[indexPath.row][@"create_time"] messageimg:[_data[indexPath.row][@"attribute"][@"is_read"] boolValue]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger i = [_data[indexPath.row][@"message_type"] integerValue];
    switch (i) {
        case 0:
        {
            TypeZeroVC *next_vc = [[TypeZeroVC alloc]init];
            next_vc.client_id = _data[indexPath.row][@"client_id"];
            next_vc.message_id = _data[indexPath.row][@"message_id"];
            next_vc.titleinfo = _data[indexPath.row][@"title"];
            [self.navigationController pushViewController:next_vc animated:YES];
        }
            break;
        case 1:
        {
            TypeOneVC *next_vc = [[TypeOneVC alloc]init];
            next_vc.client_id = _data[indexPath.row][@"client_id"];
            next_vc.message_id = _data[indexPath.row][@"message_id"];
            next_vc.titleinfo = _data[indexPath.row][@"title"];
            [self.navigationController pushViewController:next_vc animated:YES];
        }
            break;
        case 2:
        {
            TypeTwoVC *next_vc = [[TypeTwoVC alloc]init];
            next_vc.client_id = _data[indexPath.row][@"client_id"];
            next_vc.message_id = _data[indexPath.row][@"message_id"];
            next_vc.titleinfo = _data[indexPath.row][@"title"];
            [self.navigationController pushViewController:next_vc animated:YES];
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }


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
