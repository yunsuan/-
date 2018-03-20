//
//  UserModelArchiver.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModelArchiver : NSObject

+ (UserModel *)unarchive; //解码
+ (void)archive; //归档

@end
