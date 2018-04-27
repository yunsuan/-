//
//  DistributVC.m
//  云渠道
//
//  Created by xiaoq on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DistributVC.h"
#import "HousedistributVC.h"

@interface DistributVC ()
{
    NSArray *_dylist;
}
@property (nonatomic , strong) UIImageView *backimg;
@property (nonatomic , strong) UIButton *leftbutton;
@property (nonatomic , strong) UIButton *openbtn;
@property (nonatomic , strong) UIView * drawerview;
@property (nonatomic , strong) UIButton *closebtn;
@property (nonatomic , strong) UIScrollView *choosebuildingview;

-(void)initUI;
-(void)initDataSouce;

@end

@implementation DistributVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBackgroundView.hidden = NO;
    [self initDataSouce];
    [self initUI];
    [self post];
    
}
-(void)post{
    [BaseRequest GET:GetBuilding_URL parameters:@{
                                                  @"project_id":_projiect_id
                                                  
                                                  }
             success:^(id resposeObject) {
                 NSLog(@"%@",resposeObject);
                 
                 if ([resposeObject[@"code"] integerValue] ==200) {
                     _dylist = resposeObject[@"data"][@"rows"];
                     [self setItemforchoosebuildingviewbyarr:_dylist];
                 }
                                                  }
             failure:^(NSError *error) {
                 
             }];
}

-(void)initUI
{
    [self.view addSubview:self.backimg];
    [self.view addSubview:self.leftbutton];
    [self.view addSubview:self.openbtn];
    [self.view addSubview:self.drawerview];
    [self.drawerview addSubview:self.closebtn];
    [self.drawerview addSubview:self.choosebuildingview];
    UISwipeGestureRecognizer * right=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(action_close)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:right];
    
    UISwipeGestureRecognizer * left=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(action_open)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:left];
 
}

-(void)initDataSouce
{
  
}

-(void)action_buildingchoose:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
    NSArray *arr=_dylist[sender.tag-1000][@"DYLIST"];
    if (arr.count>0) {
        
    }
    else{
    HousedistributVC *next_vc = [[HousedistributVC alloc]init];
    [self.navigationController pushViewController:next_vc animated:YES];
    }
    
}

-(void)action_open
{
    [UIView animateWithDuration:0.4 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:1 // 类似弹簧振动效果 0~1
          initialSpringVelocity:1 // 初始速度
                        options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                     animations:^{
                         
                         _openbtn.alpha = 0;
                         _drawerview.frame = CGRectMake(247*SIZE, 0, 113*SIZE, SCREEN_Height);
                         
                     } completion:^(BOOL finished) {
                         // 动画完成后执行
                         // code...
                         
                     }];
}

-(void)action_close
{
    [UIView animateWithDuration:0.4 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:1 // 类似弹簧振动效果 0~1
          initialSpringVelocity:1 // 初始速度
                        options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                     animations:^{
                         _openbtn.alpha = 1;
                         _drawerview.frame = CGRectMake(360*SIZE, 0, 113*SIZE, SCREEN_Height);
                     } completion:^(BOOL finished) {
                         // 动画完成后执行
                         // code...
                         
                     }];
}

-(void)action_back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIImageView *)backimg
{
    if (!_backimg) {
        _backimg = [[UIImageView alloc]init];
        _backimg.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height);
        [_backimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_Net,_img_name]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                [UIImage imageNamed:@""];
            }
        }];
    }
    return _backimg;
}

- (UIButton *)leftbutton {
    if (!_leftbutton) {
        _leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftbutton.center = CGPointMake(25 * SIZE, 20 + 22);
        _leftbutton.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
        _leftbutton.center = CGPointMake(25 * sIZE, STATUS_BAR_HEIGHT+20);
        _leftbutton.bounds = CGRectMake(0, 0, 80 * sIZE, 33 * sIZE);
        [_leftbutton setImage:IMAGE_WITH_NAME(@"leftarrow_white.png") forState:UIControlStateNormal];
        [_leftbutton addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftbutton;
}

-(UIButton *)openbtn
{
    if (!_openbtn) {
        _openbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _openbtn.frame  = CGRectMake(304*SIZE, 303*SIZE, 56*SIZE, 33*SIZE);
        [_openbtn setImage:[UIImage imageNamed:@"an"] forState:UIControlStateNormal];
        [_openbtn addTarget:self action:@selector(action_open) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openbtn;
}
-(UIView *)drawerview
{
    if (!_drawerview) {
        _drawerview = [[UIView alloc]initWithFrame:CGRectMake(360*SIZE, 0, 113*SIZE, SCREEN_Height)];
        _drawerview.backgroundColor =[UIColor clearColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 113*SIZE, SCREEN_Height)];
        view.backgroundColor = COLOR(0, 0, 0, 0.5);
        [_drawerview addSubview:view];
    }
    return _drawerview;
}

-(UIButton *)closebtn
{
    if (!_closebtn) {
        _closebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closebtn.frame = CGRectMake(13*SIZE, 314*SIZE, 9*SIZE, 15*SIZE);
        [_closebtn addTarget:self action:@selector(action_close) forControlEvents:UIControlEventTouchUpInside];
        [_closebtn setImage:[UIImage imageNamed:@"rightarrow_white"] forState:UIControlStateNormal];
    }
    return _closebtn;
}

-(UIScrollView *)choosebuildingview
{
    if (!_choosebuildingview) {
        _choosebuildingview = [[UIScrollView alloc]initWithFrame:CGRectMake(36*SIZE, 100*SIZE, 67*SIZE, SCREEN_Height-110*SIZE)];
        _choosebuildingview.backgroundColor = [UIColor clearColor];
    }
    return _choosebuildingview;
}

-(void)setItemforchoosebuildingviewbyarr:(NSArray *)arr
{
    _choosebuildingview.contentSize = CGSizeMake(67*SIZE, 35*SIZE+57*SIZE*arr.count);
    for (int i= 0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = COLOR(240, 240, 240, 1);
        btn.frame = CGRectMake(0, i*57*SIZE, 67*SIZE, 33*SIZE);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 2*SIZE;
        [btn setTitle:arr[i][@"LDMC"] forState:UIControlStateNormal];
        [btn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13*SIZE];
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(action_buildingchoose:) forControlEvents:UIControlEventTouchUpInside];
        [_choosebuildingview addSubview:btn];
    }
}

@end
