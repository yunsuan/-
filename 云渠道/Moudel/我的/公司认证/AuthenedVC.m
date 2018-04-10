//
//  AuthenedVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AuthenedVC.h"
#import "AuthenTableCell.h"
#import "AuthenCollCell.h"
#import "SelectCompanyVC.h"
#import "AuthenticationVC.h"
#import "AuthenedTableHeader.h"

@interface AuthenedVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
    NSMutableArray *_imgArr;
    NSInteger _index;
}
@property (nonatomic, strong) UITableView *authenTable;

@property (nonatomic, strong) UICollectionView *authenColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation AuthenedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _contentArr = [[NSMutableArray alloc] init];
    _imgArr = [[NSMutableArray alloc] init];
    _titleArr = @[@"所属公司",@"工号",@"角色",@"申请项目",@"所属部门",@"职位",@"入职/申请时间"];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    AuthenticationVC *nextVC = [[AuthenticationVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark --table代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 51 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 117 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    AuthenedTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AuthenedTableHeader"];
    if (!header) {
        
        header = [[AuthenedTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 117 *SIZE)];
    }
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * Identifier = @"AuthenTableCell";
    AuthenTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[AuthenTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = _titleArr[indexPath.row];
    return cell;
}


#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count < 3? _imgArr.count + 1: 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AuthenCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthenCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AuthenCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 91 *SIZE)];
    }
    cell.cancelBtn.tag = indexPath.item;
    cell.cancelBtn.hidden = YES;
    if (_imgArr.count) {
        
        if (indexPath.item < _imgArr.count) {
            
            cell.imageView.image = _imgArr[indexPath.item];
        }else{
            
            cell.imageView.image = [UIImage imageNamed:@"add"];
            cell.cancelBtn.hidden = YES;
        }
    }else{
        
        cell.imageView.image = [UIImage imageNamed:@"add"];
        cell.cancelBtn.hidden = YES;
    }
    
    return cell;
}


- (void)initUI{
    
    self.titleLabel.text = @"公司认证";
    self.navBackgroundView.hidden = NO;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width, 766 *SIZE);
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _authenTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 478 *SIZE) style:UITableViewStylePlain];
    _authenTable.backgroundColor = self.view.backgroundColor;
    _authenTable.delegate = self;
    _authenTable.dataSource = self;
    _authenTable.bounces = NO;
    _authenTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _authenTable.tableFooterView = [[UIView alloc] init];
    [_scrollView addSubview:_authenTable];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_authenTable.frame), SCREEN_Width, 174 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:whiteView];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 91 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _authenColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, 91 *SIZE) collectionViewLayout:_flowLayout];
    _authenColl.backgroundColor = CH_COLOR_white;
    _authenColl.delegate = self;
    _authenColl.dataSource = self;
    
    [_authenColl registerClass:[AuthenCollCell class] forCellWithReuseIdentifier:@"AuthenCollCell"];
    [whiteView addSubview:_authenColl];
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.frame = CGRectMake(21 *SIZE, 37 *SIZE + CGRectGetMaxY(whiteView.frame), 317 *SIZE, 40 *SIZE);
    _commitBtn.layer.masksToBounds = YES;
    _commitBtn.layer.cornerRadius = 2 *SIZE;
    _commitBtn.backgroundColor = YJLoginBtnColor;
    [_commitBtn setTitle:@"更换公司" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_commitBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_commitBtn];
}

@end
