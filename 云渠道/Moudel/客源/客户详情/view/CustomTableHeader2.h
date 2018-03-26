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

@end

@interface CustomTableHeader2 : UITableViewHeaderFooterView

@property (nonatomic, strong) UICollectionView *headerColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, weak) id<CustomTableHeader2Delegate> delegate;

@end
