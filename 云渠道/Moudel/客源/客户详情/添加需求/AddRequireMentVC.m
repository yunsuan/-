//
//  AddRequireMentVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddRequireMentVC.h"
#import "DropDownBtn.h"
#import "BorderTF.h"

@interface AddRequireMentVC ()<UITextViewDelegate>
{
    
    NSInteger _num;
    CustomRequireModel *_model;
}

@property (nonatomic, strong) UIScrollView *scrolleView;

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) DropDownBtn *addressBtn;

@property (nonatomic, strong) DropDownBtn *addressBtn2;

@property (nonatomic, strong) DropDownBtn *addressBtn3;

@property (nonatomic, strong) DropDownBtn *houseTypeBtn;

@property (nonatomic, strong) DropDownBtn *priceBtn;

@property (nonatomic, strong) DropDownBtn *areaBtn;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) DropDownBtn *faceBtn;

@property (nonatomic, strong) DropDownBtn *purposeBtn;

@property (nonatomic, strong) DropDownBtn *payWayBtn;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *faceL;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) UILabel *standardL;

@property (nonatomic, strong) UILabel *purposeL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *intentionL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) BorderTF *floorTF1;

@property (nonatomic, strong) BorderTF *floorTF2;

@property (nonatomic, strong) BorderTF *standardTF;

@property (nonatomic, strong) BorderTF *intentionTF;

@property (nonatomic, strong) BorderTF *urgentTF;

@property (nonatomic, strong) UISlider *intentionSlider;

@property (nonatomic, strong) UISlider *urgentSlider;

@property (nonatomic, strong) UIView *sectionLine;

@property (nonatomic, strong) UIView *tagView;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddRequireMentVC

