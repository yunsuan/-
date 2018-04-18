//
//  RecommendCell5.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendCell5.h"

@implementation RecommendCell5

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 12 *SIZE, 50 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 40 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _confirmL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 61 *SIZE, 150 *SIZE, 10 *SIZE)];
    _confirmL.textColor = YJ86Color;
    _confirmL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_confirmL];
    
    _recomTimeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 82 *SIZE, 170 *SIZE, 10 *SIZE)];
    _recomTimeL.textColor = YJContentLabColor;
    _recomTimeL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _recomTimeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_recomTimeL];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(290 *SIZE, 40 *SIZE, 59 *SIZE, 10 *SIZE)];
    _statusL.textColor = YJBlueBtnColor;
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(180 *SIZE, 84 *SIZE, 170 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 107 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}


@end
