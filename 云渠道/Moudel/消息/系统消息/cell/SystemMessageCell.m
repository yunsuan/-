//
//  SystemMessageCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SystemMessageCell.h"

@implementation SystemMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = YJBackColor;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UIView * backview = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE, 10*SIZE, 340*SIZE, 100*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backview];
    _title = [[UILabel alloc]initWithFrame:CGRectMake(11.3*SIZE, 14.7*SIZE, 200*SIZE, 14*SIZE)];
    _title.font = [UIFont systemFontOfSize:13.3*SIZE];
    _title.textColor = YJTitleLabColor;
    [backview addSubview:_title];
    
    UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(343 *SIZE, 36 *SIZE, 7 *SIZE, 12 *SIZE)];
    rightView.backgroundColor = YJGreenColor;
    [self.contentView addSubview:rightView];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 82 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}


@end
