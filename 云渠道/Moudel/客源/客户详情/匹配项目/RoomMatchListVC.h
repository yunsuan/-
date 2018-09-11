//
//  RoomMatchListVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomRequireModel.h"
#import "CustomerTableModel.h"

@interface RoomMatchListVC : BaseViewController

@property (nonatomic, strong) CustomerTableModel *customerTableModel;

- (instancetype)initWithClientId:(NSString *)clientId dataArr:(NSArray *)dataArr model:(CustomRequireModel *)model;

@end
