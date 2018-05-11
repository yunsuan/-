//
//  WaitAnimation.m
//  云渠道
//
//  Created by xiaoq on 2018/5/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "WaitAnimation.h"
static UIImageView *_imageV ;

@interface WaitAnimation()

@end

@implementation WaitAnimation





+(void)startAnimation{
    if (!_imageV) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _imageV = [[UIImageView alloc]init];
            _imageV.center = CGPointMake(SCREEN_Width/2, SCREEN_Height/2);
            _imageV.bounds = CGRectMake(0, 0, 67, 43);
            NSMutableArray *imageArray = [NSMutableArray array];
            for (int i = 0; i < 7; i ++) {
                NSString *imageName = [NSString stringWithFormat:@"%d",i + 1];
                UIImage *image = [UIImage imageNamed:imageName];
                [imageArray addObject:image];
            }
            _imageV.animationImages = imageArray;
            //2.2图片播放一次所需时长
            _imageV.animationDuration = 0.5f;
            //2.3图片播放次数,0表示无限
            _imageV.animationRepeatCount = 0;
        });
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:_imageV];
    [_imageV startAnimating];
    
}

+(void)stopAnimation
{
    [_imageV stopAnimating];
    [_imageV removeFromSuperview];
  
}




@end
