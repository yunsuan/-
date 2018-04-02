//
//  CustomTableHeader3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomTableHeader3.h"
#import "CustomHeaderCollCell.h"

@interface CustomTableHeader3()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation CustomTableHeader3

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (_delegate &&[_delegate respondsToSelector:@selector(DGActionEditBtn:)]) {
        
        [_delegate DGActionEditBtn:btn];
    }else{
        
        NSLog(@"没有代理人");
    }
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (_delegate && [_delegate respondsToSelector:@selector(DGActionAddBtn:)]) {
        
        [_delegate DGActionAddBtn:btn];
    }else{
        
        
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomHeaderCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomHeaderCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CustomHeaderCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 47 *SIZE)];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_delegate && [_delegate respondsToSelector:@selector(head3collectionView:didSelectItemAtIndexPath:)]) {
        
        [_delegate head3collectionView:_headerColl didSelectItemAtIndexPath:indexPath];
    }else{
        
        NSLog(@"没有代理人");
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = COLOR(27, 152, 255, 1);;
    [self.contentView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28 *SIZE, 19 *SIZE, 80 *SIZE, 15 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"客户信息";
    [self.contentView addSubview:label];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(316 *SIZE, 16 *SIZE, 36 *SIZE, 22 *SIZE);
    editBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:COLOR(27, 152, 255, 1) forState:UIControlStateNormal];
    [self.contentView addSubview:editBtn];
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28 *SIZE, 54 *SIZE + 31 *SIZE * i, 317 *SIZE, 31 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _nameL = label;
                [self.contentView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _genderL = label;
                [self.contentView addSubview:_genderL];
                break;
            }
            case 2:
            {
                _birthL = label;
                [self.contentView addSubview:_birthL];
                break;
            }
            case 3:
            {
                _phoneL = label;
                [self.contentView addSubview:_phoneL];
                break;
            }
            case 4:
            {
                _phone2L = label;
                [self.contentView addSubview:_phone2L];
                break;
            }
            case 5:
            {
                _certL = label;
                [self.contentView addSubview:_certL];
                break;
            }
            case 6:
            {
                _numL = label;
                [self.contentView addSubview:_numL];
                break;
            }
            case 7:
            {
                _addressL = label;
                [self.contentView addSubview:_addressL];
                break;
            }
            default:
                break;
        }
    }
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 47 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _headerColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 320 *SIZE, SCREEN_Width, 47 *SIZE) collectionViewLayout:_flowLayout];
    _headerColl.backgroundColor = YJBackColor;
    _headerColl.delegate = self;
    _headerColl.dataSource = self;
    
    [_headerColl registerClass:[CustomHeaderCollCell class] forCellWithReuseIdentifier:@"CustomHeaderCollCell"];
    [self.contentView addSubview:_headerColl];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(321 *SIZE, CGRectGetMaxY(_headerColl.frame) + 11 *SIZE, 31 *SIZE, 31 *SIZE);
    [_addBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addBtn];
    
    UILabel *newL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 18 *SIZE + CGRectGetMaxY(_headerColl.frame), 50 *SIZE, 14 *SIZE)];
    newL.textColor = YJTitleLabColor;
    newL.font = [UIFont systemFontOfSize:15 *SIZE];
    newL.text = @"新房";
    [self.contentView addSubview:newL];
    
    for (int i = 0; i < 2; i++) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50 *SIZE * (i + 1) - SIZE + CGRectGetMaxY(_headerColl.frame), SCREEN_Width, SIZE)];
        line.backgroundColor = YJBackColor;
        if (i == 1) {
            
            line.frame = CGRectMake(0 , 117 *SIZE - SIZE + CGRectGetMaxY(_headerColl.frame), SCREEN_Width, SIZE);
        }
        [self.contentView addSubview:line];
    }
    
    _numListL = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 68 *SIZE + CGRectGetMaxY(_headerColl.frame), 150 *SIZE, 16 *SIZE)];
    _numListL.textColor = YJTitleLabColor;
    _numListL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_numListL];
    
    _recommendListL = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 92 *SIZE + CGRectGetMaxY(_headerColl.frame), 150 *SIZE, 16 *SIZE)];
    _recommendListL.textColor = YJBlueBtnColor;
    _recommendListL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_recommendListL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(287 *SIZE, 66 *SIZE + CGRectGetMaxY(_headerColl.frame), 70 *SIZE, 20 *SIZE);
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *sIZE];
//    [_moreBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"产看全部 》" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
}

@end
