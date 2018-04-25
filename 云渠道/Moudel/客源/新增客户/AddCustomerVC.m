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
#import "CustomerModel.h"
#import "AddRequireMentVC.h"

@interface AddCustomerVC ()
{
    NSInteger _numAdd;
    CustomerModel *_model;
}
@property (nonatomic , strong) UIScrollView *scrollview;
@property (nonatomic, strong) UILabel *numclasslab;
@property (nonatomic, strong) UILabel *numlab;
@property (nonatomic, strong) UILabel *adresslab;
@property (nonatomic , strong) DropDownBtn *sex;
@property (nonatomic , strong) BorderTF *name;
@property (nonatomic , strong) DropDownBtn *birth;
@property (nonatomic , strong) BorderTF *tel1;
@property (nonatomic, strong) UIButton *addBtn;
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
        
        _model = [[CustomerModel alloc] init];
        _model = model;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //设置隐藏
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navBackgroundView.hidden = NO;
    if (_model.client_id) {
        
        self.titleLabel.text = @"修改信息";
    }else{
        
        self.titleLabel.text = @"添加客户";
    }
    [self initDataSouce];
    [self initUI];

}

-(void)initDataSouce
{
    _Customerinfomodel = [[CustomerInfoModel alloc]init];
    _Customerinfomodel.sex = @"0";
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (_numAdd == 0 ) {
        
        if ([self checkTel:_tel1.textfield.text]) {
            
            _numAdd += 1;
            [_tel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_scrollview).offset(80 *SIZE);
                make.top.equalTo(_tel1.mas_bottom).offset(19 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
            _tel2.hidden = NO;
            
            
            [_numclasslab mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_scrollview).offset(9 *SIZE);
                make.top.equalTo(_tel2.mas_bottom).offset(30 *SIZE);
                make.width.equalTo(@(65 *SIZE));
                make.height.equalTo(@(13 *SIZE));
            }];
            
            [_numclass mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_scrollview).offset(80 *SIZE);
                make.top.equalTo(_tel2.mas_bottom).offset(19 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
        }else{
            
            [self showContent:@"请填写正确的电话号码"];
        }
        
    }else{
        
        if ([self checkTel:_tel2.textfield.text]) {
            
            _numAdd += 1;
            [_tel3 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_scrollview).offset(80 *SIZE);
                make.top.equalTo(_tel2.mas_bottom).offset(19 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
            _tel3.hidden = NO;
            
            
            [_numclasslab mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_scrollview).offset(9 *SIZE);
                make.top.equalTo(_tel3.mas_bottom).offset(30 *SIZE);
                make.width.equalTo(@(65 *SIZE));
                make.height.equalTo(@(13 *SIZE));
            }];
            
            [_numclass mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_scrollview).offset(80 *SIZE);
                make.top.equalTo(_tel3.mas_bottom).offset(19 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
        }else{
            
            [self showContent:@"请填写正确的电话号码"];
        }
    }
}

