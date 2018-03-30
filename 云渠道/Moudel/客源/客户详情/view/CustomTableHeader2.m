
//
//  CustomTableHeader2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomTableHeader2.h"
#import "CustomHeaderCollCell.h"

@interface CustomTableHeader2()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation CustomTableHeader2

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
    
    if (_delegate && [_delegate respondsToSelector:@selector(head2collectionView:didSelectItemAtIndexPath:)]) {
        
        [_delegate head2collectionView:_headerColl didSelectItemAtIndexPath:indexPath];
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
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE + CGRectGetMaxY(_headerColl.frame), 7 *SIZE, 13 *SIZE)];
    view1.backgroundColor = COLOR(27, 152, 255, 1);;
    [self.contentView addSubview:view];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(28 *SIZE, 19 *SIZE  + CGRectGetMaxY(_headerColl.frame), 80 *SIZE, 15 *SIZE)];
    label1.textColor = YJTitleLabColor;
    label1.font = [UIFont systemFontOfSize:15 *SIZE];
    label1.text = @"跟进记录";
    [self.contentView addSubview:label1];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(321 *SIZE, CGRectGetMaxY(_headerColl.frame) + 11 *SIZE, 31 *SIZE, 31 *SIZE);
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addBtn];
}

@end
