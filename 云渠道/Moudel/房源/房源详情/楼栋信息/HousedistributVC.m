//
//  HousedistributVC.m
//  云渠道
//
//  Created by xiaoq on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "HousedistributVC.h"
#import "SMScrollView.h"
#import "KyoCenterLineView.h"
#import "KyoRowIndexView.h"

#define kRowIndexWith   30
#define kRowIndexSpace  2.0
#define kRowIndexViewDefaultColor   [UIColor clearColor]
#define kCenterLineViewTail 6.0
#define KweixuanColor COLOR(0xc4, 0xc4, 0xc4, 1)
#define KyidingColor COLOR(0xdf, 0xb0, 0x45, 1)
#define KyishouColor COLOR(0xef, 0x5e, 0x52, 1)


@interface HousedistributVC ()<SMCinameSeatScrollViewDelegate,UIScrollViewDelegate>

@property (nonatomic , strong)NSMutableArray *datasouce;
@property (nonatomic , strong)NSDictionary *fjxx;

@property (nonatomic, assign)  NSUInteger row;
@property (nonatomic, assign)  NSUInteger column;
@property (nonatomic, assign)  CGSize seatSize;
@property (assign, nonatomic)  CGFloat seatTop;
@property (assign, nonatomic)  CGFloat seatLeft;
@property (assign, nonatomic)  CGFloat seatBottom;
@property (assign, nonatomic)  CGFloat seatRight;
@property (strong, nonatomic)  UIImage *imgSeatNormal;
@property (strong, nonatomic)  UIImage *imgSeatHadBuy;
@property (strong, nonatomic)  UIImage *imgSeatSelected;
@property (strong, nonatomic)  UIImage *imgSeatUnexist;
@property (strong, nonatomic)  UIImage *imgSeatLoversLeftNormal;
@property (strong, nonatomic)  UIImage *imgSeatLoversLeftHadBuy;
@property (strong, nonatomic)  UIImage *imgSeatLoversLeftSelected;
@property (strong, nonatomic)  UIImage *imgSeatLoversRightNormal;
@property (strong, nonatomic)  UIImage *imgSeatLoversRightHadBuy;
@property (strong, nonatomic)  UIImage *imgSeatLoversRightSelected;

@property (assign, nonatomic)  BOOL showCenterLine;
@property (assign, nonatomic)  BOOL showRowIndex;
@property (assign, nonatomic)  BOOL rowIndexStick;  /**< 是否让showIndexView粘着左边 */
@property (strong, nonatomic)  UIColor *rowIndexViewColor;
@property (assign, nonatomic)  NSInteger rowIndexType; //座位左边行号提示样式
@property (strong, nonatomic)  NSArray *arrayRowIndex; //座位号左边行号提示（用它则忽略

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) KyoRowIndexView *rowIndexView;
@property (strong, nonatomic) KyoCenterLineView *centerLineView;

@property (strong, nonatomic) NSMutableDictionary *dictSeat;

@property (retain, nonatomic) SMScrollView *myScrollView;
@property (strong, nonatomic) NSMutableDictionary *dictSeatState;

@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)UIImageView *img;
@property ( nonatomic , strong )UIView *maskView;
@property ( nonatomic , strong )UIView *tanchuanView;
@property (nonatomic , strong)UIImageView *guanbi;


-(void)initDataSouce;
-(void)initInterFace;

@end

@implementation HousedistributVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(243, 243, 243, 1);
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"房源";
    [self.leftButton setImage:IMAGE_WITH_NAME(@"youjiantou.png") forState:UIControlStateNormal];
    [self.maskButton addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:self.MycollectionView];
    
    [self post];
    
    
}

-(void)initDataSouce
{
    
}

-(void)post{
    
//

//
    
}





