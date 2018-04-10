//
//  NomineeCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "NomineeCell3.h"

@implementation NomineeCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMessBtn:(UIButton *)btn{
    
    if (self.messBtnBlock) {
        
        self.messBtnBlock(self.tag);
    }
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.phoneBtnBlock) {
        
        self.phoneBtnBlock(self.tag);
    }
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
    
    _messBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _messBtn.frame = CGRectMake(296 *SIZE, 19 *SIZE, 19 *SIZE, 19 *SIZE);
    [_messBtn addTarget:self action:@selector(ActionMessBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_messBtn setBackgroundImage:[UIImage imageNamed:@"note"] forState:UIControlStateNormal];
    [self.contentView addSubview:_messBtn];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBtn.frame = CGRectMake(335 *SIZE, 19 *SIZE, 19 *SIZE, 19 *SIZE);
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 107 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