- (instancetype)initWithCustomRequireModel:(CustomRequireModel *)model
{
    self = [super init];
    if (self) {
        
        _model = model;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    
}

- (void)ActionSliderChange:(UISlider *)slider{
    
    if (slider == _intentionSlider) {
        
        _intentionTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }else{
        
        _urgentTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    _num += 1;
    if (_num == 1) {
        
        [_addressBtn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(81 *SIZE);
            make.top.equalTo(_addressBtn.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        _addressBtn2.hidden = NO;
        
        
        [_houseTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(10 *SIZE);
            make.top.equalTo(_addressBtn2.mas_bottom).offset(29 *SIZE);
            make.width.equalTo(@(70 *SIZE));
            make.height.equalTo(@(13 *SIZE));
        }];
        
        [_houseTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(81 *SIZE);
            make.top.equalTo(_addressBtn2.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        
    }else{
        
        [_addressBtn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(81 *SIZE);
            make.top.equalTo(_addressBtn.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        
        [_addressBtn3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(81 *SIZE);
            make.top.equalTo(_addressBtn2.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        _addressBtn2.hidden = NO;
        _addressBtn3.hidden = NO;
        
        [_houseTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(10 *SIZE);
            make.top.equalTo(_addressBtn3.mas_bottom).offset(29 *SIZE);
            make.width.equalTo(@(70 *SIZE));
            make.height.equalTo(@(13 *SIZE));
        }];
        
        [_houseTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(81 *SIZE);
            make.top.equalTo(_addressBtn3.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        
        _placeL.hidden = YES;
    }else{
        
        _placeL.hidden = NO;
    }
}

- (void)initUI{

    if (_model) {
        
        self.titleLabel.text = @"修改需求";
    }else{
        
        self.titleLabel.text = @"添加需求";
    }
//    self.titleLabel.text = @"添加客户";
    self.navBackgroundView.hidden = NO;
    self.line.hidden = YES;
    
    _scrolleView = [[UIScrollView alloc] init];
    _scrolleView.backgroundColor = YJBackColor;
    _scrolleView.bounces = NO;
    [self.view addSubview:_scrolleView];
    
    _infoView = [[UIView alloc] init];
    _infoView.backgroundColor = CH_COLOR_white;
    [_scrolleView addSubview:_infoView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 20 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = YJBlueBtnColor;
    [_infoView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(32 *SIZE, 18 *SIZE, 80 *SIZE, 15 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"需求信息";
    [_infoView addSubview:label];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(313 *SIZE, 56 *SIZE, 25 *SIZE, 25 *SIZE);
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
    [_infoView addSubview:_addBtn];
    
    for(int i = 0; i < 12; i++){
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _addressL = label;
                _addressL.text = @"区域:";
                [_infoView addSubview:_addressL];
                break;
            }
            case 1:
            {
                _houseTypeL = label;
                _houseTypeL.text = @"物业类型:";
                [_infoView addSubview:_houseTypeL];
                break;
            }
            case 2:
            {
                _priceL = label;
                _priceL.text = @"总价:";
                [_infoView addSubview:_priceL];
                break;
            }
            case 3:
            {
                _areaL = label;
                _areaL.text = @"面积:";
                [_infoView addSubview:_areaL];
                break;
            }
            case 4:
            {
                _typeL = label;
                _typeL.text = @"房型:";
                [_infoView addSubview:_typeL];
                break;
            }
            case 5:
            {
                _faceL = label;
                _faceL.text = @"朝向:";
                [_infoView addSubview:_faceL];
                break;
            }
            case 6:
            {
                _floorL = label;
                _floorL.text = @"楼层:";
                [_infoView addSubview:_floorL];
                break;
            }
            case 7:
            {
                _standardL = label;
                _standardL.text = @"装修标准:";
                [_infoView addSubview:_standardL];
                break;
            }
            case 8:
            {
                _purposeL = label;
                _purposeL.text = @"置业目的:";
                [_infoView addSubview:_purposeL];
                break;
            }
            case 9:
            {
                _payWayL = label;
                _payWayL.text = @"付款方式:";
                [_infoView addSubview:_payWayL];
                break;
            }
            case 10:
            {
                _intentionL = label;
                _intentionL.text = @"购房意向度:";
                [_infoView addSubview:_intentionL];
                break;
            }
            case 11:
            {
                _urgentL = label;
                _urgentL.text = @"购房紧迫度:";
                [_infoView addSubview:_urgentL];
                break;
            }
            default:
                break;
        }
        
        if (i < 10) {
            
            DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            switch (i) {
                case 0:
                {
                    _addressBtn = btn;
                    _addressBtn.frame = CGRectMake(0, 0, 217 *SIZE, 33 *SIZE);
                    [_infoView addSubview:_addressBtn];
                    break;
                }
                case 1:
                {
                    _addressBtn2 = btn;
                    _addressBtn2.hidden = YES;
                    _addressBtn2.frame = CGRectMake(0, 0, 217 *SIZE, 33 *SIZE);
                    [_infoView addSubview:_addressBtn2];
                    break;
                }
                case 2:
                {
                    _addressBtn3 = btn;
                    _addressBtn3.hidden = YES;
                    _addressBtn3.frame = CGRectMake(0, 0, 217 *SIZE, 33 *SIZE);
                    [_infoView addSubview:_addressBtn3];
                    break;
                }
                case 3:
                {
                    _houseTypeBtn = btn;
                    [_infoView addSubview:_houseTypeBtn];
                    break;
                }
                case 4:
                {
                    _priceBtn = btn;
                    [_infoView addSubview:_priceBtn];
                    break;
                }
                case 5:
                {
                    _areaBtn = btn;
                    [_infoView addSubview:_areaBtn];
                    break;
                }
                case 6:
                {
                    _typeBtn = btn;
                    [_infoView addSubview:_typeBtn];
                    break;
                }
                case 7:
                {
                    _faceBtn = btn;
                    [_infoView addSubview:_faceBtn];
                    break;
                }
                case 8:
                {
                    _purposeBtn = btn;
                    [_infoView addSubview:_purposeBtn];
                    break;
                }
                case 9:
                {
                    _payWayBtn = btn;
                    [_infoView addSubview:_payWayBtn];
                    break;
                }
                default:
                    break;
            }
        }
        
        if (i < 5) {
            
            BorderTF *TF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            switch (i) {
                case 0:
                {
                    _floorTF1 = TF;
                    _floorTF1.frame = CGRectMake(0, 0, 117 *SIZE, 33 *SIZE);
                    [_infoView addSubview:_floorTF1];
                    break;
                }
                case 1:
                {
                    _floorTF2 = TF;
                    _floorTF2.frame = CGRectMake(0, 0, 117 *SIZE, 33 *SIZE);
                    [_infoView addSubview:_floorTF2];
                    break;
                }
                case 2:
                {
                    _standardTF = TF;
                    [_infoView addSubview:_standardTF];
                    break;
                }
                case 3:
                {
                    _intentionTF = TF;
                    _intentionTF.textfield.textAlignment = NSTextAlignmentRight;
                    _intentionTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                    [_infoView addSubview:_intentionTF];
                    break;
                }
                case 4:
                {
                    _urgentTF = TF;
                    _urgentTF.textfield.textAlignment = NSTextAlignmentRight;
                    _urgentTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                    [_infoView addSubview:_urgentTF];
                    break;
                }
                default:
                    break;
            }
        }
        
        if (i < 2) {
            
            UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 327 *SIZE, 5 *SIZE)];
            slider.userInteractionEnabled = YES;
            slider.minimumValue = 0.0;
            slider.maximumValue = 100.0;
            slider.maximumTrackTintColor = YJBackColor;
            slider.minimumTrackTintColor = COLOR(255, 224, 177, 1);
            slider.thumbTintColor = COLOR(255, 224, 177, 1);
            [slider setThumbImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
            [slider setThumbImage:[UIImage imageNamed:@"point"] forState:UIControlStateHighlighted];
            [slider addTarget:self action:@selector(ActionSliderChange:) forControlEvents:UIControlEventValueChanged];
            if (i == 0) {
                
                _intentionSlider = slider;
                [_infoView addSubview:_intentionSlider];
            }else{
                
                _urgentSlider = slider;
                [_infoView addSubview:_urgentSlider];
            }
        }
        

    }
    
    
    _tagView = [[UIView alloc] init];
    _tagView.backgroundColor = CH_COLOR_white;
    [_scrolleView addSubview:_tagView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 20 *SIZE, 7 *SIZE, 13 *SIZE)];
    view1.backgroundColor = YJBlueBtnColor;
    [_tagView addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(32 *SIZE, 18 *SIZE, 80 *SIZE, 15 *SIZE)];
    label1.textColor = YJTitleLabColor;
    label1.font = [UIFont systemFontOfSize:15 *SIZE];
    label1.text = @"需求标签";
    [_tagView addSubview:label1];
    
    _markTV = [[UITextView alloc] init];
    _markTV.delegate = self;
    _markTV.contentInset = UIEdgeInsetsMake(10 *SIZE, 12 *SIZE, 12 *SIZE, 12 *SIZE);
    [_scrolleView addSubview:_markTV];
    
    _placeL = [[UILabel alloc] initWithFrame:CGRectMake(6 *SIZE, 7 *SIZE, 40 *SIZE, 11 *SIZE)];
    _placeL.textColor = YJContentLabColor;
    _placeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _placeL.text = @"备注...";
    [_markTV addSubview:_placeL];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    _nextBtn.layer.cornerRadius = 2 *SIZE;
    _nextBtn.clipsToBounds = YES;
    [_nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_scrolleView addSubview:_nextBtn];
    
    [self masonryUI];
}


- (void)masonryUI{

    [_scrolleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];

    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scrolleView).offset(0);
        make.top.equalTo(_scrolleView).offset(0);
        make.right.equalTo(_scrolleView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.bottom.equalTo(_tagView.mas_top).offset(-9 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_infoView).offset(62 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.bottom.equalTo(_addressBtn.mas_bottom).offset(-11 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_infoView).offset(52 *SIZE);
        make.width.equalTo(@(217 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(33 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.bottom.equalTo(_priceL.mas_top).offset(-40 *SIZE);
    }];
    
    [_houseTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_priceBtn.mas_top).offset(-19 *SIZE);
    }];

    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_houseTypeBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
//        make.bottom.equalTo(_areaL.mas_top).offset(-39 *SIZE);
    }];
    
    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_houseTypeBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_areaBtn.mas_top).offset(-19 *SIZE);
    }];

    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
//        make.bottom.equalTo(_typeL.mas_top).offset(-38 *SIZE);
    }];
    
    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_priceBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_typeBtn.mas_top).offset(-19 *SIZE);
    }];

    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
