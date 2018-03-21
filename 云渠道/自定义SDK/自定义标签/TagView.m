//
//  TagView.m
//  云渠道
//
//  Created by xiaoq on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TagView.h"
#import "singleviewCell.h"
@interface TagView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property ( nonatomic , strong ) UICollectionView *collectionview;
@property (nonatomic , strong) UICollectionViewFlowLayout *layout;
@property (nonatomic , strong) NSArray *data;
@end

@implementation TagView

-(instancetype)initWithFrame:(CGRect)frame
                   DataSouce:(NSArray *)datasouce
                        type:(NSString *)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _data = datasouce;
        [self addSubview:self.collectionview];
    }
    return self;
}

-(void)initViewWithstring:(NSString *)string
                    type:(NSString *)type
                      num:(int)i
{
//    UIView *backview =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, string.length*10.7*SIZE+2*4.7*SIZE, 16.7*SIZE)];
//    backview.layer.masksToBounds = YES;
//    backview.layer.cornerRadius = 1.7*SIZE;
//    backview.layer.borderWidth = 0.3*SIZE;
//    backview.layer.borderColor = COLOR(181, 181, 181, 1).CGColor;
//
    
    
}

-(UICollectionView *)collectionview
{
    if (!_collectionview) {
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 200*SIZE, 16.7*SIZE) collectionViewLayout:self.layout];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        _collectionview.backgroundColor = [UIColor clearColor];
        _collectionview.bounces = NO;
        //注册item
        [_collectionview registerClass:[singleviewCell class] forCellWithReuseIdentifier:@"singleviewCell"];
    }
    return _collectionview;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = _data[indexPath.row];
    return CGSizeMake(11*SIZE*str.length + 4.7*SIZE *2, 16.7*SIZE);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    singleviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"singleviewCell" forIndexPath:indexPath];
    cell.displayLabel.text = _data[indexPath.row];
    return cell;
}


- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        //设置item的大小
        _layout.minimumLineSpacing =0;
        _layout.minimumInteritemSpacing = 5*SIZE;
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //        _layout.sectionHeadersPinToVisibleBounds = YES;
    }
    return _layout;
}



@end
