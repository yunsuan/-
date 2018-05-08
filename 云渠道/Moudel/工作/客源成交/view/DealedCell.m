//
//  DealedCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DealedCell.h"

@implementation DealedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 16 *SIZE, 100 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 45 *SIZE, 300 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _contactL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 66 *SIZE, 300 *SIZE, 11 *SIZE)];
    _contactL.textColor = YJ86Color;
    _contactL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_contactL];
    
    _dealTimeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 87 *SIZE, 300 *SIZE, 11 *SIZE)];
    _dealTimeL.textColor = YJBlueBtnColor;
    _dealTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_dealTimeL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 112 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
