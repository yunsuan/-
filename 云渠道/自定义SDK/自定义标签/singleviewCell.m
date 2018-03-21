//
//  singleviewCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "singleviewCell.h"

@implementation singleviewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.displayLabel];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 1.7*SIZE;
        self.layer.borderWidth = 0.5*SIZE;
        self.layer.borderColor = COLOR(181, 181, 181, 1).CGColor;
      
    }
    return self;
}

- (UILabel *)displayLabel{
    if (!_displayLabel) {
        _displayLabel = [[UILabel alloc]initWithFrame:CGRectMake(4.7*SIZE, 3.7*SIZE, self.contentView.frame.size.width - 9.4*SIZE, 11*SIZE)];
        _displayLabel.textAlignment = NSTextAlignmentLeft;
        _displayLabel.font = [UIFont systemFontOfSize:10.7*SIZE];
        _displayLabel.textColor = COLOR(115, 115, 115, 1);
    }
    return _displayLabel;
}


@end
