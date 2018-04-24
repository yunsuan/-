//
//  BuildingAlbumVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BuildingAlbumVC.h"
#import "BuildingAlbumCollCell.h"

@interface BuildingAlbumVC ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSInteger _num;
    NSMutableArray *_imgArr;
}
@end

@implementation BuildingAlbumVC

- (instancetype)initWithNum:(NSInteger)num imgArr:(NSArray *)imgArr
{
    self = [super init];
    if (self) {
        
        _num = num;
        _imgArr = [NSMutableArray arrayWithArray:imgArr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
//    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}
//- (void)setNeedsStatusBarAppearanceUpdate{
//
//    [super setNeedsStatusBarAppearanceUpdate];
//}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BuildingAlbumCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuildingAlbumCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BuildingAlbumCollCell alloc] initWithFrame:CGRectMake(0, 0, 50 *SIZE, 27 *SIZE)];
    }
    
    cell.contentL.text = @"效果图";
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (void)initUI{
    
    self.titleLabel.text = @"楼盘相册";
    self.navBackgroundView.hidden = NO;
    self.titleLabel.textColor = CH_COLOR_white;
    self.line.hidden = YES;
    self.navBackgroundView.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 55 *SIZE - TAB_BAR_MORE)];
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(SCREEN_Width * _imgArr.count, _scrollView.bounds.size.height)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(50 *SIZE, 27 *SIZE);
    _flowLayout.minimumInteritemSpacing = 7 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(SIZE, 10 *SIZE, 27 *SIZE, 10 *SIZE);
    
    _albumColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_Height - 55 *SIZE - TAB_BAR_MORE, SCREEN_Width, 55 *SIZE) collectionViewLayout:_flowLayout];
    _albumColl.backgroundColor = [UIColor blackColor];
    _albumColl.delegate = self;
    _albumColl.dataSource = self;
    
    [_albumColl registerClass:[BuildingAlbumCollCell class] forCellWithReuseIdentifier:@"BuildingAlbumCollCell"];
    [self.view addSubview:_albumColl];
    
    
}

@end
