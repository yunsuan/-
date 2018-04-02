//
//  CustomDetailTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomDetailTableCell.h"

@implementation CustomDetailTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _cellView = [[CustomTableCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 348 *SIZE)];
    [self.contentView addSubview:_cellView];
    
    UILabel *tagL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 367 *SIZE, 80 *SIZE, 14 *SIZE)];
    tagL.textColor = YJTitleLabColor;
    tagL.font = [UIFont systemFontOfSize:15 *SIZE];
    tagL.text = @"需求标签";
    [self.contentView addSubview:tagL];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 466 *SIZE, SCREEN_Width, 36 *SIZE)];
    view.backgroundColor = YJBackColor;
    [self.contentView addSubview:view];
    
    UILabel *requestL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 12 *SIZE, 100 *SIZE, 12 *SIZE)];
    requestL.textColor = YJContentLabColor;
    requestL.font = [UIFont systemFontOfSize:13 *SIZE];
    requestL.text = @"其他要求";
    [view addSubview:requestL];
    
    _requireL = [[UILabel alloc] init];
    _requireL.textColor = YJContentLabColor;
    _requireL.numberOfLines = 0;
    _requireL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_requireL];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_requireL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(518 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-72 *SIZE);
    }];
}

@end
