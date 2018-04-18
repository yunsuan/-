//
//  RoomDetailVC1.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailVC1.h"
#import "RoomAnalyzeVC.h"
#import "RoomBrokerageVC.h"

@interface RoomDetailVC1 ()<UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) RoomProjectVC *roomProjectVC;

@property (nonatomic, strong) RoomAnalyzeVC *roomAnalyzeVC;

@property (nonatomic, strong) RoomBrokerageVC *roomBrokerageVC;

@end

@implementation RoomDetailVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)segmentedControlAction:(UISegmentedControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * self.scrollView.frame.size.width, 0) animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger n = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.segmentedControl.selectedSegmentIndex = n;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
//    self.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"first", @"second"]];
    self.navigationItem.titleView = self.segmentedControl;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = 0;
//    self.segmentedControl.frame = cgrectma
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    
    // 创建控制器
    _roomProjectVC = [RoomProjectVC new];
    _roomBrokerageVC = [[RoomBrokerageVC alloc] init];
    // 添加为self的子控制器
    [self addChildViewController:_roomProjectVC];
    [self addChildViewController:_roomBrokerageVC];
    _roomProjectVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _roomBrokerageVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:_roomProjectVC.view];
    [self.scrollView addSubview:_roomBrokerageVC.view];
    
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}


@end
