//
//  UserModelArchiver.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "UserModelArchiver.h"

@implementation UserModelArchiver

+ (UserModel *)unarchive {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
}

+ (void)archive {
    
    BOOL flag = [NSKeyedArchiver archiveRootObject:[UserModel defaultModel] toFile:[self archivePath]];
    if (!flag) {
        NSLog(@"归档失败!");
    }
}

+ (NSString *)archivePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *basePath = paths.firstObject;
    
    return [basePath stringByAppendingPathComponent:@"UserModel.dat"];
    
}

@end
