//
//  AddCustomerVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddCustomerVC.h"
#import "SinglePickView.h"
#import "DropDownBtn.h"
#import "BorderTF.h"
#import "DateChooseView.h"
#import "AdressChooseView.h"
//#import "CustomerInfoModel.h"

@interface AddCustomerVC ()
{
    
    CustomerModel *_model;
}
@property (nonatomic , strong) UIScrollView *scrollview;
@property (nonatomic , strong) DropDownBtn *sex;
@property (nonatomic , strong) BorderTF *name;
@property (nonatomic , strong) DropDownBtn *birth;
@property (nonatomic , strong) BorderTF *tel1;
@property (nonatomic , strong) BorderTF *tel2;
@property (nonatomic , strong) BorderTF *tel3;
@property (nonatomic , strong) DropDownBtn *numclass;
@property (nonatomic , strong) BorderTF *num;
@property (nonatomic , strong) DropDownBtn *adress;
@property (nonatomic , strong) UITextView *detailadress;
@property (nonatomic , strong) UIButton *surebtn;
@property (nonatomic , strong) CustomerInfoModel *Customerinfomodel;

-(void)initUI;
-(void)initDataSouce;
@end

@implementation AddCustomerVC

- (instancetype)initWithModel:(CustomerModel *)model
{
    self = [super init];
    if (self) {
        
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加客户";
    [self initDataSouce];
    [self initUI];

}

-(void)initDataSouce
{
    _Customerinfomodel = [[CustomerInfoModel alloc]init];
    _Customerinfomodel.sex = @"0";
}

-(void)initUI
{
    [self.view addSubview:self.scrollview];
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
    // 顶部
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = YJTitleLabColor;
    title.text = @"客户信息";
    [backview addSubview:title];
    [self.scrollview addSubview:backview];
    
    //姓名
    UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 56*SIZE, 100*SIZE, 14*SIZE)];
    namelab.text = @"*姓名:";
    namelab.font = [UIFont systemFontOfSize:13.3*SIZE];
    namelab.textColor = YJTitleLabColor;
    [self.scrollview addSubview:namelab];
    _name = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 46*SIZE, 116.7*SIZE, 33.3*SIZE)];
    _name.textfield.text = _model.name;
    [self.scrollview addSubview:_name];
    
    //性别
    UILabel *sexlab = [[UILabel alloc]initWithFrame:CGRectMake(208.7*SIZE, 56*SIZE, 100*SIZE, 14*SIZE)];
    sexlab.text = @"性别:";
    sexlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    sexlab.textColor = YJTitleLabColor;
    [self.scrollview addSubview:sexlab];
    _sex = [[DropDownBtn alloc]initWithFrame:CGRectMake(251.3*SIZE, 46*SIZE, 86.7*SIZE, 33.3*SIZE)];
    [_sex addTarget:self action:@selector(action_sex) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:_sex];
    //出生日期
    UILabel *brithlab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 106*SIZE, 100*SIZE, 14*SIZE)];
    brithlab.text = @"出生日期:";
    brithlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    brithlab.textColor = YJTitleLabColor;
    [self.scrollview addSubview:brithlab];
    _birth = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 96*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [_birth addTarget:self action:@selector(action_brith) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:_birth];
    
    //电话
    UILabel *tellab1 = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 156*SIZE, 100*SIZE, 14*SIZE)];
    tellab1.text = @"*联系号码1:";
    tellab1.font = [UIFont systemFontOfSize:13.3*SIZE];
    tellab1.textColor = YJTitleLabColor;
    [self.scrollview addSubview:tellab1];
    _tel1 = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 146*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [self.scrollview addSubview:_tel1];
    
    UILabel *tellab2 = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 206*SIZE, 100*SIZE, 14*SIZE)];
    tellab2.text = @"联系号码2:";
    tellab2.font = [UIFont systemFontOfSize:13.3*SIZE];
    tellab2.textColor = YJTitleLabColor;
    [self.scrollview addSubview:tellab2];
    _tel2 = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 196*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [self.scrollview addSubview:_tel2];
    
    UILabel *tellab3 = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 256*SIZE, 100*SIZE, 14*SIZE)];
    tellab3.text = @"联系号码3:";
    tellab3.font = [UIFont systemFontOfSize:13.3*SIZE];
    tellab3.textColor = YJTitleLabColor;
    [self.scrollview addSubview:tellab3];
    _tel3 = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 246*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [self.scrollview addSubview:_tel3];
    //证件类型
    UILabel *numclasslab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 306*SIZE, 100*SIZE, 14*SIZE)];
    numclasslab.text = @"证件类型:";
    numclasslab.font = [UIFont systemFontOfSize:13.3*SIZE];
    numclasslab.textColor = YJTitleLabColor;
    [self.scrollview addSubview:numclasslab];
    _numclass = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 296*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [_numclass addTarget:self action:@selector(action_numclass) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:_numclass];
    //证件号
    UILabel *numlab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 356*SIZE, 100*SIZE, 14*SIZE)];
    numlab.text = @"证件号:";
    numlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    numlab.textColor = YJTitleLabColor;
    [self.scrollview addSubview:numlab];
    _num = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 346*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [self.scrollview addSubview:_num];
    //地址
    UILabel *_adresslab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 406*SIZE, 100*SIZE, 14*SIZE)];
    _adresslab.text = @"地址:";
    _adresslab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _adresslab.textColor = YJTitleLabColor;
    [self.scrollview addSubview:_adresslab];
    _adress = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 396*SIZE, 257.7*SIZE, 33.3*SIZE)];
    
    [_adress addTarget:self action:@selector(action_address) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:_adress];
     UIView * detailadressview = [[UIView alloc]initWithFrame:CGRectMake(80.3*SIZE, 446*SIZE, 257.7*SIZE, 86.7*SIZE)];
    detailadressview.layer.masksToBounds = YES;
    detailadressview.layer.cornerRadius = 5*SIZE;
    detailadressview.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    detailadressview.layer.borderWidth = 1*SIZE;
    [_scrollview addSubview:detailadressview];
    
    _detailadress = [[UITextView alloc]initWithFrame:CGRectMake(90.3*SIZE,456*SIZE, 237.7*SIZE, 66.7*SIZE)];
    _detailadress.textColor =YJTitleLabColor;
    _detailadress.font = [UIFont systemFontOfSize:13.3*SIZE];
    [self.scrollview addSubview:_detailadress];
    [self.scrollview addSubview:self.surebtn];
    
}


