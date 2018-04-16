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

@interface CustomerVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_dataArr;
    NSMutableDictionary *_parameter;
    NSInteger _page;
}

@property (nonatomic, strong) UITableView *customerTable;

@property (nonatomic, strong) UICollectionView *customerColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) BoxView *boxView;


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
    
    if (_page == 1) {
        
        _customerTable.mj_footer.state = MJRefreshStateIdle;
    }
    [BaseRequest GET:ListClient_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        [_customerTable.mj_footer endRefreshing];
        [_customerTable.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
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
        [_customerTable.mj_header endRefreshing];
        NSLog(@"%@",error.localizedDescription);
        [self showContent:@""];
    }];
}

- (void)SetData:(NSArray *)data{
    
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
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 4, 40 *SIZE);
    
    _customerColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + SIZE, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _customerColl.backgroundColor = CH_COLOR_white;
    _customerColl.delegate = self;
    _customerColl.dataSource = self;
    _customerColl.bounces = NO;
    [_customerColl registerClass:[CustomerCollCell class] forCellWithReuseIdentifier:@"CustomerCollCell"];
    [self.view addSubview:_customerColl];
    
    
    _customerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 42 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 42 *SIZE) style:UITableViewStylePlain];
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
        
        [self RequestMethod];
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
