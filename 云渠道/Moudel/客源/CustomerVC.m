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


@interface CustomerVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_dataArr;
    
}

@property (nonatomic, strong) UITableView *customerTable;

@property (nonatomic, strong) UICollectionView *customerColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) BoxView *boxView;


@end

@implementation CustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
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
    
    return 3;
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
    
    CustomerTableModel *model = [[CustomerTableModel alloc] init];
    
    model.name = @"金三";
    model.price = @"80-100万";
    model.type = @"三室一厅一卫";
    model.area = @"郫都区-德源大道";
    model.matchRate = @"30";
    model.phone = @"15983804766";
    model.intention = @"23";
    model.urgent = @"43";
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomDetailVC *nextVC = [[CustomDetailVC alloc] init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)initUI{
    
    self.titleLabel.text = @"客源";
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.view.backgroundColor = YJBackColor;
    
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
}

- (BoxView *)boxView{
    
    if (!_boxView) {
        
        _boxView = [[BoxView alloc] initWithFrame:CGRectMake(0, 43 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE)];
    }
    return _boxView;
}

@end
