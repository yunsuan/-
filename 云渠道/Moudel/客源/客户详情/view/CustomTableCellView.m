//
//  CustomTableCellView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomTableCellView.h"

@implementation CustomTableCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionDeleteBtn:(UIButton *)btn{
    
    if (self.deleteBtnBlock) {
        
        self.deleteBtnBlock(self.tag);
    }
}

- (void)ActionEditBtn:(UIButton *)btn{
 
    if (self.editBlock) {
        
        self.editBlock(self.tag);
    }
}

- (void)initUI{
    
    for (int i = 0 ; i < 11; i++) {
        
        if (i < 2) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(280 *SIZE + i * 47 *SIZE, 5 *SIZE, 29 *SIZE, 29 *SIZE);
            if (i == 0) {
                
                [btn addTarget:self action:@selector(ActionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:[UIImage imageNamed:@"delete_2"] forState:UIControlStateNormal];
                _deleteBtn = btn;
                [self addSubview:_deleteBtn];
            }else{
                
                [btn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:[UIImage imageNamed:@"eidt"] forState:UIControlStateNormal];
                _editBtn = btn;
                [self addSubview:_editBtn];
            }
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(29 *SIZE, 13 *SIZE + i * 30 *SIZE, 230 *SIZE, 12 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _addressL = label;
                [self addSubview:_addressL];
                break;
            }
            case 1:
            {
                _priceL = label;
                [self addSubview:_priceL];
                break;
            }
            case 2:
            {
                _areaL = label;
                [self addSubview:_areaL];
                break;
            }
            case 3:
            {
                _houseTypeL = label;
                [self addSubview:_houseTypeL];
                break;
            }
            case 4:
            {
                _faceL = label;
                [self addSubview:_faceL];
                break;
            }
            case 5:
            {
                _floorL = label;
                [self addSubview:_floorL];
                break;
            }
            case 6:
            {
                _standardL = label;
                [self addSubview:_standardL];
                break;
            }
            case 7:
            {
                _purposeL = label;
                [self addSubview:_purposeL];
                break;
            }
            case 8:
            {
                _payWayL = label;
                [self addSubview:_payWayL];
                break;
            }
            case 9:
            {
                _intentionL = label;
                [self addSubview:_intentionL];
                break;
            }
            case 10:
            {
                _urgentL = label;
                [self addSubview:_urgentL];
                break;
            }
            default:
                break;
        }
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 347 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self addSubview:line];
}

@end