//        make.bottom.equalTo(_faceL.mas_top).offset(-40 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_areaBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_faceBtn.mas_top).offset(-19 *SIZE);
    }];

    [_faceL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
//        make.bottom.equalTo(_floorL.mas_top).offset(-39 *SIZE);
    }];
    
    [_faceBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_floorTF1.mas_top).offset(-19 *SIZE);
    }];

    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_faceBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
//        make.bottom.equalTo(_standardL.mas_top).offset(-45 *SIZE);
    }];
    
    [_floorTF1 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_faceBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(117 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_standardTF.mas_top).offset(-19 *SIZE);
    }];

    [_floorTF2 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(222 *SIZE);
        make.top.equalTo(_faceBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(117 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_standardTF.mas_top).offset(-19 *SIZE);
    }];

    [_standardL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_floorTF1.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
//        make.bottom.equalTo(_purposeL.mas_top).offset(-40 *SIZE);
    }];
    
    [_standardTF mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_floorTF1.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_purposeBtn.mas_top).offset(-19 *SIZE);
    }];

    [_purposeL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_standardTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
//        make.bottom.equalTo(_payWayL.mas_top).offset(-42 *SIZE);
    }];
    
    [_purposeBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_standardTF.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_payWayBtn.mas_top).offset(-19 *SIZE);
    }];

    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_purposeBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
