//
//  NomineeCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "NomineeCell.h"

@implementation NomineeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 50 *SIZE, 13 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 38 *SIZE, 200 *SIZE, 13 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_codeL];

    _reportTimeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 61 *SIZE, 170 *SIZE, 10 *SIZE)];
    _reportTimeL.textColor = YJ86Color;
    _reportTimeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _reportTimeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_reportTimeL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 81 *SIZE, 170 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJ86Color;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 106 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