-(void)initUI
{
    
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE,SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scrollview.contentSize = CGSizeMake(360*SIZE, 680*SIZE);
    _scrollview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollview];
    
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
    [_scrollview addSubview:backview];
    
    //姓名
    UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 56*SIZE, 100*SIZE, 14*SIZE)];
    namelab.text = @"*姓名:";
    namelab.font = [UIFont systemFontOfSize:13.3*SIZE];
    namelab.textColor = YJTitleLabColor;
    [_scrollview addSubview:namelab];
    _name = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 46*SIZE, 116.7*SIZE, 33.3*SIZE)];
    _name.textfield.text = _model.name;
    [_scrollview addSubview:_name];
    
    //性别
    UILabel *sexlab = [[UILabel alloc]initWithFrame:CGRectMake(208.7*SIZE, 56*SIZE, 100*SIZE, 14*SIZE)];
    sexlab.text = @"性别:";
    sexlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    sexlab.textColor = YJTitleLabColor;
    [_scrollview addSubview:sexlab];
    _sex = [[DropDownBtn alloc]initWithFrame:CGRectMake(251.3*SIZE, 46*SIZE, 86.7*SIZE, 33.3*SIZE)];
    if ([_model.sex integerValue] == 1) {
        
        _sex.content.text = @"男";
        _Customerinfomodel.sex = _model.sex;
    }else if ([_model.sex integerValue] == 2){
        
        _Customerinfomodel.sex = _model.sex;
        _sex.content.text = @"女";
    }
    [_sex addTarget:self action:@selector(action_sex) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_sex];
    
    //出生日期
    UILabel *brithlab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 106*SIZE, 100*SIZE, 14*SIZE)];
    brithlab.text = @"出生日期:";
    brithlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    brithlab.textColor = YJTitleLabColor;
    [_scrollview addSubview:brithlab];
    _birth = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 96*SIZE, 257.7*SIZE, 33.3*SIZE)];
    if (_model.birth) {
        
        _birth.content.text = _model.birth;
    }
    [_birth addTarget:self action:@selector(action_brith) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_birth];
    
    NSArray *telArr = [_model.tel componentsSeparatedByString:@","];
    //电话
    UILabel *tellab1 = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 169*SIZE, 100*SIZE, 14*SIZE)];
    tellab1.text = @"*联系号码:";
    tellab1.font = [UIFont systemFontOfSize:13.3*SIZE];
    tellab1.textColor = YJTitleLabColor;
    [_scrollview addSubview:tellab1];
    _tel1 = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 146*SIZE, 257.7*SIZE, 33.3*SIZE)];
    if (telArr.count) {
        
        _tel1.textfield.text = telArr[0];
    }
    _tel1.textfield.keyboardType = UIKeyboardTypePhonePad;
    [_scrollview addSubview:_tel1];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(313 *SIZE, 162 *SIZE, 25 *SIZE, 25 *SIZE);
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
    [_scrollview addSubview:_addBtn];
    
    _tel2 = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 196*SIZE, 257.7*SIZE, 33.3*SIZE)];
    _tel2.hidden = YES;
    _tel2.textfield.keyboardType = UIKeyboardTypePhonePad;
    if (telArr.count > 1) {
        
        [self ActionAddBtn:_addBtn];
        _tel2.textfield.text = telArr[1];
    }
    [_scrollview addSubview:_tel2];

    _tel3 = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 246*SIZE, 257.7*SIZE, 33.3*SIZE)];
    _tel3.hidden = YES;
    _tel3.textfield.keyboardType = UIKeyboardTypePhonePad;
    if (telArr.count > 2) {
        
        [self ActionAddBtn:_addBtn];
        _tel3.textfield.text = telArr[2];
    }
    [_scrollview addSubview:_tel3];
    
    //证件类型
    _numclasslab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 306*SIZE, 100*SIZE, 14*SIZE)];
    _numclasslab.text = @"证件类型:";
    _numclasslab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _numclasslab.textColor = YJTitleLabColor;
    [_scrollview addSubview:_numclasslab];
    
    _numclass = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 296*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [_numclass addTarget:self action:@selector(action_numclass) forControlEvents:UIControlEventTouchUpInside];
    if (_model.card_type) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",2]];
        NSArray *typeArr = dic[@"param"];
        for (int i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"id"] integerValue] == [_model.card_type integerValue]) {
                
                _Customerinfomodel.card_type = _model.card_type;
                _numclass.content.text = typeArr[i][@"param"];
                break;
            }
        }
    }
    [_scrollview addSubview:_numclass];
    
    //证件号
    _numlab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 356*SIZE, 100*SIZE, 14*SIZE)];
    _numlab.text = @"证件号:";
    _numlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _numlab.textColor = YJTitleLabColor;
    [_scrollview addSubview:_numlab];
    
    _num = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 346*SIZE, 257.7*SIZE, 33.3*SIZE)];
    _num.textfield.keyboardType = UIKeyboardTypeDefault;
    if (_model.card_id) {
        
        _num.textfield.text = _model.card_id;
    }
    [_scrollview addSubview:_num];
    
    //地址
    _adresslab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 406*SIZE, 100*SIZE, 14*SIZE)];
    _adresslab.text = @"地址:";
    _adresslab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _adresslab.textColor = YJTitleLabColor;
    [_scrollview addSubview:_adresslab];
    
    _adress = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 396*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [_adress addTarget:self action:@selector(action_address) forControlEvents:UIControlEventTouchUpInside];
    if (_model.province && _model.city && _model.district) {
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
        
        NSError *err;
        NSArray *provice = [NSJSONSerialization JSONObjectWithData:JSONData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&err];
        for (int i = 0; i < provice.count; i++) {
            
            if([provice[i][@"region"] integerValue] == [_model.province integerValue]){
                
                NSArray *city = provice[i][@"item"];
                for (int j = 0; j < city.count; j++) {
                    
                    if([city[j][@"region"] integerValue] == [_model.city integerValue]){
                        
                        NSArray *area = city[j][@"item"];
                        
                        for (int k = 0; k < area.count; k++) {
                            
                            if([area[k][@"region"] integerValue] == [_model.district integerValue]){
                                
                                _adress.content.text = [NSString stringWithFormat:@"%@-%@-%@",provice[i][@"name"],city[j][@"name"],area[k][@"name"]];
                                _Customerinfomodel.province = _model.province;
                                _Customerinfomodel.city = _model.city;
                                _Customerinfomodel.district = _model.district;
                            }
                        }
                    }
                }
            }
        }
    }
    [_scrollview addSubview:_adress];
    
