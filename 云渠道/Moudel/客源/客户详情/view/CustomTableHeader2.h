//
//  CustomTableHeader2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTableHeader2Delegate;

@protocol CustomTableHeader2Delegate <NSObject>

- (void)head2collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)DGActionAddBtn:(UIButton *)btn;

- (void)DGActionEditBtn:(UIButton *)btn;

@end

@interface CustomTableHeader2 : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) UILabel *birthL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *phone2L;

@property (nonatomic, strong) UILabel *certL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UICollectionView *headerColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, weak) id<CustomTableHeader2Delegate> delegate;

@end
