//
//  HouseTypeTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseTypeTableHeader.h"
#import "HouseHeaderCollCell.h"
#import "BuildingAlbumCollCell.h"

@interface HouseTypeTableHeader() <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSInteger _num;
    NSMutableArray *_allArr;
    NSInteger _total;
    NSInteger _current;
}

@end

@implementation HouseTypeTableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _num = 1;
        _allArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setImgArr:(NSMutableArray *)imgArr{
    
    _imgArr = [NSMutableArray arrayWithArray:imgArr];
    for ( int i = 0; i < imgArr.count; i++) {
        
        if ([imgArr[i] isKindOfClass:[NSDictionary class]]) {
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:imgArr[i]];
            
            for (int j = 0; j < [tempDic[@"data"] count]; j++) {
                
                _total = _total + 1;
                [_allArr addObject:tempDic[@"data"][j]];
            }
        }
    }
    [_scrollView setContentSize:CGSizeMake(SCREEN_Width * _total, _scrollView.frame.size.height)];
    
    for (int i = 0; i < _total; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, _scrollView.frame.size.height)];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:img];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_Net,_allArr[i][@"img_url"]]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                img.image = [UIImage imageNamed:@""];
            }
        }];
    }
    [_imgColl reloadData];
    [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _num = (scrollView.contentOffset.x / SCREEN_Width) + 1;
    
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        
        if (([_imgArr[i][@"data"] count]  + count)< _num) {
            
            count = count + [_imgArr[i][@"data"] count];
        }else{
            
            [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
            break;
        }
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    
    CGFloat combinedItemWidth = (numberOfItems * _flowLayout.itemSize.width) + ((numberOfItems - 1) * _flowLayout.minimumInteritemSpacing);
    
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth) / 2;
    
    padding = padding > 0 ? padding :0 ;
    
    return UIEdgeInsetsMake(0, padding + 5 *SIZE,0, padding - 5 *SIZE);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BuildingAlbumCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuildingAlbumCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BuildingAlbumCollCell alloc] initWithFrame:CGRectMake(0, 0, 50 *SIZE, 27 *SIZE)];
    }
    
    cell.contentL.text = _imgArr[indexPath.item][@"type_name"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        if (i < indexPath.item) {
            
            count = count + [_imgArr[i][@"data"] count];
        }
    }
    [_scrollView setContentOffset:CGPointMake(count * SCREEN_Width, 0) animated:NO];

}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 183 *SIZE)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.contentView addSubview:_scrollView];

    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 143 *SIZE, SCREEN_Width, 40 *SIZE)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.2;
    [self.contentView addSubview:alphaView];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(50 *SIZE, 27 *SIZE);
    _flowLayout.minimumInteritemSpacing = 17 *SIZE;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;


    _imgColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 143 *SIZE , SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _imgColl.backgroundColor = [UIColor clearColor];
    _imgColl.delegate = self;
    _imgColl.dataSource = self;
    
    [_imgColl registerClass:[BuildingAlbumCollCell class] forCellWithReuseIdentifier:@"BuildingAlbumCollCell"];
    [self.contentView addSubview:_imgColl];
}

@end
