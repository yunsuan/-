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
#import "CustomSearchVC.h"
#import "AddressChooseView2.h"

@interface CustomerVC ()<UITableViewDelegate,UITableViewDataSource,PYSearchViewControllerDelegate>
{
    
    NSMutableArray *_dataArr;
    NSMutableDictionary *_parameter;
    NSInteger _page;
    NSString *_type;
    NSString *_district;
    NSString *_sortType;
    NSString *_asc;
    BOOL _is1;
    BOOL _is2;
}

@property (nonatomic, strong) UITableView *customerTable;

@property (nonatomic, strong) BoxView *boxView;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UIButton *areaBtn;

@property (nonatomic, strong) UIButton *intentBtn;

@property (nonatomic, strong) UIButton *urgencyBtn;

@property (nonatomic, strong) AddressChooseView2 *adressView;


@end

@implementation CustomerVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //设置隐藏
}

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
    NSMutableDictionary *dic = [@{} mutableCopy];
    if (_sortType.length) {
        
        [dic setObject:_sortType forKey:@"sort_type"];
        [dic setObject:_asc forKey:@"sort"];
    }
    if ([_type integerValue]) {
        
        [dic setObject:_type forKey:@"property_type"];
    }
    if (_district.length) {
        
        [dic setObject:_district forKey:@"district"];
    }

    [BaseRequest GET:ListClient_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        [_customerTable.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"current_page"] integerValue] == [resposeObject[@"data"][@"total"] integerValue]) {
                    
                    [_dataArr removeAllObjects];
                    _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                }
                
                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                    
                    if ([resposeObject[@"data"][@"data"] count]) {
                        
                        [self SetData:resposeObject[@"data"][@"data"]];
                        
                    }else{
                        
                        [_dataArr removeAllObjects];
                        _customerTable.mj_footer.state = MJRefreshStateNoMoreData;
                        [self showContent:@"暂无数据"];
                    }
                }else{
                    
                    [_dataArr removeAllObjects];
                    [self showContent:@"暂无数据"];
                }
            }else{
                
                [_dataArr removeAllObjects];
                [self showContent:@"暂无数据"];
            }
            [_customerTable reloadData];
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
    NSDictionary *tempDic = @{@"page":@(_page)};
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
    if (_sortType.length) {
        
        [dic setObject:_sortType forKey:@"sort_type"];
        [dic setObject:_asc forKey:@"sort"];
    }
    if (_type) {
        
        [dic setObject:_type forKey:@"property_type"];
    }
    if (_district.length) {
        
        [dic setObject:_district forKey:@"district"];
    }
    [BaseRequest GET:ListClient_URL parameters:dic success:^(id resposeObject) {
        
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

#pragma mark -- Method

- (void)ActionTagBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (btn.tag < 3) {
        
        if (btn.tag == 1) {
            
            _is2 = NO;
            _areaBtn.selected = NO;
            [self.adressView removeFromSuperview];
            if (_is1) {
                
                _is1 = !_is1;
                [self.boxView removeFromSuperview];
            }else{
                
                _is1 = YES;
                _type = @"0";
                NSArray *array = [self getDetailConfigArrByConfigState:PROPERTY_TYPE];
                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:array];
                [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
                self.boxView.dataArr = [NSMutableArray arrayWithArray:tempArr];
                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx == 0) {
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
                    }else{
                        
                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
                    }
                }];
                self.boxView.selectArr = [NSMutableArray arrayWithArray:tempArr];
                [self.boxView.mainTable reloadData];
                [self.view addSubview:self.boxView];
            }
        }else{
            
            _is1 = NO;
            _typeBtn.selected = NO;
            [self.boxView removeFromSuperview];
            if (_is2) {
                
                _is2 = !_is2;
                [self.adressView removeFromSuperview];
            }else{
                
                _is2 = YES;
                [self.view addSubview:self.adressView];
            }
        }
    }else{
        
        _is1 = NO;
        _typeBtn.selected = NO;
        _areaBtn.selected = NO;
        if (btn.tag == 3) {
            
            _urgencyBtn.selected = NO;
            if ([_sortType isEqualToString:@"intent"]) {
                
                if ([_asc isEqualToString:@"desc"]) {
                    
                    _asc = @"asc";
                }else{
                    
                    _asc = @"desc";
                }
            }else{
                
                _asc = @"asc";
            }
            _sortType = @"intent";
        }else{
            
            _intentBtn.selected = NO;
            if ([_sortType isEqualToString:@"urgency"]) {
                
                
                if ([_asc isEqualToString:@"desc"]) {
                    
                    _asc = @"asc";
                }else{
                    
                    _asc = @"desc";
                }
            }else{
                
                _asc = @"asc";
            }
            _sortType = @"urgency";
        }
        [self.boxView removeFromSuperview];
        [self RequestMethod];
    }
}

