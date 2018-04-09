//
//  RecommendVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendVC.h"
#import "RecommendCell.h"
#import "RecommendCollCell.h"

@interface RecommendVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic, strong) UICollectionView *recommendColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

-(void)initUI;
-(void)initDateSouce;

@end

@implementation RecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"推荐";
    self.leftButton.hidden = YES;
    [self initDateSouce];
    [self initUI];
    
}

-(void)initDateSouce
{
    
}

-(void)initUI
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 5, 40 *SIZE);
    
    _recommendColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _recommendColl.backgroundColor = CH_COLOR_white;
    _recommendColl.delegate = self;
    _recommendColl.dataSource = self;
    _recommendColl.bounces = NO;
    [_recommendColl registerClass:[RecommendCollCell class] forCellWithReuseIdentifier:@"RecommendCollCell"];
    [self.view addSubview:_recommendColl];
    [self.view addSubview:self.MainTableView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCollCell" forIndexPath:indexPath];
    if (!cell) {

        cell = [[RecommendCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width /5, 40 *SIZE)];
    }
    cell.titleL.text = @"需求类型";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 127*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecommendCell";

    RecommendCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.nameL.text = @"张三";
    cell.projectL.text = @"推荐项目：云算公馆";
    cell.codeL.text = @"推荐编号：456522312";
    cell.confirmL.text = @"到访确认人：李四";
    cell.addressL.text = @"项目地址：四川-成都-郫都区";
    cell.timeL.text = @"失效截止时间：2017-12-15  13:00:00";

    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}



#pragma mark  ---  懒加载   ---
-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT - 41 *SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //        _MainTableView.scrollEnabled = NO;
    }
    return _MainTableView;
}



@end
