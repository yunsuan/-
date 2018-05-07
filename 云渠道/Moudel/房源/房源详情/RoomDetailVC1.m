//
//  RoomDetailVC1.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailVC1.h"
#import "RoomAnalyzeVC.h"
#import "RoomBrokerageVC.h"
#import "RoomDetailCollCell.h"


@interface RoomDetailVC1 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    
    NSArray *_titleArr;
    RoomListModel *_model;
    
}
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) RoomProjectVC *roomProjectVC;

@property (nonatomic, strong) RoomAnalyzeVC *roomAnalyzeVC;

@property (nonatomic, strong) RoomBrokerageVC *roomBrokerageVC;

@end

@implementation RoomDetailVC1

- (instancetype)initWithModel:(RoomListModel *)model
{
    self = [super init];
    if (self) {
        
        _model = model;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self GetFollowRequestMethod];
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //设置隐藏
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}

- (void)initDataSource{
    
    _titleArr = @[@"项目",@"佣金",@"分析"];
}

- (void)ActionLeftBtn:(UIButton *)btn{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mapViewDismiss" object:nil];
}


#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomDetailCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomDetailCollCell alloc] initWithFrame:CGRectMake(0, 0, 66 *SIZE, 44)];
    }
    cell.titleL.text = _titleArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [_scrollView setContentOffset:CGPointMake(SCREEN_Width * indexPath.item, 0) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_Width;
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.maskButton addTarget:self action:@selector(ActionLeftBtn:) forControlEvents:UIControlEventTouchUpInside];

    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(66 *SIZE, 44);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(80 *SIZE, STATUS_BAR_HEIGHT, 200 *SIZE, 43) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = CH_COLOR_white;
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[RoomDetailCollCell class] forCellWithReuseIdentifier:@"RoomDetailCollCell"];
    [self.navBackgroundView addSubview:_segmentColl];
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建控制器
    _roomProjectVC = [[RoomProjectVC alloc] initWithProjectId:[NSString stringWithFormat:@"%@",_model.project_id]];
    _roomBrokerageVC = [[RoomBrokerageVC alloc] initWithModel:_model];
    _roomAnalyzeVC = [[RoomAnalyzeVC alloc] initWithProjectId:[NSString stringWithFormat:@"%@",_model.project_id]];
    // 添加为self的子控制器
    [self addChildViewController:_roomProjectVC];
    [self addChildViewController:_roomBrokerageVC];
    _roomProjectVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _roomBrokerageVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _roomAnalyzeVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:_roomProjectVC.view];
    [self.scrollView addSubview:_roomBrokerageVC.view];
    [self.scrollView addSubview:_roomAnalyzeVC.view];
    
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}


@end