#pragma mark -- SearchMethod

- (void)ActionSearchBtn:(UIButton *)btn{
    
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入楼盘名或地址" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        [searchViewController.navigationController pushViewController:[[CustomSearchVC alloc] initWithTitle:searchText] animated:YES];
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

#pragma mark -- TableViewDelegate
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
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_Width / 4 * i, NAVIGATION_BAR_HEIGHT + 56 *SIZE, SCREEN_Width / 4, 40 *SIZE);
        btn.tag = i + 1;
        [btn setBackgroundColor:CH_COLOR_white];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];

        switch (i) {
            case 0:
            {
                [btn setTitle:@"需求类型" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _typeBtn = btn;
                [self.view addSubview:_typeBtn];
                break;
            }
            case 1:
            {
                [btn setTitle:@"意向区域" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _areaBtn = btn;
                [self.view addSubview:_areaBtn];
                break;
            }
            case 2:
            {
                [btn setTitle:@"意向度" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _intentBtn = btn;
                [self.view addSubview:_intentBtn];
                break;
            }
            case 3:
            {
                [btn setTitle:@"紧迫度" forState:UIControlStateNormal];
                [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
                [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
                _urgencyBtn = btn;
                [self.view addSubview:_urgencyBtn];
                break;
            }
            default:
                break;
        }
    }

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

- (AddressChooseView2 *)adressView{
    
    if (!_adressView) {
        
        _adressView = [[AddressChooseView2 alloc]initWithFrame:CGRectMake(0, 41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE, SCREEN_Width, SCREEN_Height - (41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE))];
        WS(weakSelf);
        _adressView.confirmAreaBlock = ^(NSString *pro, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
          
            if (area.length) {
                
                _district = [NSString stringWithFormat:@"%@-%@-%@",proviceid,cityid,areaid];
                [weakSelf.areaBtn setTitle:area forState:UIControlStateNormal];
            }else if(city.length){
                
                _district = [NSString stringWithFormat:@"%@-%@",proviceid,cityid];
                [weakSelf.areaBtn setTitle:city forState:UIControlStateNormal];
            }else if (pro.length){
                
                _district = [NSString stringWithFormat:@"%@",proviceid];
                [weakSelf.areaBtn setTitle:pro forState:UIControlStateNormal];
            }else{
                
//                _district = @"";
                [weakSelf.areaBtn setTitle:@"意向区域" forState:UIControlStateNormal];
            }
            
            _is2 = NO;
            weakSelf.areaBtn.selected = NO;
            [weakSelf.adressView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        _adressView.cancelBtnBlock = ^{
            
            _is2 = NO;
            weakSelf.areaBtn.selected = NO;
        };
    }
    return _adressView;
}

- (BoxView *)boxView{
    if (!_boxView) {
        _boxView = [[BoxView alloc] initWithFrame:CGRectMake(0, 41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE, SCREEN_Width, SCREEN_Height - (41 *SIZE + NAVIGATION_BAR_HEIGHT + 56 *SIZE))];
        WS(weakSelf);
        _boxView.confirmBtnBlock = ^(NSString *ID,NSString *str) {
          
            if ([str isEqualToString:@"不限"]) {
                
                [weakSelf.typeBtn setTitle:@"需求类型" forState:UIControlStateNormal];
            }else{
                
                [weakSelf.typeBtn setTitle:str forState:UIControlStateNormal];
            }
            _is1 = NO;
            _type = ID;
            weakSelf.typeBtn.selected = NO;
            [weakSelf.boxView removeFromSuperview];
            [weakSelf RequestMethod];
        };
        
        _boxView.cancelBtnBlock = ^{
          
            _is1 = NO;
            weakSelf.typeBtn.selected = NO;
        };
    }
    return _boxView;
}

@end
