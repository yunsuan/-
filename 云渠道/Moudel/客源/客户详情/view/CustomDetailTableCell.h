//
//  CustomDetailTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableCellView.h"
#import "TagView.h"
#import "CustomRequireModel.h"

@interface CustomDetailTableCell : UITableViewCell

@property (nonatomic, strong) CustomTableCellView *cellView;

@property (nonatomic, strong) TagView *tagView;

@property (nonatomic, strong) UILabel *requireL;

@property (nonatomic, strong) CustomRequireModel *model;

@end
