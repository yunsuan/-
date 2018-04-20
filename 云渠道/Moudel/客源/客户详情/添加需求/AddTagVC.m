//
//  AddTagVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddTagVC.h"
#import "AddTagViewCollCell.h"
#import "AddTagCollHeader.h"
#import "AddTagCollFooter.h"

@interface AddTagVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_dataArr;
    NSArray *_tagArr;
}
@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation AddTagVC

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        
        _tagArr = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
        _dataArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < array.count; i++) {
            [_tagArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj[@"id"] integerValue] == [array[i] integerValue]) {
                    [_dataArr addObject:obj];
                    *stop = YES;
                }
            }];
        }
//       _dataArr = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
}

- (void)ActionSaveBtn:(UIButton *)btn{
    
    if (self.saveBtnBlock) {
        self.saveBtnBlock(_dataArr);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSString *str = _tagArr[indexPath.item][@"param"];
        return CGSizeMake(13 *SIZE * str.length + 20 *SIZE * 2, 37*SIZE);
    }else{
        NSString *str = _dataArr[indexPath.item][@"param"];
        return CGSizeMake(13 *SIZE * str.length + 20 *SIZE * 2, 37*SIZE);
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return _tagArr.count;
    }
    return _dataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 40 *SIZE);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 7 *SIZE);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        AddTagCollHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AddTagCollHeader" forIndexPath:indexPath];
        if (!header) {
            
            header = [[AddTagCollHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
        }
        
        if (indexPath.section == 0) {
            
            header.titleL.text = @"所有标签";
        }else{
            
            header.titleL.text = @"已选标签";
        }
        
        return header;
    }else{
        
        AddTagCollFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AddTagCollFooter" forIndexPath:indexPath];
        if (!footer) {
            
            footer = [[AddTagCollFooter alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 7 *SIZE)];
        }        
        
        return footer;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddTagViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddTagViewCollCell" forIndexPath:indexPath];
    
    cell.tag = indexPath.item;
    
    if (indexPath.section == 0) {
        
        cell.cancelBtn.hidden = YES;
        [cell setstylebytype:@"0" andsetlab:_tagArr[indexPath.item][@"param"]];
    }else{
        
        cell.cancelBtn.hidden = NO;
        
        [cell setstylebytype:@"0" andsetlab:_dataArr[indexPath.item][@"param"]];
    }
    
    cell.deleteBtnBlock = ^(NSInteger index) {
        
        [_dataArr removeObjectAtIndex:index];
        [collectionView reloadData];
        [self reloadInputViews];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if ([_dataArr containsObject:_tagArr[indexPath.item]]) {
            
            [_dataArr removeObject:_tagArr[indexPath.item]];
        }else{
            
            [_dataArr addObject:_tagArr[indexPath.item]];
        }
    }
    [collectionView reloadData];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加标签";
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumInteritemSpacing = 0 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 32 *SIZE, 31 *SIZE, 0);
    
    
    _tagColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) collectionViewLayout:_flowLayout];
    _tagColl.backgroundColor = CH_COLOR_white;
    _tagColl.delegate = self;
    _tagColl.dataSource = self;
    
    [_tagColl registerClass:[AddTagViewCollCell class] forCellWithReuseIdentifier:@"AddTagViewCollCell"];
    [_tagColl registerClass:[AddTagCollHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AddTagCollHeader"];
    [_tagColl registerClass:[AddTagCollFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AddTagCollFooter"];
    [self.view addSubview:_tagColl];
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_saveBtn addTarget:self action:@selector(ActionSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_saveBtn];
}

@end