-(void)action_sex
{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _sex.content.text = @"男";
        _Customerinfomodel.sex = @"1";
    }];
    
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _sex.content.text = @"女";
        _Customerinfomodel.sex =@"2";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:male];
    [alert addAction:female];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

-(void)action_brith
{
    DateChooseView *view = [[DateChooseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    view.dateblock = ^(NSDate *date) {
        NSLog(@"%@",[self gettime:date]);
        _birth.content.text = [self gettime:date];
        _Customerinfomodel.birth = _birth.content.text;
    };
    [self.view addSubview:view];
}

-(void)action_numclass
{
    [BaseRequest GET:Config_URL parameters:@{@"id":[NSString stringWithFormat:@"%ld",CARD_TYPE]} success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            NSArray *dataarr = resposeObject[@"data"][@"param"];
            SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:dataarr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    _numclass.content.text = MC;
                    _Customerinfomodel.card_type = ID;
                };
                [self.view addSubview:view];
            
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)action_address
{
    AdressChooseView *view = [[AdressChooseView alloc]initWithFrame:self.view.frame withdata:@[]];
    [self.view addSubview:view];
    view.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
        self.adress.content.text = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
        _Customerinfomodel.province = proviceid;
        _Customerinfomodel.city = cityid;
        _Customerinfomodel.district = areaid;
    };
}

-(void)action_sure
{
    if (_name.textfield.text.length == 0 || [self isEmpty:_name.textfield.text]) {
        
        [self showContent:@"请输入姓名！"];
        return;
    }
    if (![self checkTel:_tel1.textfield.text]) {
        
        [self showContent:@"请输入正确的电话号码"];
        return;
    }
    
    if (_model.clientId) {
        
        _model.name = _name.textfield.text;
        _model.tel = [NSString stringWithFormat:@"%@,%@,%@",_tel1.textfield.text,_tel2.textfield.text,_tel3.textfield.text];
        _model.card_id = _num.textfield.text;
        _model.address = _detailadress.text;
        
        
        [BaseRequest POST:UpdateClient_URL parameters:[_model modeltodic] success:^(id resposeObject) {
            NSLog(@"%@",resposeObject);
            [self showContent:resposeObject[@"msg"]];
            if ([resposeObject[@"code"] integerValue] ==200) {
                
            }
            else{
                
            }
            
            
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [self showContent:@"网络出错"];
        }];
    }else{
        _Customerinfomodel.name = _name.textfield.text;
        _Customerinfomodel.tel = [NSString stringWithFormat:@"%@,%@,%@",_tel1.textfield.text,_tel2.textfield.text,_tel3.textfield.text];
        _Customerinfomodel.card_id = _num.textfield.text;
        _Customerinfomodel.address = _detailadress.text;
        
        [BaseRequest POST:AddCustomer_URL parameters:[_Customerinfomodel modeltodic] success:^(id resposeObject) {
            NSLog(@"%@",resposeObject);
            [self showContent:resposeObject[@"msg"]];
            if ([resposeObject[@"code"] integerValue] ==200) {
                
            }
            else{
                
            }
            
            
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [self showContent:@"网络出错"];
        }];
    }
}

-(UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE,SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
        _scrollview.contentSize = CGSizeMake(360*SIZE, 680*SIZE);
        _scrollview.backgroundColor = [UIColor whiteColor];
    }
    return _scrollview;
}

-(UIButton *)surebtn
{
    if (!_surebtn) {
        _surebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _surebtn.frame =  CGRectMake(20*SIZE, 566*SIZE, 320*SIZE, 40*SIZE);
        _surebtn.backgroundColor = YJBlueBtnColor;
        _surebtn.layer.masksToBounds = YES;
        _surebtn.layer.cornerRadius = 1.7*SIZE;
        [_surebtn setTitle:@"确定" forState:UIControlStateNormal];
        [_surebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _surebtn.titleLabel.font = [UIFont systemFontOfSize:15.3*SIZE];
        [_surebtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _surebtn;
}


@end
