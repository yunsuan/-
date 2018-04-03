//
//  CustomTableHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTableHeaderDelegate;

@protocol CustomTableHeaderDelegate <NSObject>

- (void)head1collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)DGActionEditBtn:(UIButton *)btn;

- (void)DGActionAddBtn:(UIButton *)btn;

@end

@interface CustomTableHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) UILabel *birthL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *phone2L;

@property (nonatomic, strong) UILabel *certL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UICollectionView *headerColl;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, weak) id<CustomTableHeaderDelegate> delegate;



@end
