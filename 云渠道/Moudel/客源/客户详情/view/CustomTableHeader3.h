//
//  CustomTableHeader3.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTableHeader3Delegate;

@protocol CustomTableHeader3Delegate <NSObject>

- (void)head3collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CustomTableHeader3 : UITableViewHeaderFooterView

@property (nonatomic, strong) UICollectionView *headerColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, weak) id<CustomTableHeader3Delegate> delegate;

@end
