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

- (void)ActionComfirmBtn:(UIButton *)btn{
    
    if (self.confirmBtnBlock) {
        
        self.confirmBtnBlock(self.tag);
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
//    _reportTimeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_reportTimeL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 81 *SIZE, 170 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJ86Color;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _timeL.textAlignment = NSTextAlignmentRight;
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
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(273 *SIZE, 61 *SIZE, 77 *SIZE, 30 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_confirmBtn addTarget:self action:@selector(ActionComfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.contentView addSubview:_confirmBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 107 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
