//
//  HouseTypeTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HouseTypeTableHeader.h"
#import "HouseHeaderCollCell.h"

@interface HouseTypeTableHeader() 


@end

@implementation HouseTypeTableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 183 *SIZE)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_scrollView];
    
//    _bigImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 183 *SIZE)];
//    _bigImg.contentMode = UIViewContentModeScaleAspectFit;
//    [self.contentView addSubview:_bigImg];
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 143 *SIZE, SCREEN_Width, 40 *SIZE)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.2;
    [self.contentView addSubview:alphaView];
    
    _planBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _planBtn.frame = CGRectMake(57 *SIZE, 7 *SIZE, 50 *SIZE, 27 *SIZE);
    _planBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
//    [_planBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_planBtn setTitle:@"平面图" forState:UIControlStateNormal];
    [_planBtn setBackgroundColor:COLOR(229, 229, 229, 1)];
    [_planBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [alphaView addSubview:_planBtn];
    
    _effectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _effectBtn.frame = CGRectMake(124 *SIZE, 7 *SIZE, 50 *SIZE, 27 *SIZE);
    _effectBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    //    [_planBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_effectBtn setTitle:@"平面图" forState:UIControlStateNormal];
    [_effectBtn setBackgroundColor:COLOR(229, 229, 229, 1)];
    [_effectBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [alphaView addSubview:_effectBtn];
    
    _d3Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _d3Btn.frame = CGRectMake(191 *SIZE, 7 *SIZE, 50 *SIZE, 27 *SIZE);
    _d3Btn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    //    [_planBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_d3Btn setTitle:@"平面图" forState:UIControlStateNormal];
    [_d3Btn setBackgroundColor:COLOR(229, 229, 229, 1)];
    [_d3Btn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [alphaView addSubview:_d3Btn];
    
    _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _actionBtn.frame = CGRectMake(257 *SIZE, 7 *SIZE, 50 *SIZE, 27 *SIZE);
    _actionBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    //    [_planBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_actionBtn setTitle:@"平面图" forState:UIControlStateNormal];
    [_actionBtn setBackgroundColor:COLOR(229, 229, 229, 1)];
    [_actionBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [alphaView addSubview:_actionBtn];
}

@end
