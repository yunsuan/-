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

@end

@implementation BuildingAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
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
    self.navBackgroundView.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 55 *SIZE - TAB_BAR_MORE)];
    _scrollView.delegate = self;
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
