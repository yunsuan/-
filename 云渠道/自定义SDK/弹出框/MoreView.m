//
//  MoreView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MoreView.h"
#import "MoreViewCollCell.h"
#import "MoreViewCollHeader.h"

@interface MoreView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    
}


@end

@implementation MoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 3;
    }else if (section == 1){
        
        return 6;
    }else{
        
        return 3;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 35 *SIZE);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    MoreViewCollHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MoreViewCollHeader" forIndexPath:indexPath];
    if (!header) {
        
        header = [[MoreViewCollHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 35 *SIZE)];
    }
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MoreViewCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[MoreViewCollCell alloc] initWithFrame:CGRectMake(0, 0, 77 *SIZE, 30 *SIZE)];
    }
    cell.titleL.text = @"地铁房";
    
    return cell;
}

- (void)initUI{

    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor whiteColor];
//    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _flowlayout = [[UICollectionViewFlowLayout alloc] init];
    _flowlayout.itemSize = CGSizeMake(77 *SIZE, 30 *SIZE);
    _flowlayout.minimumLineSpacing = 14 *SIZE;
    _flowlayout.minimumInteritemSpacing = 0 *SIZE;
    _flowlayout.sectionInset = UIEdgeInsetsMake(0, 10 *SIZE, 10 *SIZE, 10 *SIZE);

    _moreColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.bounds.size.height - 50 *SIZE - TAB_BAR_MORE) collectionViewLayout:_flowlayout];
    _moreColl.backgroundColor = CH_COLOR_white;
    _moreColl.delegate = self;
    _moreColl.dataSource = self;
    
    [_moreColl registerClass:[MoreViewCollCell class] forCellWithReuseIdentifier:@"MoreViewCollCell"];
    [_moreColl registerClass:[MoreViewCollHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MoreViewCollHeader"];
    [self addSubview:_moreColl];
    
//    _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _clearBtn.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
//    _clearBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
//    [_clearBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
//    [_clearBtn setTitle:<#(nullable NSString *)#> forState:UIControlStateNormal];
//    _clearBtn
//    [<#UIButton#> setTitleColor:COLOR(<#_R#>, <#_G#>, <#_B#>, <#_A#>) forState:UIControlStateNormal];
}

@end
