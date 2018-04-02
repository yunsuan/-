//
//  DateChooseView.h
//  云渠道
//
//  Created by xiaoq on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
<<<<<<< HEAD
@class DateChooseView;
typedef void(^dateblock)(NSDate * date);
@interface DateChooseView : UIView
@property(nonatomic, copy) dateblock dateblock;
=======

@class DateChooseView;

typedef void (^timeBlock)(NSDate *date);

@interface DateChooseView : UIView

@property (nonatomic, copy) timeBlock timeBlock;

@property (nonatomic, strong) UIDatePicker *dataPicker;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

>>>>>>> f2d235867233a0d11eb8d9530a8a9bcd47906949
@end
