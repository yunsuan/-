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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CustomTableHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UICollectionView *headerColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, weak) id<CustomTableHeaderDelegate> delegate;



@end
