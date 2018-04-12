//
//  UserModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic , strong) NSString *Token;
@property (nonatomic , strong) NSString *Account;
@property (nonatomic , strong) NSString *Password;
@property (nonatomic , strong) NSDictionary *Configdic;

+ (UserModel *)defaultModel;

@end
