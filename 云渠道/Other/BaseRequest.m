//
//  BaseRequest.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure{
//        [SVProgressHUD show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    [manager.requestSerializer setValue:[UserModelArchiver unarchive].Token forHTTPHeaderField:@"ACCESS-TOKEN"];
    [manager.requestSerializer setValue:ACCESSROLE forHTTPHeaderField:@"ACCESS-ROLE"];
    NSString *str = [NSString stringWithFormat:@"%@%@",Base_Net,url];
    
    [manager GET:str parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        [SVProgressHUD dismiss];
       
        if (success) {
            NSArray * arr = [url componentsSeparatedByString:@"/"];
            if ([arr[0] isEqualToString:@"agent"]&&![arr[1] isEqualToString:@"user"]) {
                if ([[UserModel defaultModel].Token isEqualToString:@""]) {
                    [BaseRequest alertControllerWithNsstring:@"温馨提示" And:@"请先登录" WithCancelBlack:^{
                        
                    } WithDefaultBlack:^{
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
                        [UserModel defaultModel].Token = @"";
                        [UserModelArchiver archive];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
                        return ;
                    }];
                    
                }
                else if ([responseObject[@"code"] integerValue] == 401) {
                    
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
                    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.7f];
                    hud.label.text= @"账号在其他地点登录，请重新登录！";
                    hud.label.textColor = [UIColor whiteColor];
                    hud.margin = 10.f;
                    [hud setOffset:CGPointMake(0, 10.f*SIZE)];
                    //    hud.yOffset = 10.f * sIZE;
                    hud.removeFromSuperViewOnHide = YES;
                    //    [hud hide:YES afterDelay:1.5];
                    [hud hideAnimated:YES afterDelay:1.5];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
                        [UserModel defaultModel].Token = @"";
                        [UserModelArchiver archive];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
                        return ;
                    });
                    
                }
            }
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [SVProgressHUD dismiss];
        if (failure) {
            failure(error);
           
        }
    }];
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval = 6;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/javascript", @"application/json", nil];
    
    [manager.requestSerializer setValue:[UserModelArchiver unarchive].Token forHTTPHeaderField:@"ACCESS-TOKEN"];
    [manager.requestSerializer setValue:ACCESSROLE forHTTPHeaderField:@"ACCESS-ROLE"];
    NSString *str = [NSString stringWithFormat:@"%@%@",Base_Net,url];
    [manager POST:str parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSArray * arr = [url componentsSeparatedByString:@"/"];
            if ([arr[0] isEqualToString:@"agent"]&&![arr[1] isEqualToString:@"user"]) {
                if ([[UserModel defaultModel].Token isEqualToString:@""]) {
                    [BaseRequest alertControllerWithNsstring:@"温馨提示" And:@"请先登录" WithCancelBlack:^{
                        
                    } WithDefaultBlack:^{
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
                        [UserModel defaultModel].Token = @"";
                        [UserModelArchiver archive];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
                        return ;
                    }];
                    
                }
                else if ([responseObject[@"code"] integerValue] == 401) {
                    
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
                    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.7f];
                    hud.label.text= @"账号在其他地点登录，请重新登录！";
                    hud.label.textColor = [UIColor whiteColor];
                    hud.margin = 10.f;
                    [hud setOffset:CGPointMake(0, 10.f*SIZE)];
                    //    hud.yOffset = 10.f * sIZE;
                    hud.removeFromSuperViewOnHide = YES;
                    //    [hud hide:YES afterDelay:1.5];
                    [hud hideAnimated:YES afterDelay:1.5];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
                        [UserModel defaultModel].Token = @"";
                        [UserModelArchiver archive];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
                        return ;
                    });
                    
                }
                
            }
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)Updateimg:(NSString *)url parameters:(NSDictionary *)parameters constructionBody:(void (^)(id<AFMultipartFormData>))blocks success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSString *str = [NSString stringWithFormat:@"%@%@",Base_Net,url];
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:str]];
    //2.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //3.设置允许请求的类别
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
    

     [manager.requestSerializer setValue:ACCESSROLE forHTTPHeaderField:@"ACCESS-ROLE"];
    [manager.requestSerializer setValue:[UserModelArchiver unarchive].Token forHTTPHeaderField:@"ACCESS-TOKEN"];
    
    manager.requestSerializer.timeoutInterval = 30;
    
    if (blocks) {
        
    }else{
        
    }
    
    [manager POST:str parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        blocks(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                             
                                                            options:NSJSONReadingMutableContainers
                             
                                                              error:&err];
        NSLog(@"%@",err);
        success(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}




//弹出框
 +(void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithCancelBlack:(void(^)(void))CancelBlack WithDefaultBlack:(void(^)(void))defaultBlack{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:str message:str1 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CancelBlack();
    }];
    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        defaultBlack();
    }];
    [alert addAction:alert1];
    [alert addAction:alert2];
    [[BaseRequest currentVC] presentViewController:alert animated:YES completion:^{
        
    }];
}


/** 获取当前控制器 */
+(UIViewController *)currentVC
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //当前windows的根控制器
    UIViewController *controller = window.rootViewController;
    //通过循环一层一层往下查找
    while (YES) {
        //先判断是否有present的控制器
        if (controller.presentedViewController) {
            //有的话直接拿到弹出控制器，省去多余的判断
            controller = controller.presentedViewController;
        } else {
            if ([controller isKindOfClass:[UINavigationController class]]) {
                //如果是NavigationController，取最后一个控制器（当前）
                controller = [controller.childViewControllers lastObject];
            } else if ([controller isKindOfClass:[UITabBarController class]]) {
                //如果TabBarController，取当前控制器
                UITabBarController *tabBarController = (UITabBarController *)controller;
                controller = tabBarController.selectedViewController;
            } else {
                if (controller.childViewControllers.count > 0) {
                    //如果是普通控制器，找childViewControllers最后一个
                    controller = [controller.childViewControllers lastObject];
                } else {
                    //没有present，没有childViewController，则表示当前控制器
                    return controller;
                }
            }
        }
    }
}

@end
