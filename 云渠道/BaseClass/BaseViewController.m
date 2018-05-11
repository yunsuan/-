//
//  BaseViewController.m
//  易家
//
//  Created by xiaoq on 2017/11/8.
//  Copyright © 2017年 xiaoq. All rights reserved.
//


#import "BaseViewController.h"
//#import "LogoinViewController.h"
#import <CommonCrypto/CommonDigest.h>



@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialBaseViewInterface];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    _leftviewBtn.selected = NO;
    
}
#pragma mark - init
- (void)initialBaseViewInterface {
    
    self.view.backgroundColor = YJBackColor;
    [self.view addSubview:self.navBackgroundView];
    
    [self.navBackgroundView addSubview:self.titleLabel];
    [self.navBackgroundView addSubview:self.leftButton];
    [self.navBackgroundView addSubview:self.maskButton];
//        [self.view addSubview:self.leftviewBtn];
    [self.navBackgroundView addSubview:self.rightBtn];
    //    [self.tabBarController.tabBar addSubview:self.leftviewBtn];
    
    
}

- (UIView *)navBackgroundView {
    
    if (!_navBackgroundView) {
        _navBackgroundView = [[UIView alloc] init];

        _navBackgroundView.frame = CGRectMake(0, 0, SCREEN_Width, NAVIGATION_BAR_HEIGHT);

        _navBackgroundView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_Width, 44)];
        imageview.image = IMAGE_WITH_NAME(@"nav-beijingtu.png");
        [_navBackgroundView addSubview:imageview];
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT - SIZE, SCREEN_Width, SIZE)];
        _line.backgroundColor = YJBackColor;
        [_navBackgroundView addSubview:_line];
        
        _navBackgroundView.hidden = YES;
    }
    return _navBackgroundView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.center = CGPointMake(SCREEN_Width / 2, STATUS_BAR_HEIGHT+20 );
        _titleLabel.bounds = CGRectMake(0, 0, 180 * sIZE, 30 * sIZE);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:17 * sIZE];
    }
    return _titleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.center = CGPointMake(25 * SIZE, 20 + 22);
        _leftButton.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
        _leftButton.center = CGPointMake(25 * sIZE, STATUS_BAR_HEIGHT + 20);
        _leftButton.bounds = CGRectMake(0, 0, 80 * sIZE, 33 * sIZE);
        [_leftButton setImage:IMAGE_WITH_NAME(@"leftarrow.png") forState:UIControlStateNormal];
    }
    return _leftButton;
}

- (UIButton *)maskButton {
    if (!_maskButton) {
        _maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _maskButton.frame = CGRectMake(0, 20 * SIZE, 60 * SIZE, 44);
        _maskButton.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 60 * sIZE, 44);
        [_maskButton setBackgroundColor:[UIColor clearColor]];
        [_maskButton addTarget:self action:@selector(ActionMaskBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskButton;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.center = CGPointMake(SCREEN_Width - 25 * SIZE, STATUS_BAR_HEIGHT+20);
        _rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
//        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:13 * SIZE];
        _rightBtn.hidden = YES;
    }
    return _rightBtn;
}

-(UIButton *)leftviewBtn
{
    if (!_leftviewBtn) {
        _leftviewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [WJQTools setButtonAttributeWithButton:_leftviewBtn Title:@"" TitleFont:0 ImageName:@"Ctab_wode2@2x.png" Tag:1 fram:CGRectMake(256*SIZE, 0, 64*SIZE, 48)];
        [_leftviewBtn setImage:[UIImage imageNamed:@"Ctab_wode1@2x.png"] forState:UIControlStateSelected];
        [_leftviewBtn addTarget:self action:@selector(action_leftview) forControlEvents:UIControlEventTouchUpInside];
        //        _leftviewBtn.backgroundColor = [UIColor blackColor];
        
        _leftviewBtn.hidden = YES;
    }
    return _leftviewBtn;
}

-(void)action_leftview
{
    if (_leftviewBtn.selected == NO) {
        _leftviewBtn.selected = YES;
        NSLog(@"11");
    }
    
}

- (void)ActionMaskBtn:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//提示框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1{
    UIAlertController *alert_forbidden = [UIAlertController alertControllerWithTitle:str message:str1 preferredStyle:UIAlertControllerStyleAlert];
    [alert_forbidden addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert_forbidden animated:YES completion:nil];
}