-(void)initInterFace
{
    NSArray *arr = @[@"未售",@"已定",@"已售"];
    
    
    for (int i = 0 ; i<3; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(176*SIZE+i*65*SIZE, 64+9*SIZE, 17*SIZE, 17*SIZE)];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 2*SIZE;
        if (i == 0) {
            view.backgroundColor = KweixuanColor;
        }
        else if(i == 1)
        {
            view.backgroundColor = KyidingColor;
        }
        else
        {
            view.backgroundColor = KyishouColor;
        }
        [self.view addSubview:view];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(200*SIZE+i*65*SIZE, 64, 28*SIZE, 34*SIZE)];
        lab.font = [UIFont systemFontOfSize:13*SIZE];
        lab.text = arr[i];
        lab.textColor = COLOR(115, 115, 115, 1);
        [self.view addSubview:lab];
    }
    [self.view addSubview:self.name];
    [self.view addSubview:self.img];
    _row = _datasouce.count;
    _column = 0;
    for (int i = 0; i<_row; i++) {
        
        if ([_datasouce[i][@"LIST"] count]>_column) {
            _column = [_datasouce[i][@"LIST"] count];
        }
    }
    
    _seatSize = CGSizeMake(79*SIZE, 34*SIZE);
    _seatTop = 20;
    _seatLeft = 30;
    _seatBottom = 20;
    _seatRight = 20;
    _myScrollView.zoomScale = 1.0;
    
    _imgSeatNormal = [UIImage imageNamed:@""];
    _imgSeatHadBuy = [UIImage imageNamed:@""];
    _imgSeatSelected = [UIImage imageNamed:@""];
    
    _showCenterLine = YES;
    _showRowIndex = YES;
    _rowIndexStick = YES;
    
    self.dictSeatState = [NSMutableDictionary dictionary];
    for (NSInteger row = 0; row < self.row; row++) {
        NSMutableArray *arrayState = [NSMutableArray array];
        for (NSInteger column = 0; column < self.column; column++) {
            
            [arrayState addObject:@(KyoCinameSeatStateNormal)];
            //            if (row * column % 5 == 0) {
            //                [arrayState addObject:@(KyoCinameSeatStateHadBuy)];
            //            } else if (row * column % 5 == 0) {
            //                [arrayState addObject:@(KyoCinameSeatStateUnexist)];
            //            } else {
            //                [arrayState addObject:@(KyoCinameSeatStateNormal)];
            //            }
        }
        [self.dictSeatState setObject:arrayState forKey:@(row)];
    }
    
    self.myScrollView = [[SMScrollView alloc] init];
    _myScrollView.contentSize = CGSizeMake((self.seatLeft + self.column * self.seatSize.width + self.seatRight) * _myScrollView.zoomScale,(self.seatTop + self.row * self.seatSize.height + self.seatBottom) * _myScrollView.zoomScale);
    
    NSLog(@"_myScrollView.contentSize = %@",NSStringFromCGRect(_myScrollView.frame));
    NSLog(@"_myScrollView.zoomScale = %f",_myScrollView.zoomScale);
    if (!self.contentView) {
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    _contentView.frame = CGRectMake(0, 0, _myScrollView.contentSize.width, _myScrollView.contentSize.height);
    
    _contentView.contentMode = UIViewContentModeScaleAspectFill;
    _contentView.clipsToBounds = YES;
    _SMCinameSeatScrollViewDelegate = self;
    
    self.myScrollView = [[SMScrollView alloc] initWithFrame:CGRectMake(0, 64+30*SIZE, 360*SIZE, SCREEN_Height-64-30*SIZE)];
    self.myScrollView.maximumZoomScale = 2;
    self.myScrollView.delegate = self;
    self.myScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.myScrollView.contentSize = _contentView.frame.size;
    self.myScrollView.alwaysBounceVertical = YES;
    self.myScrollView.alwaysBounceHorizontal = YES;
    self.myScrollView.stickToBounds = YES;
    [self.myScrollView addViewForZooming:_contentView];
    [self.myScrollView scaleToFit];
    self.myScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myScrollView];
    
    self.myScrollView.contentSize = CGSizeMake((self.seatLeft + self.column * self.seatSize.width + self.seatRight) * _myScrollView.zoomScale,(self.seatTop + self.row * self.seatSize.height + self.seatBottom) * _myScrollView.zoomScale);
    
    
    //画座位
    [self drawSeat];
    
    UIImageView *seatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 50, 50)];
    seatImageView.image = [UIImage imageNamed:@"selectSeat"];
    [_contentView addSubview:seatImageView];
    [_contentView bringSubviewToFront:seatImageView];
    
    //画座位行数提示
    if (!self.rowIndexView) {
        self.rowIndexView = [[KyoRowIndexView alloc] init];
        self.rowIndexView.arrayRowIndex = [NSMutableArray array];
        for (int i = 0; i<_datasouce.count; i++) {
            [self.rowIndexView.arrayRowIndex addObject:[NSString stringWithFormat:@"F%@",_datasouce[i][@"FLOORNUM"]]];
        }
        //        [self.rowIndexView dr]
        [self.rowIndexView drawRect:self.rowIndexView.frame];
        self.rowIndexView.backgroundColor = self.rowIndexViewColor ? : kRowIndexViewDefaultColor;
        [_contentView addSubview:self.rowIndexView];
        
        //[_myScrollView addSubview:self.rowIndexView];
    }
    if (self.showRowIndex) {
        [_contentView bringSubviewToFront:self.rowIndexView];
        [_myScrollView bringSubviewToFront:self.rowIndexView];
        self.rowIndexView.row = self.row;
        self.rowIndexView.width = kRowIndexWith;
        self.rowIndexView.rowIndexViewColor = self.rowIndexViewColor;
        
        self.rowIndexView.frame = CGRectMake((kRowIndexSpace + (self.rowIndexStick ? _myScrollView.contentOffset.x : 0)) / _myScrollView.zoomScale, self.seatTop, kRowIndexWith, self.row * self.seatSize.height);
        
        NSLog(@"self.rowIndexView.frame = %@",NSStringFromCGRect(self.rowIndexView.frame));
        self.rowIndexView.rowIndexType = self.rowIndexType;
        //        self.rowIndexView.arrayRowIndex = self.arrayRowIndex;
        self.rowIndexView.hidden = NO;
    } else {
        self.rowIndexView.hidden = YES;
    }
    
    //画中线
    if (!self.centerLineView) {
        self.centerLineView = [[KyoCenterLineView alloc] init];
        self.centerLineView.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:self.centerLineView];
    }
    if (self.showCenterLine) {
        [self.contentView bringSubviewToFront:self.centerLineView];
        if (self.showRowIndex) {
            self.centerLineView.frame = CGRectMake((self.seatLeft + self.column * self.seatSize.width + self.seatRight) / 2 + kRowIndexSpace * 2, self.seatTop - kCenterLineViewTail, 1, self.row * self.seatSize.height + kCenterLineViewTail * 2);
        } else {
            self.centerLineView.frame = CGRectMake((self.seatLeft + self.column * self.seatSize.width + self.seatRight) / 2, self.seatTop - kCenterLineViewTail, 1, self.row * self.seatSize.height + kCenterLineViewTail * 2);
        }
        
        if (self.row > 0 && self.column > 0) {
            self.centerLineView.hidden = NO;
        } else {
            self.centerLineView.hidden = YES;
        }
    } else {
        self.centerLineView.hidden = YES;
    }
    
    self.centerLineView.hidden = YES;
}