//        make.bottom.equalTo(_intentionL.mas_top).offset(-49 *SIZE);
    }];
    
    [_payWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_purposeBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_intentionTF.mas_top).offset(-19 *SIZE);
    }];

    [_intentionL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
//        make.bottom.equalTo(_urgentL.mas_top).offset(-84 *SIZE);
    }];
    
    [_intentionTF mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_payWayBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_urgentTF.mas_top).offset(-62 *SIZE);
    }];

    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_intentionTF.mas_bottom).offset(73 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
//        make.bottom.equalTo(_infoView.mas_bottom).offset(-79 *SIZE);
    }];
    
    [_urgentTF mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_intentionTF.mas_bottom).offset(62 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_infoView).offset(-69 *SIZE);
    }];
    
    [_intentionSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_intentionTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(327 *SIZE));
        make.height.equalTo(@(5 *SIZE));
    }];
    
    [_urgentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_urgentTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(327 *SIZE));
        make.height.equalTo(@(5 *SIZE));
    }];
    

    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_scrolleView).offset(0);
        make.top.equalTo(_infoView.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(_scrolleView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(117 *SIZE));
        make.bottom.equalTo(_markTV.mas_top).offset(-7 *SIZE);
    }];

    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_scrolleView).offset(0);
        make.top.equalTo(_tagView.mas_bottom).offset(7 *SIZE);
        make.right.equalTo(_scrolleView).offset(0);
        make.height.equalTo(@(117 *SIZE));
        make.width.equalTo(@(SCREEN_Width));
        make.bottom.equalTo(_nextBtn.mas_top).offset(-40 *SIZE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrolleView).offset(22 *SIZE);
        make.top.equalTo(_markTV.mas_bottom).offset(40 *SIZE);
        make.right.equalTo(_scrolleView).offset(-22 *SIZE);
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrolleView.mas_bottom).offset(-48 *SIZE);
    }];
    
}

@end
