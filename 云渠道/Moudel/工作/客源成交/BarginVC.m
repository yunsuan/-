//
//  BarginVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BarginVC.h"
#import "RecommendCollCell.h"

@interface BarginVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSInteger _index;
    NSArray *_titleArr;
    NSMutableArray *_unComfirmArr;
    NSMutableArray *_validArr;
    NSMutableArray *_inValidArr;
    NSMutableArray *_appealArr;
    NSInteger _page1;
    NSInteger _page2;
    NSInteger _page3;
    NSInteger _page4;
    BOOL _isLast1;
    BOOL _isLast2;
    BOOL _isLast3;
    BOOL _isLast4;
}
@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic, strong) UICollectionView *nomineeColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation BarginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
    [self UnComfirmRequest];
}

-(void)initDateSouce
{
    
    _page1 = 1;
    _page2 = 1;
    _page3 = 1;
    _page4 = 1;
    _titleArr = @[@"待成交",@"成交",@"未成交",@"申诉"];
    _unComfirmArr = [@[] mutableCopy];
    _validArr = [@[] mutableCopy];
    _inValidArr = [@[] mutableCopy];
    _appealArr = [@[] mutableCopy];
}

-(void)UnComfirmRequest{
    
    _isLast1 = NO;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ProjectWaitConfirm_URL parameters:nil success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        
        [_MainTableView.mj_header endRefreshing];
        
        _page1 = 1;
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_unComfirmArr removeAllObjects];
            [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
            if (_page1 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                _isLast1 = YES;
            }
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)UnComfirmRequestAdd{
    
    _page1 += 1;
    [BaseRequest GET:ProjectWaitConfirm_URL parameters:@{@"page":@(_page1)} success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        
        [_MainTableView.mj_footer endRefreshing];
        
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
            if (_page1 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                _isLast1 = YES;
            }
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)SetUnComfirmArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_unComfirmArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}


- (void)ValidRequest{
    
    _isLast2 = NO;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ProjectValue_URL parameters:nil success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        
        [_MainTableView.mj_header endRefreshing];
        
        _page2 = 1;
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_validArr removeAllObjects];
            [self SetValidArr:resposeObject[@"data"][@"data"]];
            if (_page2 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                _isLast2 = YES;
            }
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)ValidRequestAdd{
    
    _page2 += 1;
    [BaseRequest GET:BrokerValue_URL parameters:@{@"page":@(_page2)} success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        
        [_MainTableView.mj_footer endRefreshing];
        
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetValidArr:resposeObject[@"data"][@"data"]];
            if (_page2 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                _isLast2 = YES;
            }
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)SetValidArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_validArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}


- (void)InValidRequest{
    
    _isLast3 = NO;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ProjectDisabled_URL parameters:nil success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        
        [_MainTableView.mj_header endRefreshing];
        
        _page3 = 1;
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_inValidArr removeAllObjects];
            [self SetInValidArr:resposeObject[@"data"][@"data"]];
            if (_page3 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                _isLast3 = YES;
            }
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)InValidRequestAdd{
    
    _page3 += 1;
    [BaseRequest GET:BrokerDisabled_URL parameters:@{@"page":@(_page3)} success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        
        [_MainTableView.mj_footer endRefreshing];
        
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetInValidArr:resposeObject[@"data"][@"data"]];
            if (_page3 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                _isLast3 = YES;
            }
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)SetInValidArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_inValidArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}


- (void)ApealRequest{
    
    _isLast4 = NO;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ProjectAppealList_URL parameters:nil success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        
        [_MainTableView.mj_header endRefreshing];
        
        _page4 = 1;
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_appealArr removeAllObjects];
            [self SetApealArr:resposeObject[@"data"][@"data"]];
            if (_page4 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                _isLast4 = YES;
            }
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)ApealRequestAdd{
    
    _page4 += 1;
    [BaseRequest GET:BrokerAppeal_URL parameters:@{@"page":@(_page4)} success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        
        [_MainTableView.mj_footer endRefreshing];
        
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetApealArr:resposeObject[@"data"][@"data"]];
            if (_page4 == [resposeObject[@"data"][@"last_page"] integerValue]) {
                
                _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                _isLast4 = YES;
            }
        }
    } failure:^(NSError *error) {
        
        [_MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)SetApealArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_appealArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}


-(void)initUI
{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客源成交";
    self.line.hidden = YES;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 4, 40 *SIZE);
    
    _nomineeColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _nomineeColl.backgroundColor = CH_COLOR_white;
    _nomineeColl.delegate = self;
    _nomineeColl.dataSource = self;
    _nomineeColl.bounces = NO;
    [_nomineeColl registerClass:[RecommendCollCell class] forCellWithReuseIdentifier:@"RecommendCollCell"];
    [self.view addSubview:_nomineeColl];
    [_nomineeColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:0];
    
    _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT - 41 *SIZE) style:UITableViewStylePlain];
    _MainTableView.backgroundColor = YJBackColor;
    _MainTableView.delegate = self;
    _MainTableView.dataSource = self;
    [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_MainTableView];
    _MainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (_index == 0) {
            
            [self UnComfirmRequest];
            
        }else if (_index == 1){
            
            [self ValidRequest];
            
        }else if (_index == 2){
            
            [self InValidRequest];
        }else{
            
            [self ApealRequest];
        }
    }];
    
    _MainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (_index == 0) {
            
            [self UnComfirmRequestAdd];
            
        }else if (_index == 1){
            
            [self ValidRequestAdd];
            
        }else if (_index == 2){
            
            [self InValidRequestAdd];
        }else{
            
            [self ApealRequestAdd];
        }
    }];
}

@end
