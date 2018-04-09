//
//  RecommendCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendCell3.h"

@implementation RecommendCell3

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
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(90 *SIZE, 21 *SIZE, 50 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    UIImageView *phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(260 *SIZE, 21 *SIZE, 16 *SIZE, 16 *SIZE)];
    phoneImg.image = [UIImage imageNamed:@"phone"];
    [self.contentView addSubview:phoneImg];
    
    _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(279 *SIZE, 25 *SIZE, 77 *SIZE, 10 *SIZE)];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_phoneL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(90 *SIZE, 45 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _confirmL = [[UILabel alloc] initWithFrame:CGRectMake(90 *SIZE, 66 *SIZE, 200 *SIZE, 10 *SIZE)];
    _confirmL.textColor = YJ86Color;
    _confirmL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_confirmL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(90 *SIZE, 88 *SIZE, 300 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJ86Color;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(300 *SIZE, 87 *SIZE, 50 *SIZE, 10 *SIZE)];
    _statusL.textColor = YJBlueBtnColor;
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 112 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
