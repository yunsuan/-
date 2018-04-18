//
//  RecommendCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendCell.h"

@implementation RecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 21 *SIZE, 50 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 49 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 72 *SIZE, 300 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJBlueBtnColor;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _confirmL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 97 *SIZE, 170 *SIZE, 10 *SIZE)];
    _confirmL.textColor = YJContentLabColor;
    _confirmL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_confirmL];
    
    _projectL = [[UILabel alloc] init];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:11 *SIZE];
    _projectL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_projectL];

    _statusImg = [[UIImageView alloc] init];
    _statusImg.layer.cornerRadius = 10 *SIZE;
    _statusImg.clipsToBounds = YES;
    [self.contentView addSubview:_statusImg];
    
    _addressL = [[UILabel alloc] initWithFrame:CGRectMake(180 *SIZE, 97 *SIZE, 170 *SIZE, 10 *SIZE)];
    _addressL.textColor = YJContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:11 *SIZE];
    _addressL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_addressL];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 126 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];

}


@end