- (void)drawSeat{
    if (!self.dictSeat){
        self.dictSeat = [NSMutableDictionary dictionary];
    }
    
    CGFloat x = self.seatLeft + (self.showRowIndex ? kRowIndexSpace * 2 : 0);
    CGFloat y = self.seatTop;
    
    for (NSInteger row = 0; row < self.row; row++) {
        
        NSMutableArray *arraySeat = self.dictSeat[@(row)] ? : [NSMutableArray array];
        
        for (NSInteger column = 0; column < [_datasouce[row][@"LIST"] count]; column++) {
            
            UIButton *btnSeat = nil;
            if (arraySeat.count <= column) {
                btnSeat = [UIButton buttonWithType:UIButtonTypeCustom];
                btnSeat.tag = row;  //tag纪录行数
                [btnSeat setTitle:_datasouce[row][@"LIST"][column][@"FJMC"] forState:UIControlStateNormal];
                btnSeat.titleLabel.font =[UIFont systemFontOfSize:10];
                [btnSeat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                //                btnSeat.layer.masksToBounds = YES;
                //                btnSeat.layer.cornerRadius = 2;
                if ([_datasouce[row][@"LIST"][column][@"FJZT"] integerValue] ==0 ||[_datasouce[row][@"LIST"][column][@"FJZT"] integerValue] ==1)
                {
                    btnSeat.backgroundColor = KweixuanColor;
                    
                }
                else if ([_datasouce[row][@"LIST"][column][@"FJZT"] integerValue] ==4)
                {
                    btnSeat.backgroundColor = KyishouColor;
                    btnSeat.userInteractionEnabled = NO;
                }
                else
                {
                    btnSeat.backgroundColor = KyidingColor;
                    btnSeat.userInteractionEnabled = NO;
                }
                
                //                btnSeat.backgroundColor = [UIColor grayColor];
                [btnSeat addTarget:self action:@selector(btnSeatTouchIn:) forControlEvents:UIControlEventTouchUpInside];
                [_contentView addSubview:btnSeat];
                [arraySeat addObject:btnSeat];
            } else {
                btnSeat = arraySeat[column];
            }
            
            btnSeat.frame = CGRectMake(x+1, y+0.5, self.seatSize.width-2, self.seatSize.height-1);
            if (self.SMCinameSeatScrollViewDelegate &&
                [self.SMCinameSeatScrollViewDelegate respondsToSelector:@selector(kyoCinameSeatScrollViewSeatStateWithRow:withColumn:)]) {
                
                KyoCinameSeatState state = [self.SMCinameSeatScrollViewDelegate kyoCinameSeatScrollViewSeatStateWithRow:row withColumn:column];
                
//                [btnSeat setImage:[self getSeatImageWithState:state] forState:UIControlStateNormal];
            } else {
                [btnSeat setImage:self.imgSeatNormal forState:UIControlStateNormal];
            }
            
            x += self.seatSize.width;
        }
        
        y += self.seatSize.height;
        x = self.seatLeft + (self.showRowIndex ? kRowIndexSpace * 2 : 0);
        
        [self.dictSeat setObject:arraySeat forKey:@(row)];
}
}

    


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.myScrollView.viewForZooming;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

#pragma mark --------------------
#pragma mark - KyoCinameSeatScrollViewDelegate

//座位状态
- (KyoCinameSeatState)kyoCinameSeatScrollViewSeatStateWithRow:(NSUInteger)row withColumn:(NSUInteger)column {
    NSMutableArray *arraySeat = self.dictSeatState[@(row)];
    return (KyoCinameSeatState)[arraySeat[column] integerValue];
}

//点击座位
- (void)kyoCinameSeatScrollViewDidTouchInSeatWithRow:(NSUInteger)row withColumn:(NSUInteger)column {
    
    NSMutableArray *arraySeat = self.dictSeatState[@(row)];
    KyoCinameSeatState currentState = (KyoCinameSeatState)[arraySeat[column] integerValue];
    if (currentState == KyoCinameSeatStateNormal) {
        [arraySeat replaceObjectAtIndex:column withObject:@(KyoCinameSeatStateSelected)];
    } else if (currentState == KyoCinameSeatStateSelected) {
        [arraySeat replaceObjectAtIndex:column withObject:@(KyoCinameSeatStateNormal)];
    } else if (currentState == KyoCinameSeatStateHadBuy || currentState == KyoCinameSeatStateUnexist) {
        return;
    }
    //
    
    
    _fjxx = _datasouce[row][@"LIST"][column];
    if ([self.statusStr isEqualToString:@"0"]||[self.statusStr isEqualToString:@"1"]) {
        NSMutableDictionary * tempDic = [NSMutableDictionary dictionary];
        tempDic = (NSMutableDictionary *)_fjxx;
        [tempDic setObject:_LDinfo[0] forKey:@"ldid"];
        [tempDic setObject:_LDinfo[1] forKey:@"dyid"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"XZFW" object:@"123" userInfo:tempDic];
        
      
    }
    
}



#pragma mark --------------------
#pragma mark - Methods

-(UIColor *)getSeatColorWithState:(KyoCinameSeatState)state {

     if (state ==  KyoCinameSeatStateHadBuy)
        return [UIColor redColor];
    else
        return [UIColor redColor];
}

//根据座位类型返回实际图片
- (UIImage *)getSeatImageWithState:(KyoCinameSeatState)state {
    if (state == KyoCinameSeatStateHadBuy) {
        return self.imgSeatHadBuy;
    } else if (state == KyoCinameSeatStateNormal) {
        return self.imgSeatNormal;
    } else if (state == KyoCinameSeatStateSelected) {
        return self.imgSeatSelected;
    } else if (state == KyoCinameSeatStateUnexist) {
        return self.imgSeatUnexist;
    } else if (state == KyoCinameSeatStateLoversLeftNormal) {
        return self.imgSeatLoversLeftNormal;
    } else if (state == KyoCinameSeatStateLoversLeftHadBuy) {
        return self.imgSeatLoversLeftHadBuy;
    } else if (state == KyoCinameSeatStateLoversLeftSelected) {
        return self.imgSeatLoversLeftSelected;
    } else if (state == KyoCinameSeatStateLoversRightNormal) {
        return self.imgSeatLoversRightNormal;
    } else if (state == KyoCinameSeatStateLoversRightHadBuy) {
        return self.imgSeatLoversRightHadBuy;
    } else if (state == KyoCinameSeatStateLoversRightSelected) {
        return self.imgSeatLoversRightSelected;
    } else {
        return self.imgSeatNormal;
    }
}

- (void)setNeedsDisplay {
    //[super setNeedsDisplay];

    if (self.rowIndexView) {
        [self.rowIndexView setNeedsDisplay];
    }

    if (self.centerLineView) {
        [self.centerLineView setNeedsDisplay];
    }
}

#pragma mark --------------------
#pragma mark - Events
//- (void)btnSeatTouchIn:(UIButton *)btn {
//    NSArray *arraySeat = self.dictSeat[@(btn.tag)];
//    NSUInteger columns = [arraySeat indexOfObject:btn];
//    NetConfitModel *model=[[NetConfitModel alloc]init];
//    [BaseNetRequest startpost:@"/TelService.ashx" parameters:[model configFJZTWithFJID:_datasouce[btn.tag][@"LIST"][columns][@"FJID"]] success:^(id resposeObject) {
//
//        NSInteger state = [resposeObject[0][@"content"][0][@"state"] integerValue];
//        if (state == 0 ||state ==1) {
//            NSLog(@"btnSeatTouchIn-btn.tag=%ld",(long)btn.tag);
//            if (self.SMCinameSeatScrollViewDelegate &&
//                [self.SMCinameSeatScrollViewDelegate respondsToSelector:@selector(kyoCinameSeatScrollViewDidTouchInSeatWithRow:withColumn:)]) {
//
//                NSArray *arraySeat = self.dictSeat[@(btn.tag)];
//                NSUInteger column = [arraySeat indexOfObject:btn];
//
//
//                [self.SMCinameSeatScrollViewDelegate kyoCinameSeatScrollViewDidTouchInSeatWithRow:btn.tag withColumn:column];
//
//                [self drawSeat];
//                [self setNeedsDisplay];
//            }
//
//        }
////        else if (state == 4)
////        {
////            [self alertControllerWithNsstring:@"温馨提示" And:@"房屋状态已改变"];
////            btn.backgroundColor = KyishouColor;
////            btn.userInteractionEnabled = NO;
////        }
////        else
////        {
////            [self alertControllerWithNsstring:@"温馨提示" And:@"房屋状态已改变"];
////            btn.backgroundColor =KyidingColor;
////            btn.userInteractionEnabled = NO;
////        }
////
////
////
////
////
////
////
////
////    } failure:^(NSError *error) {
////        NSLog(@"%@",error);
////
////    }];
////
////
////}
//
//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //画座位行数提示
    if (!self.rowIndexView) {
        self.rowIndexView = [[KyoRowIndexView alloc] init];
        self.rowIndexView.backgroundColor = self.rowIndexViewColor ? : kRowIndexViewDefaultColor;
        [_myScrollView addSubview:self.rowIndexView];
    }
    if (self.showRowIndex) {
        [_contentView bringSubviewToFront:self.rowIndexView];
        [_myScrollView bringSubviewToFront:self.rowIndexView];
        self.rowIndexView.row = self.row;
        self.rowIndexView.width = kRowIndexWith;
        self.rowIndexView.rowIndexViewColor = self.rowIndexViewColor;

        self.rowIndexView.frame = CGRectMake((kRowIndexSpace + (self.rowIndexStick ? _myScrollView.contentOffset.x : 0)) < 2 ? 2:(kRowIndexSpace + (self.rowIndexStick ? _myScrollView.contentOffset.x : 0)) / _myScrollView.zoomScale, self.seatTop,
                                             kRowIndexWith,
                                             self.row * self.seatSize.height);

        NSLog(@"self.rowIndexView.frame = %@",NSStringFromCGRect(self.rowIndexView.frame));
        NSLog(@"self.myScrollView.contentSize = %@",NSStringFromCGSize( _myScrollView.contentSize));

        self.rowIndexView.rowIndexType = self.rowIndexType;
        self.rowIndexView.arrayRowIndex = self.arrayRowIndex;
        self.rowIndexView.hidden = NO;
    } else {
        self.rowIndexView.hidden = YES;
    }
}


