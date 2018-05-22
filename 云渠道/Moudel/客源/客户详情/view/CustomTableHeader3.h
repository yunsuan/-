//
//  CustomTableHeader3.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerModel.h"

@protocol CustomTableHeader3Delegate;

@protocol CustomTableHeader3Delegate <NSObject>

- (void)head3collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@class CustomTableHeader3;

typedef void(^AddBtnBlock)(void);
typedef void(^EditBtnBlock)(void);
typedef void(^MoreBtnBlock)(void);
typedef void(^StatusBtnBlock)(void);

@interface CustomTableHeader3 : UITableViewHeaderFooterView

@property (nonatomic, copy) AddBtnBlock addBtnBlock;

@property (nonatomic, copy) EditBtnBlock editBtnBlock;

@property (nonatomic, copy) MoreBtnBlock moreBtnBlock;

@property (nonatomic, copy) StatusBtnBlock statusBtnBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) UILabel *birthL;

@property (nonatomic, strong) UILabel *phoneL;

//@property (nonatomic, strong) UILabel *phone2L;

@property (nonatomic, strong) UILabel *certL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UICollectionView *headerColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *numListL;

@property (nonatomic, strong) UILabel *recommendListL;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, weak) id<CustomTableHeader3Delegate> delegate;

@property (nonatomic, strong) CustomerModel *model;

@end
