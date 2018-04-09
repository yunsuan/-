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
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 28 *SIZE, 67 *SIZE, 67 *SIZE)];
    _headImg.layer.cornerRadius = 33.5 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(90 *SIZE, 18 *SIZE, 50 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _projectL = [[UILabel alloc] initWithFrame:CGRectMake(200 *SIZE, 21 *SIZE, 150 *SIZE, 10 *SIZE)];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:11 *SIZE];
    _projectL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_projectL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(90 *SIZE, 42 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _confirmL = [[UILabel alloc] initWithFrame:CGRectMake(90 *SIZE, 62 *SIZE, 200 *SIZE, 10 *SIZE)];
    _confirmL.textColor = YJ86Color;
    _confirmL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_confirmL];
    
    _addressL = [[UILabel alloc] initWithFrame:CGRectMake(90 *SIZE, 80 *SIZE, 200 *SIZE, 10 *SIZE)];
    _addressL.textColor = YJ86Color;
    _addressL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_addressL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(90 *SIZE, 99 *SIZE, 300 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJBlueBtnColor;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 126 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
