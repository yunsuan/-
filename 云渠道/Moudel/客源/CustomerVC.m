//
//  CustomerVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomerVC.h"
#import "CustomerTableCell.h"
#import "CustomerCollCell.h"
#import "CustomerTableModel.h"
#import "CustomDetailVC.h"
#import "BoxView.h"
#import "AddCustomerVC.h"
#import "PYSearchViewController.h"

@interface CustomerVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PYSearchViewControllerDelegate>
{
    
    NSMutableArray *_dataArr;
    NSMutableDictionary *_parameter;
    NSInteger _page;
}

@property (nonatomic, strong) UITableView *customerTable;

@property (nonatomic, strong) UICollectionView *customerColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) BoxView *boxView;

@property (nonatomic, strong) UIView *searchBar;


@end

@implementation CustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _customerTable.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ListClient_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        [_customerTable.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"current_page"] integerValue] == [resposeObject[@"data"][@"total"] integerValue]) {
                    
                    _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        
                    }else{
                        
                        _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                        [self showContent:@"暂无数据"];
                    }
                }else{
                    [self showContent:@"暂无数据"];
                }
            }else{
                [self showContent:@"暂无数据"];
            }
        }else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_customerTable.mj_header endRefreshing];
        NSLog(@"%@",error.localizedDescription);
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    [BaseRequest GET:ListClient_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        [_customerTable.mj_footer endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"current_page"] integerValue] == [resposeObject[@"data"][@"total"] integerValue]) {
                    
                    _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        
                    }else{
                        
                        _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                        [self showContent:@"暂无数据"];
                    }
                }else{
                    [self showContent:@"暂无数据"];
                }
            }else{
                [self showContent:@"暂无数据"];
            }
        }else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [_customerTable.mj_footer endRefreshing];
        NSLog(@"%@",error.localizedDescription);
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
                
                if ([key isEqualToString:@"region"]) {
                    
                    [tempDic setObject:@[] forKey:@"region"];
                }else{
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }
        }];
        
        CustomerTableModel *model = [[CustomerTableModel alloc] initWithDictionary:tempDic];
        
        [_dataArr addObject:model];
    }
    [_customerTable reloadData];
}

#pragma mark -- SearchMethod

- (void)ActionSearchBtn:(UIButton *)btn{
    
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入楼盘名或地址" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
//        [searchViewController.navigationController pushViewController:[[HouseSearchVC alloc] initWithTitle:searchText] animated:YES];
    }];
    // 3. 设置风格
    searchViewController.searchBar.returnKeyType = UIReturnKeySearch;
    searchViewController.hotSearchStyle = 3; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];

}

#pragma mark -- CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomerCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomerCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CustomerCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width /4, 40 *SIZE)];
    }
    cell.typeL.text = @"需求类型";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item < 2) {
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.boxView];
    }else{
        
        [self.boxView removeFromSuperview];
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"CustomerTableCell";
    CustomerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[CustomerTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    CustomerTableModel *model = _dataArr[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomerTableModel *model = _dataArr[indexPath.row];
    CustomDetailVC *nextVC = [[CustomDetailVC alloc] initWithClientId:model.client_id];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)initUI{
    
    self.titleLabel.text = @"客源";
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.view.backgroundColor = YJBackColor;
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    
    self.line.hidden = YES;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,  NAVIGATION_BAR_HEIGHT, SCREEN_Width, 56 *SIZE)];
    view.backgroundColor = CH_COLOR_white;
    [self.view addSubview:view];
    
    _searchBar = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 20 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = YJBackColor;
    [view addSubview:_searchBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 11 *SIZE, 100 *SIZE, 12 *SIZE)];
    label.textColor = COLOR(147, 147, 147, 1);
    label.text = @"请输入姓名/手机号";
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    [_searchBar addSubview:label];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(308 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.image = [UIImage imageNamed:@"search_2"];
    [_searchBar addSubview:rightImg];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = _searchBar.bounds;
    [searchBtn addTarget:self action:@selector(ActionSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:searchBtn];
    
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 4, 40 *SIZE);
    
    _customerColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 56 *SIZE, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _customerColl.backgroundColor = CH_COLOR_white;
    _customerColl.delegate = self;
    _customerColl.dataSource = self;
    _customerColl.bounces = NO;
    [_customerColl registerClass:[CustomerCollCell class] forCellWithReuseIdentifier:@"CustomerCollCell"];
    [self.view addSubview:_customerColl];
    
    
    _customerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 41 *SIZE - 56 *SIZE) style:UITableViewStylePlain];
    _customerTable.backgroundColor = YJBackColor;
    _customerTable.delegate = self;
    _customerTable.dataSource = self;
    _customerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_customerTable];
    _customerTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        _page = 1;
        [self RequestMethod];
    }];
    
    _customerTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self RequestAddMethod];
    }];
}


-(void)action_add
{
    AddCustomerVC *next_vc = [[AddCustomerVC alloc]init];
    [self.navigationController pushViewController:next_vc animated:YES];

}

- (BoxView *)boxView{
    if (!_boxView) {
        _boxView = [[BoxView alloc] initWithFrame:CGRectMake(0, 43 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE)];
    }
    return _boxView;
}

@end
