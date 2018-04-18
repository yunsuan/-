//
//  CustomTableCellView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTableCellView;

typedef void(^deleteBtnBlock)(NSInteger index);

typedef void(^editBlock)(NSInteger index);

@interface CustomTableCellView : UIView

@property (nonatomic, copy) deleteBtnBlock deleteBtnBlock;

@property (nonatomic, copy) editBlock editBlock;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *houseTypeL;

//@property (nonatomic, strong) UILabel *faceL;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) UILabel *standardL;

@property (nonatomic, strong) UILabel *purposeL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *intentionL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIButton *editBtn;

@end
