//
//  SelectCompanyTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SelectCompanyTableCell.h"

@implementation SelectCompanyTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 17 *SIZE, 67 *SIZE, 67 *SIZE)];
    _headImg.backgroundColor = YJGreenColor;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(95 *SIZE, 16 *SIZE, 180 *SIZE, 13 *SIZE)];
    _nameL.textColor = YJContentLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    _nameL.text = @"运算科技";
    [self.contentView addSubview:_nameL];
    
    _addressL = [[UILabel alloc] initWithFrame:CGRectMake(95 *SIZE, 36 *SIZE, 180 *SIZE, 11 *SIZE)];
    _addressL.textColor = YJContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
    _addressL.text = @"大禹东路108号3栋2单元";
    [self.contentView addSubview:_addressL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(95 *SIZE, 56 *SIZE, 180 *SIZE, 10 *SIZE)];
    _codeL.textColor = YJContentLabColor;
    _codeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _codeL.text = @"营业执照：YYZZHNO138";
    [self.contentView addSubview:_codeL];
    
    _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(95 *SIZE, 74 *SIZE, 180 *SIZE, 10 *SIZE)];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    _phoneL.text = @"联系方式：18745455623";
    [self.contentView addSubview:_phoneL];
    
    _contactL = [[UILabel alloc] initWithFrame:CGRectMake(280 *SIZE, 74 *SIZE, 70 *SIZE, 10 *SIZE)];
    _contactL.textColor = YJContentLabColor;
    _contactL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contactL.textAlignment = NSTextAlignmentRight;
    _contactL.text = @"负责人：张三";
    [self.contentView addSubview:_contactL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 99 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