- (void)action_back {
    [self.navigationController popViewControllerAnimated:YES];
}

-(UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.frame = CGRectMake(34*SIZE, 64, 200*SIZE, 34*SIZE);
        _name.font = [UIFont systemFontOfSize:14*SIZE];
        _name.textColor = COLOR(115, 115, 115, 1);
        _name.text = [NSString stringWithFormat:@"%@-%@%@",_myarr[0] ,_myarr[1] ,_myarr[2]];
    }
    return _name;
}

-(UIImageView *)img
{
    if (!_img ) {
        _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fangwu"]];
        _img.frame = CGRectMake(15*SIZE, 64+10*SIZE, 15*SIZE, 13*SIZE);
    }
    return _img;
}

-(UIImageView *)guanbi
{
    if (!_guanbi) {
        _guanbi = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guanbi"]];
        _guanbi.frame = CGRectMake(250*SIZE, 26*SIZE, 30*SIZE, 54*SIZE);
        //        _guanbi.userInteractionEnabled = YES;
    }
    return _guanbi;
}

//-(UIView *)tanchuanView
//{
//    if (!_tanchuanView) {
//        _tanchuanView = [[UIView alloc]initWithFrame:CGRectMake(46*SIZE, 80*SIZE, 268*SIZE, SCREEN_Height-80*SIZE-14*SIZE)];
//        _tanchuanView.backgroundColor = [UIColor whiteColor];
//        _tanchuanView.layer.masksToBounds = YES;
//        _tanchuanView.layer.cornerRadius = 2*SIZE;
//
//        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 268*SIZE, 25*SIZE)];
//        lab.textColor = COLOR(85, 85, 85, 1);
//        lab.text = [InfoCenterArchiver unarchive].XMMC;
//        lab.textAlignment = NSTextAlignmentCenter;
//        //        lab.font = [UIFont systemFontOfSize:20*SIZE];
//        lab.font = [UIFont boldSystemFontOfSize:20*SIZE];
//        [_tanchuanView addSubview:lab];
//
//        //        UIView *lane3 = [[UIView alloc]initWithFrame:CGRectMake(0, 23*SIZE, 268*SIZE, 2*SIZE)];
//        //        lane3.backgroundColor = COLOR(243, 243, 243, 1);
//        //        [_tanchuanView addSubview:lane3];
//
//
//
//        UIView * view2  =  [[UIView alloc]initWithFrame:CGRectMake(0, 25*SIZE, 268*SIZE, SCREEN_Height-61*SIZE-14*SIZE-85*SIZE)];
//        view2.backgroundColor =[UIColor whiteColor];
//        [_tanchuanView addSubview:view2];
//
//        NSArray *arr1 = @[@"房  号",@"价  格",@"物  业"];
//        NSArray *arr2 = @[_fjxx[@"FJMC"],_fjxx[@"FJZJ"],_fjxx[@"WYMC"]];
//        NSArray *arr3 = @[@[@"楼  栋：",@"单  元：",@"楼  层："],@[@"计价规则：",@"单  价：",@"总  价："],@[@"建筑面积：",@"套内面积：",@"户型信息："]];
//        NSArray *arr4 = @[@[_fjxx[@"LDMC"],_fjxx[@"DYMC"],_fjxx[@"FLOORNUM"]],@[_fjxx[@"JJGZ"],_fjxx[@"JZDJ"],_fjxx[@"FJZJ"]],@[_fjxx[@"JZMJ"],_fjxx[@"TNMJ"],_fjxx[@"HXMC"]]];
//        for (int i = 0; i<3; i++) {
//            UILabel *lab1 = [[UILabel alloc]init];
//            [WJQTools setLableAttributeWithLable:lab1 fram:CGRectMake(10*SIZE, 10*SIZE+i*(SCREEN_Height-61*SIZE-14*SIZE-85*SIZE)/3, 70*SIZE, 15*SIZE) font:15*SIZE TextAlignment:NSTextAlignmentLeft];
//            lab1.text = arr1[i];
//            lab1.textColor = COLOR(85, 85, 85, 1);
//            [view2 addSubview:lab1];
//            UILabel *lab2 = [[UILabel alloc]init];
//            [WJQTools setLableAttributeWithLable:lab2 fram:CGRectMake(91*SIZE, 10*SIZE+i*(SCREEN_Height-61*SIZE-14*SIZE-85*SIZE)/3, 269*SIZE, 15*SIZE) font:15*SIZE TextAlignment:NSTextAlignmentLeft];
//            lab2.text = arr2[i];
//            lab2.textColor = COLOR(85, 85, 85, 1);
//            [view2 addSubview:lab2];
//            UIView *lane1 = [[UIView alloc]initWithFrame:CGRectMake(0, 32*SIZE+i*(SCREEN_Height-61*SIZE-14*SIZE-85*SIZE)/3, 81*SIZE, 2*SIZE)];
//            lane1.backgroundColor = COLOR(18, 183, 245, 1);
//            [view2 addSubview:lane1];
//            UIView *lane2 = [[UIView alloc]initWithFrame:CGRectMake(0, 34*SIZE+i*(SCREEN_Height-61*SIZE-14*SIZE-85*SIZE)/3, 268*SIZE, 2*SIZE)];
//            lane2.backgroundColor = COLOR(243, 243, 243, 1);
//            [view2 addSubview:lane2];
//
//            for (int j = 0; j<3; j++) {
//                UILabel *lab1 = [[UILabel alloc]init];
//                [WJQTools setLableAttributeWithLable:lab1 fram:CGRectMake(10*SIZE, 55*SIZE+i*(SCREEN_Height-61*SIZE-14*SIZE-85*SIZE)/3+j*(SCREEN_Height-61*SIZE-14*SIZE-180*SIZE)/9, 75*SIZE, 14*SIZE) font:14*SIZE TextAlignment:NSTextAlignmentLeft];
//                lab1.text = arr3[i][j];
//                lab1.textColor = COLOR(85, 85, 85, 1);
//                [view2 addSubview:lab1];
//                UILabel *lab2 = [[UILabel alloc]init];
//                [WJQTools setLableAttributeWithLable:lab2 fram:CGRectMake(80*SIZE, 45*SIZE+i*(SCREEN_Height-61*SIZE-14*SIZE-85*SIZE)/3+j*(SCREEN_Height-61*SIZE-14*SIZE-180*SIZE)/9, 170*SIZE, 30*SIZE) font:14*SIZE TextAlignment:NSTextAlignmentLeft];
//                lab2.text = [NSString stringWithFormat:@"  %@",arr4[i][j]];
//                lab2.textColor = COLOR(115, 115, 115, 1);
//                lab2.layer.masksToBounds = YES;
//                lab2.layer.cornerRadius = 5*SIZE;
//                lab2.layer.borderColor  = COLOR (194,192,192,1).CGColor;
//                lab2.layer.borderWidth  = 1*SIZE;
//                [view2 addSubview:lab2];
//            }
//        }
//
//
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [WJQTools setButtonAttributeWithButton:btn Title:@"计价" TitleFont:20*SIZE ImageName:nil Tag:1 fram:CGRectMake(0, view2.frame.size.height+27*SIZE, 268*SIZE, _tanchuanView.frame.size.height- view2.frame.size.height-27*SIZE)];
//        btn.backgroundColor = COLOR(18, 183, 245, 1);
//        [btn addTarget:self action:@selector(action_jijia) forControlEvents:UIControlEventTouchUpInside];
//        [_tanchuanView addSubview:btn];
//        btn.hidden =YES;
//    }
//    return _tanchuanView;
//}
-(void)action_jijia //计价
{
//    CountmoneyViewController *next_vc = [[CountmoneyViewController alloc]init];
//    [self.navigationController pushViewController:next_vc animated:YES];
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTap)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (void)maskViewTap {
    [self.tanchuanView removeFromSuperview];
    [self.guanbi removeFromSuperview];
    self.tanchuanView = nil;
    [self.maskView removeFromSuperview];
}



@end