//     UIView * detailadressview = [[UIView alloc]initWithFrame:CGRectMake(80.3*SIZE, 446*SIZE, 257.7*SIZE, 86.7*SIZE)];
//    detailadressview.layer.masksToBounds = YES;
//    detailadressview.layer.cornerRadius = 5*SIZE;
//    detailadressview.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
//    detailadressview.layer.borderWidth = 1*SIZE;
//    [_scrollview addSubview:detailadressview];
    
    _detailadress = [[UITextView alloc]initWithFrame:CGRectMake(90.3*SIZE,456*SIZE, 237.7*SIZE, 66.7*SIZE)];
    _detailadress.textColor = YJTitleLabColor;
    _detailadress.layer.cornerRadius = 5 *SIZE;
    _detailadress.clipsToBounds = YES;
    _detailadress.layer.borderWidth = SIZE;
    _detailadress.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _detailadress.font = [UIFont systemFontOfSize:13.3*SIZE];
    if (_model.address) {
        
        _detailadress.text = _model.address;
    }
    [_scrollview addSubview:_detailadress];
    
    [_scrollview addSubview:self.surebtn];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_tel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(81 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(217 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_numclasslab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_tel1.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_numclass mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_tel1.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_numclass.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_num mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_numclass.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_adresslab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_num.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_adress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_num.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_detailadress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_adress.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(77 *SIZE));
    }];
    
    [self.surebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(22 *SIZE);
        make.top.equalTo(_detailadress.mas_bottom).offset(43 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollview.mas_bottom).offset(-53 *SIZE);
    }];
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
    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:CARD_TYPE]];
    
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
    _numclass.content.text = MC;
    _Customerinfomodel.card_type = ID;
        
    };
    [self.view addSubview:view];
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
    
    if (_model.client_id) {
        
        _Customerinfomodel.name = _name.textfield.text;
        
        if ([self checkTel:_tel1.textfield.text]) {
            
            _Customerinfomodel.tel = _tel1.textfield.text;
        }else{
            
            [self showContent:@"请填写正确的电话号码"];
            return;
        }
        if (_numAdd == 1 && [self checkTel:_tel2.textfield.text]) {
            
            _Customerinfomodel.tel = [NSString stringWithFormat:@"%@,%@",_tel1.textfield.text,_tel2.textfield.text];
        }
        if (_numAdd > 1 && [self checkTel:_tel2.textfield.text]) {
            
            _Customerinfomodel.tel = [NSString stringWithFormat:@"%@,%@,%@",_tel1.textfield.text,_tel2.textfield.text,_tel3.textfield.text];
        }
        if (![self isEmpty:_num.textfield.text]) {
            
            _Customerinfomodel.card_id = _num.textfield.text;
        }
        
        if (![self isEmpty:_detailadress.text]) {
            
            _Customerinfomodel.card_id = _detailadress.text;
        }
        
        
        NSMutableDictionary *dic = [_Customerinfomodel modeltodic];
        [dic setObject:_model.client_id forKey:@"client_id"];
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([[NSString stringWithFormat:@"%@",obj] isEqualToString:@""]) {
                
                [dic removeObjectForKey:key];
            }
        }];
        
        [BaseRequest POST:UpdateClient_URL parameters:dic success:^(id resposeObject) {
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
        
        if ([self checkTel:_tel1.textfield.text]) {
            
            _Customerinfomodel.tel = _tel1.textfield.text;
        }else{
            
            [self showContent:@"请填写正确的电话号码"];
            return;
        }
        if (_numAdd == 1 && [self checkTel:_tel2.textfield.text]) {
            
            _Customerinfomodel.tel = [NSString stringWithFormat:@"%@,%@",_tel1.textfield.text,_tel2.textfield.text];
        }
        if (_numAdd > 1 && [self checkTel:_tel2.textfield.text]) {
            
            _Customerinfomodel.tel = [NSString stringWithFormat:@"%@,%@,%@",_tel1.textfield.text,_tel2.textfield.text,_tel3.textfield.text];
        }
        _Customerinfomodel.card_id = _num.textfield.text;
        _Customerinfomodel.address = _detailadress.text;
        
        AddRequireMentVC *nextVC = [[AddRequireMentVC alloc] init];
        nextVC.status = @"addCustom";
        nextVC.infoModel = _Customerinfomodel;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}


-(UIButton *)surebtn
{
    if (!_surebtn) {
        _surebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _surebtn.frame =  CGRectMake(20*SIZE, 566*SIZE, 320*SIZE, 40*SIZE);
        _surebtn.backgroundColor = YJBlueBtnColor;
        _surebtn.layer.masksToBounds = YES;
        _surebtn.layer.cornerRadius = 1.7*SIZE;
        
        if (_model.name) {
            
            [_surebtn setTitle:@"确定" forState:UIControlStateNormal];
        }else{
            [_surebtn setTitle:@"下一步" forState:UIControlStateNormal];
        }
        [_surebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _surebtn.titleLabel.font = [UIFont systemFontOfSize:15.3*SIZE];
        [_surebtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _surebtn;
}


@end
