//
//  CustomerVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomerVC.h"
#import "CustomerTableCell.h"
#import "CustomerTableModel.h"
#import "MMComBoBoxView.h"
#import "MMComboBoxHeader.h"
#import "MMAlternativeItem.h"
#import "MMSelectedPath.h"
#import "MMCombinationItem.h"
#import "MMMultiItem.h"
#import "MMSingleItem.h"

@interface CustomerVC ()<UITableViewDelegate,UITableViewDataSource,MMComBoBoxViewDataSource, MMComBoBoxViewDelegate>
@property (nonatomic, strong) NSArray *mutableArray;

@property (nonatomic, strong) UITableView *customerTable;

@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;

@end

@implementation CustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - MMComBoBoxViewDataSource
- (NSUInteger)numberOfColumnsIncomBoBoxView :(MMComBoBoxView *)comBoBoxView {
    return self.mutableArray.count;
}

- (MMItem *)comBoBoxView:(MMComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column {
    return self.mutableArray[column];
}

#pragma mark - MMComBoBoxViewDelegate
- (void)comBoBoxView:(MMComBoBoxView *)comBoBoxViewd didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    MMItem *rootItem = self.mutableArray[index];
    switch (rootItem.displayType) {
        case MMPopupViewDisplayTypeNormal:
        {
            break;
        }
        case MMPopupViewDisplayTypeMultilayer:{
            //拼接选择项
            NSMutableString *title = [NSMutableString string];
            __block NSInteger firstPath;
            [array enumerateObjectsUsingBlock:^(MMSelectedPath * path, NSUInteger idx, BOOL * _Nonnull stop) {
                [title appendString:idx?[NSString stringWithFormat:@";%@",[rootItem findTitleBySelectedPath:path]]:[rootItem findTitleBySelectedPath:path]];
                if (idx == 0) {
                    firstPath = path.firstPath;
                }
            }];
            NSLog(@"当title为%@时，所选字段为 %@",rootItem.title ,title);
            break;}
        case MMPopupViewDisplayTypeFilters:{
            MMCombinationItem * combineItem = (MMCombinationItem *)rootItem;
            [array enumerateObjectsUsingBlock:^(NSMutableArray*  _Nonnull subArray, NSUInteger idx, BOOL * _Nonnull stop) {
                if (combineItem.isHasSwitch && idx == 0) {
                    for (MMSelectedPath *path in subArray) {
                        MMAlternativeItem *alternativeItem = combineItem.alternativeArray[path.firstPath];
                        NSLog(@"当title为: %@ 时，选中状态为: %d",alternativeItem.title,alternativeItem.isSelected);
                    }
                    return;
                }
                
                NSString *title;
                NSMutableString *subtitles = [NSMutableString string];
                for (MMSelectedPath *path in subArray) {
                    MMItem *firstItem = combineItem.childrenNodes[path.firstPath];
                    MMItem *secondItem = combineItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                    title = firstItem.title;
                    [subtitles appendString:[NSString stringWithFormat:@"  %@",secondItem.title]];
                }
                NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
            }];
            
            break;}
        default:
            break;
    }
}

#pragma mark - Getter
- (NSArray *)mutableArray {
    if (_mutableArray == nil) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        //root 2
        MMSingleItem *rootItem2 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"需求类型"];
        
        if (self.isMultiSelection)
            rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
        
        [rootItem2  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"排序" subtitleName:nil code:nil]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"智能排序"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"离我最近"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"好评优先"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"人气最高"]]];
        
        
        //root 3
        MMMultiItem *rootItem3 = [MMMultiItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"意向区域"];
        
        rootItem3.displayType = MMPopupViewDisplayTypeMultilayer;
        for (int i = 0; i < 30; i++){
            MMItem *item3_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"市%d",i] subtitleName:nil];
            item3_A.isSelected = (i == 0);
            [rootItem3 addNode:item3_A];
            for (int j = 0; j < random()%30; j ++) {
                MMItem *item3_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"市%d县%d",i,j] subtitleName:[NSString stringWithFormat:@"%ld",random()%10000]];
                item3_B.isSelected = (i == 0 && j == 0);
                [item3_A addNode:item3_B];
            }
        }
        
        //root 4
        MMCombinationItem *rootItem4 = [MMCombinationItem itemWithItemType:MMPopupViewDisplayTypeUnselected isSelected:NO titleName:@"意向度" subtitleName:nil];
        rootItem4.displayType = MMPopupViewDisplayTypeFilters;

        
        MMCombinationItem *rootItem5 = [MMCombinationItem itemWithItemType:MMPopupViewDisplayTypeUnselected isSelected:NO titleName:@"紧迫度" subtitleName:nil];
        
        rootItem5.displayType = MMPopupViewDisplayTypeNormal;

        [mutableArray addObject:rootItem2];
        [mutableArray addObject:rootItem3];
        [mutableArray addObject:rootItem4];
        [mutableArray addObject:rootItem5];
        _mutableArray  = [mutableArray copy];
    }
    return _mutableArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"CustomerTableCell";
    CustomerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[CustomerTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CustomerTableModel *model = [[CustomerTableModel alloc] init];
    
    model.name = @"金三";
    model.price = @"80-100万";
    model.type = @"三室一厅一卫";
    model.area = @"郫都区-德源大道";
    model.matchRate = @"30";
    model.phone = @"15983804766";
    model.intention = @"23";
    model.urgent = @"43";
    
    cell.model = model;
    
    return cell;
}



- (void)initUI{
    
    self.titleLabel.text = @"客源";
    self.navBackgroundView.hidden = NO;
    
    _comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + SIZE, SCREEN_Width, 40 *SIZE)];
    _comBoBoxView.dataSource = self;
    _comBoBoxView.delegate = self;
    [self.view addSubview:_comBoBoxView];
    [_comBoBoxView reload];
    
    _customerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 43 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 43 *SIZE) style:UITableViewStylePlain];
    _customerTable.backgroundColor = YJBackColor;
    _customerTable.delegate = self;
    _customerTable.dataSource = self;
    _customerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_customerTable];
}

@end
