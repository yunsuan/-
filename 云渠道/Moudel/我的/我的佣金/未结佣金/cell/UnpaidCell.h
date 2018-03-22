//
//  UnpaidCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UnpaidCell;
typedef void (^moneybtnblook)(NSInteger *index);

@interface UnpaidCell : UITableViewCell
@property (nonatomic , copy) moneybtnblook moneybtnBlook;
@end
