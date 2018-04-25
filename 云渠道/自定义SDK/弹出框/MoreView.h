//
//  MoreView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreView : UIView

@property (nonatomic, strong) UICollectionView *moreColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowlayout;

@property (nonatomic, strong) UIButton *clearBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) NSMutableArray *tagSelectArr;

@property (nonatomic, strong) NSMutableArray *houseSelectArr;

@property (nonatomic, strong) NSMutableArray *statusSelectArr;

@end
