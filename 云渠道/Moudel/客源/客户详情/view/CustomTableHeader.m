//
//  CustomTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomTableHeader.h"
#import "CustomHeaderCollCell.h"

@interface CustomTableHeader()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation CustomTableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomHeaderCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomHeaderCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CustomHeaderCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 47 *SIZE)];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        
        [_delegate collectionView:_headerColl didSelectItemAtIndexPath:indexPath];
    }
}

- (void)initUI{
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 47 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _headerColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 320 *SIZE, SCREEN_Width, 47 *SIZE) collectionViewLayout:_flowLayout];
    _headerColl.backgroundColor = YJBackColor;
    _headerColl.delegate = self;
    _headerColl.dataSource = self;
    
    [_headerColl registerClass:[CustomHeaderCollCell class] forCellWithReuseIdentifier:@"CustomHeaderCollCell"];
    [self.contentView addSubview:_headerColl];
    
}

@end
