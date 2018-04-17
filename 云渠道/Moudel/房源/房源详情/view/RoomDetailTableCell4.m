//
//  RoomDetailTableCell4.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableCell4.h"
#import "RoomCellCollCell4.h"

@interface RoomDetailTableCell4()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    NSArray *namearr;
}

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation RoomDetailTableCell4

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        namearr = @[@"学校",@"医院",@"购物",@"餐饮",@"楼盘"];
        [self initUI];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomCellCollCell4 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomCellCollCell4" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomCellCollCell4 alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 27 *SIZE)];
    }
    
    cell.titleL.text = namearr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_delegate && [_delegate respondsToSelector:@selector(Cell4collectionView:didSelectItemAtIndexPath:)]) {
        
        [_delegate Cell4collectionView:_POIColl didSelectItemAtIndexPath:indexPath];
    }else{
        
        NSLog(@"没有代理人");
    }
}

- (void)initUI{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 9 *SIZE, 80 *SIZE, 15 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"周边及配套";
    [self.contentView addSubview:label];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(60 *SIZE, 27 *SIZE);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.minimumInteritemSpacing = 10 *SIZE;
//    _flowLayout.minimumLineSpacing = 15 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(17 *SIZE, 10 *SIZE, 16 *SIZE, 11 *SIZE);
    
    _POIColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 220 *SIZE, SCREEN_Width, 60 *SIZE) collectionViewLayout:_flowLayout];
    _POIColl.backgroundColor = self.contentView.backgroundColor;
    _POIColl.delegate = self;
    _POIColl.dataSource = self;
    
    [_POIColl registerClass:[RoomCellCollCell4 class] forCellWithReuseIdentifier:@"RoomCellCollCell4"];
    [self.contentView addSubview:_POIColl];
}

@end
