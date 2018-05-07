//
//  DynamicListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DynamicListVC.h"
#import "DynamicListTableCell.h"

@interface DynamicListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;
    NSString *_projectId;
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *listTable;

@end

@implementation DynamicListVC

- (instancetype)initWithProjectId:(NSString *)projectId
{
    self = [super init];
    if (self) {
        
        _dataArr = [@[] mutableCopy];
        _projectId = projectId;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    _listTable.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:DynamicList_URL parameters:@{@"project_id":_projectId} success:^(id resposeObject) {
        
        [_listTable.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                _listTable.mj_footer.state = MJRefreshStateNoMoreData;
//                [self showContent:@"暂无数据"];
            }
        }else if([resposeObject[@"code"] integerValue] == 400){
            
//            [self showContent:resposeObject[@"msg"]];
            _listTable.mj_footer.state = MJRefreshStateNoMoreData;
        }
    } failure:^(NSError *error) {
        
        [_listTable.mj_header endRefreshing];
        _listTable.mj_footer.state = MJRefreshStateNoMoreData;
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSDictionary *tempDic = @{@"page":@(_page),
                              @"project_id":_projectId
                              };
    [BaseRequest GET:DynamicList_URL parameters:tempDic success:^(id resposeObject) {
        
        [_listTable.mj_footer endRefreshing];
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                _listTable.mj_footer.state = MJRefreshStateNoMoreData;
//                [self showContent:@"暂无数据"];
            }
            
            if (_page == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                _listTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else if([resposeObject[@"code"] integerValue] == 400){
            
//            [self showContent:resposeObject[@"msg"]];
            _listTable.mj_footer.state = MJRefreshStateNoMoreData;
        }
    } failure:^(NSError *error) {
        
        [_listTable.mj_footer endRefreshing];
        _listTable.mj_footer.state = MJRefreshStateNoMoreData;
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    if (_page == 1) {
        
        [_dataArr removeAllObjects];
    }
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    [_listTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DynamicListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DynamicListTableCell"];
    if (!cell) {
        
        cell = [[DynamicListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DynamicListTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentL.text = _dataArr[indexPath.row][@"content"];
    cell.titleL.text = _dataArr[indexPath.row][@"title"];
    cell.timeL.text = _dataArr[indexPath.row][@"update_time"];
    
    cell.cellBtnBlock = ^(NSInteger index) {
        
        
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"项目动态";
    self.navBackgroundView.hidden = NO;
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _listTable.backgroundColor = self.view.backgroundColor;
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_listTable];
    _listTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        _page = 1;
        [self RequestMethod];
    }];
    
    _listTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        [self RequestAddMethod];
    }];
}

@end
