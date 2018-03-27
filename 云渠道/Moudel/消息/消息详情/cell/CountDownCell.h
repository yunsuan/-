//
//  CountDownCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownCell : UITableViewCell


-(void)setcountdownbyday:(NSInteger )day
                   hours:(NSInteger )hours
                     min:(NSInteger )min
                     sec:(NSInteger )sec;


@end
