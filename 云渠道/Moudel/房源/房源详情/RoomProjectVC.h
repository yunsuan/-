//
//  RoomProjectVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
@class RoomProjectVC;
typedef void (^UserInterfaceBlook)(BOOL ismapview);
@interface RoomProjectVC : BaseViewController
@property (nonatomic , copy) UserInterfaceBlook userinterfaceblook;

- (instancetype)initWithProjectId:(NSString *)projectId;

@end