//弹出框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithCancelBlack:(void(^)(void))CancelBlack WithDefaultBlack:(void(^)(void))defaultBlack{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:str message:str1 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CancelBlack();
    }];
    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        defaultBlack();
    }];
    [alert addAction:alert1];
    [alert addAction:alert2];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

//判断是否登录
- (BOOL)isLogin{
    NSString *logIndentifier = [[NSUserDefaults standardUserDefaults] objectForKey:LOGINENTIFIER];
    if (![logIndentifier isEqualToString:@"logInSuccessdentifier"]) {
        return NO;
    }
    return YES;
}

- (BOOL)goToLogin{
    NSString *logIndentifier = [[NSUserDefaults standardUserDefaults] objectForKey:LOGINENTIFIER];
    if (![logIndentifier isEqualToString:@"logInSuccessdentifier"]) {
        //去登录
        [self logAlertShowWithMessage];
        return NO;
    }
    return YES;
}

//没登录警告
- (void)logAlertShowWithMessage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

//        LogoinViewController *mainLogin_vc = [[LogoinViewController alloc]init];
//        [self.navigationController pushViewController:mainLogin_vc animated:YES];
//        UINavigationController *mainLogin_nav = [[UINavigationController alloc]initWithRootViewController:mainLogin_vc];
//        mainLogin_nav.navigationBar.hidden = YES;
//        [self presentViewController:mainLogin_nav animated:YES completion:^{
//
//        }];
        
        
    }];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

//label自动适应高度
//text:是label中的文字
//fontSize:是label中文字字体大小
//labelWidth:是label的宽度
- (CGFloat)setIntroductionText:(NSString *)text fontSize:(CGFloat)fontSize labelWidth:(CGFloat)labelWidth{
    CGRect labelRect = [text boundingRectWithSize:CGSizeMake(labelWidth,10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return labelRect.size.height;
}



/**
 *  检查输入的手机号正确与否
 */
- (BOOL)checkTel:(NSString *)str {
    NSString *regex = @"^((13[0-9])|(17[0-9])|(14[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

- (BOOL)checkPassword:(NSString *)str {
    NSString *regex = @"^[a-zA-Z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

- (NSString *)isSplitHTTP:(NSString *)string {
    if (![string isEqual:@""]) {
        if (![[string substringToIndex:4] isEqualToString:@"http"]) {
            string = [NSString stringWithFormat:@"%@%@",Base_Net,string];
        }
    }
    return string;
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

-(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];//转换成utf-8
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}

- (void)showContent:(NSString *)str {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.7f];
    hud.label.text= str;
    hud.label.textColor = [UIColor whiteColor];
    hud.margin = 10.f;
    [hud setOffset:CGPointMake(0, 10.f*SIZE)];
    //    hud.yOffset = 10.f * sIZE;
    hud.removeFromSuperViewOnHide = YES;
    //    [hud hide:YES afterDelay:1.5];
    [hud hideAnimated:YES afterDelay:1.5];
}

//对图片压缩
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    
    return imageData;
}

//调整图片方向
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//判断字符串为空
- (BOOL)isEmpty:(NSString *)str{
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

-(NSString * _Nonnull)gettime:(NSDate * _Nonnull)date//nsdate转字符转
{
    NSDateFormatter*dateFormatter = [[NSDateFormatter  alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString*currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}
-(NSArray *)getDetailConfigArrByConfigState:(ConfigState)configState
{
     NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
     NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%lu",(unsigned long)configState]];
    return dic[@"param"];
}

@end

