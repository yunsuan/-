//
//  CountDownCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownCell : UITableViewCell
@property (nonatomic , strong) UILabel *day;
@property (nonatomic , strong) UILabel *hour;
@property (nonatomic , strong) UILabel *min;
@property (nonatomic , strong) UILabel *sec;
@property (nonatomic , assign)  NSInteger days;

-(void)setcountdownbytime:(NSInteger )day;
@end
