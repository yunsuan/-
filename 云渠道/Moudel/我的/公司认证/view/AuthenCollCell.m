//
//  AuthenCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AuthenCollCell.h"

@implementation AuthenCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 100 *SIZE, 83 *SIZE)];
    _imageView.image =[UIImage imageNamed:@"uploadphotos"];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setBackgroundColor:YJGreenColor];
    _cancelBtn.frame = CGRectMake(95 *sIZE, 0, 20 *sIZE, 20 *sIZE);
    [_cancelBtn setImage:[UIImage imageNamed:@"btn_1_34 shanchu"] forState:UIControlStateNormal];
    [self.contentView addSubview:_cancelBtn];
}

@end
