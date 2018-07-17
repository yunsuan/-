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
{
    
    NSArray *_titleArr;
}

@end

@implementation CustomTableHeader3

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleArr = @[@"需求信息",@"跟进记录",@"匹配信息"];
        [self initUI];
    }
    return self;
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.editBtnBlock) {
        
        self.editBtnBlock();
    }
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.addBtnBlock) {
        
        self.addBtnBlock();
    }
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.moreBtnBlock) {
        
        self.moreBtnBlock();
    }
}

- (void)ActionStatusBtn:(UIButton *)btn{
    
    if (self.statusBtnBlock) {
        
        self.statusBtnBlock();
    }
}

- (void)setModel:(CustomerModel *)model{
    
    if (model.name) {
        
        self.nameL.text = [NSString stringWithFormat:@"姓名：%@",model.name];
    }else{
        
        self.nameL.text = @"姓名";
    }
    
    if ([model.sex integerValue] == 1) {
        
        self.genderL.text = @"性别：男";
    }else if([model.sex integerValue] == 2){
        
        self.genderL.text = @"性别：女";
    }else{
        
        self.genderL.text = @"性别：";
    }
    
    if (model.birth) {
        
        self.birthL.text = [NSString stringWithFormat:@"出生年月：%@",model.birth];
    }else{
        
        self.birthL.text = @"出生年月：";
    }
    
    if (model.tel) {
        
        self.phoneL.text = [NSString stringWithFormat:@"联系电话：%@",model.tel];
    }else{
        
        self.phoneL.text = @"联系电话：";
    }

    NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
    NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",2]];
    NSArray *typeArr = dic[@"param"];
    self.certL.text = @"证件类型：";
    for (int i = 0; i < typeArr.count; i++) {
        
        if ([typeArr[i][@"id"] integerValue] == [model.card_type integerValue]) {
            
            self.certL.text = [NSString stringWithFormat:@"证件类型：%@",typeArr[i][@"param"]];
            break;
        }
    }
    
    if (model.card_id) {
        
        self.numL.text = [NSString stringWithFormat:@"证件号码：%@",model.card_id];
    }else{
        
        self.numL.text = @"证件号码：";
    }
    
//    self.addressL.text = @"地址：";
    if (model.province_name&&model.city_name&&model.district_name) {
        self.addressL.text = [NSString stringWithFormat:@"地址：%@-%@-%@-%@",model.province_name,model.city_name,model.district_name,model.address];
    }
    else{
        self.addressL.text = @"地址：";
    }
//    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
//
//    NSError *err;
//    NSArray *provice = [NSJSONSerialization JSONObjectWithData:JSONData
//                                                       options:NSJSONReadingMutableContainers
//                                                         error:&err];
//    for (int i = 0; i < provice.count; i++) {
//
//        if([provice[i][@"code"] integerValue] == [model.province integerValue]){
//
//            NSArray *city = provice[i][@"city"];
//            for (int j = 0; j < city.count; j++) {
//
//                if([city[j][@"code"] integerValue] == [model.city integerValue]){
//
//                    NSArray *area = city[j][@"district"];
//
//                    for (int k = 0; k < area.count; k++) {
//
//                        if([area[k][@"code"] integerValue] == [model.district integerValue]){
//
//                            self.addressL.text = [NSString stringWithFormat:@"地址：%@-%@-%@-%@",provice[i][@"name"],city[0][@"name"],area[k][@"name"],model.address];
//                        }
//                    }
//                }
//            }
//        }
//    }
}


#pragma mark -- CollDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomHeaderCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomHeaderCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CustomHeaderCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 47 *SIZE)];
    }
    cell.titleL.text = _titleArr[indexPath.item];
    
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
                _certL = label;
                [self.contentView addSubview:_certL];
                break;
            }
            case 5:
            {
                _numL = label;
                [self.contentView addSubview:_numL];
                break;
            }
            case 6:
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
    
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 49 *SIZE + CGRectGetMaxY(_headerColl.frame), SCREEN_Width, SIZE)];
//    line.backgroundColor = YJBackColor;
//
//   [self.contentView addSubview:line];
    
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 18 *SIZE + CGRectGetMaxY(_headerColl.frame), 50 *SIZE, 14 *SIZE)];
//    label2.textColor = YJTitleLabColor;
//    label2.font = [UIFont systemFontOfSize:15 *SIZE];
//    label2.text = @"新房";
//    [self.contentView addSubview:label2];

//    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _addBtn.frame = CGRectMake(321 *SIZE, 10 *SIZE + CGRectGetMaxY(_headerColl.frame), 36 *SIZE, 36 *SIZE);
//    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_addBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
//    [self.contentView addSubview:_addBtn];
    
    _numListL = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 26 *SIZE + CGRectGetMaxY(_headerColl.frame), 150 *SIZE, 16 *SIZE)];
    _numListL.textColor = YJTitleLabColor;
    _numListL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_numListL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(6 *SIZE, 21 *SIZE + CGRectGetMaxY(_headerColl.frame), 160 *SIZE, 26 *SIZE);
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
    
    _recommendListL = [[UILabel alloc] initWithFrame:CGRectMake(250 *SIZE, 28 *SIZE + CGRectGetMaxY(_headerColl.frame), 98 *SIZE, 16 *SIZE)];
    _recommendListL.textColor = YJBlueBtnColor;
    _recommendListL.textAlignment = NSTextAlignmentRight;
    _recommendListL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_recommendListL];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(245 *SIZE, 23 *SIZE + CGRectGetMaxY(_headerColl.frame), 108 *SIZE, 26 *SIZE);
    [_recommendBtn addTarget:self action:@selector(ActionStatusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_recommendBtn];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 67 *SIZE + CGRectGetMaxY(_headerColl.frame), SCREEN_Width, SIZE)];
    line2.backgroundColor = YJBackColor;
    
    [self.contentView addSubview:line2];
}

@end
