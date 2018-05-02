//
//  CompleteCustomVC1.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompleteCustomVC1.h"
#import "DropDownBtn.h"
#import "BorderTF.h"
#import "AuthenCollCell.h"
#import "CompleteCustomVC2.h"
#import "SinglePickView.h"

@interface CompleteCustomVC1 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    
    NSInteger _num;
    NSMutableArray *_imgArr;
    UIImagePickerController *_imagePickerController;
    UIImage *_image;
    NSInteger _index;
    NSString *_clientId;
    NSString *_cardType;
    NSString *_name;
}

@property (nonatomic, strong) UIScrollView *scrolleView;

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTF *nameTF;

@property (nonatomic, strong) UILabel *intentionL;

@property (nonatomic, strong) BorderTF *intentionTF;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) BorderTF *urgentTF;

@property (nonatomic, strong) UISlider *intentionSlider;

@property (nonatomic, strong) UISlider *urgentSlider;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) BorderTF *phoneTF1;

@property (nonatomic, strong) BorderTF *phoneTF2;

@property (nonatomic, strong) BorderTF *phoneTF3;

@property (nonatomic, strong) UILabel *identifyL;

@property (nonatomic, strong) DropDownBtn *identifyBtn;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) BorderTF *codeTF;

@property (nonatomic, strong) UILabel *collL;

@property (nonatomic, strong) UICollectionView *authenColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation CompleteCustomVC1

- (instancetype)initWithClientID:(NSString *)clientId name:(NSString *)name
{
    self = [super init];
    if (self) {
        
        _name = name;
        _clientId = clientId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _imgArr = [@[] mutableCopy];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
}

- (void)ActionTagNumBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        
    }else{
        
        SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:CARD_TYPE]];
        
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            _identifyBtn.content.text = [NSString stringWithFormat:@"%@",MC];
            _cardType = [NSString stringWithFormat:@"%@",ID];
        };
        [self.view addSubview:view];
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (!_intentionTF.textfield.text.length) {
        
        [self showContent:@"请输入购房意向度"];
        return;
    }
    if (!_urgentTF.textfield.text.length) {
        
        [self showContent:@"请输入购房紧迫度"];
        return;
    }
    
    NSString *tel;
    if (_num == 0) {
        
        if (![self checkTel:_phoneTF1.textfield.text]) {
            
            [self showContent:@"请填写正确的电话号码"];
            return;
        }else{
            
            tel = _phoneTF1.textfield.text;
        }
    }else if (_num == 1) {
        
        if (_phoneTF2.textfield.text.length) {
            
            if (![self checkTel:_phoneTF2.textfield.text]) {
                
                [self showContent:@"请填写正确的电话号码"];
                return;
            }else{
                
                tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF2.textfield.text];
            }
        }
    }else{
        
        if (_phoneTF3.textfield.text.length) {
            
            if (![self checkTel:_phoneTF3.textfield.text]) {
                
                [self showContent:@"请填写正确的电话号码"];
                return;
            }else{
                
                tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF3.textfield.text];
            }
        }
    }
    
    if (!_cardType.length) {
        
        [self showContent:@"请选择证件类型"];
        return;
    }
    
    if (!_codeTF.textfield.text.length) {
        
        [self showContent:@"请填写证件号"];
        return;
    }
    
    if (!_imgArr.count) {
        
        [self showContent:@"请上传身份证照片"];
        return;
    }
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_clientId forKey:@"client_id"];
    [dic setObject:_nameTF.textfield.text forKey:@"client_name"];
    [dic setObject:tel forKey:@"client_tel"];
    [dic setObject:_cardType forKey:@"card_type"];
    [dic setObject:_codeTF.textfield.text forKey:@"card_num"];
    [dic setObject:_imgArr forKey:@"verify_img_url"];
    CompleteCustomVC2 *nextVC = [[CompleteCustomVC2 alloc] initWithData:dic];
    [self.navigationController pushViewController:nextVC animated:YES];
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
        
        [_phoneTF2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(81 *SIZE);
            make.top.equalTo(_phoneTF1.mas_bottom).offset(21 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        _phoneTF2.hidden = NO;
        
        [_identifyL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(10 *SIZE);
            make.top.equalTo(_phoneTF2.mas_bottom).offset(31 *SIZE);
            make.width.equalTo(@(70 *SIZE));
            make.height.equalTo(@(13 *SIZE));
        }];
        
        [_identifyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(81 *SIZE);
            make.top.equalTo(_phoneTF2.mas_bottom).offset(21 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        
    }else{
    
        [_phoneTF3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(81 *SIZE);
            make.top.equalTo(_phoneTF2.mas_bottom).offset(21 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        _phoneTF3.hidden = NO;
        
        [_identifyL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(10 *SIZE);
            make.top.equalTo(_phoneTF3.mas_bottom).offset(31 *SIZE);
            make.width.equalTo(@(70 *SIZE));
            make.height.equalTo(@(13 *SIZE));
        }];
        
        [_identifyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_infoView).offset(81 *SIZE);
            make.top.equalTo(_phoneTF3.mas_bottom).offset(21 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
    }
}

#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count < 2? _imgArr.count + 1: 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AuthenCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthenCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AuthenCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 91 *SIZE)];
    }
    cell.cancelBtn.tag = indexPath.item;
    cell.cancelBtn.hidden = NO;
    [cell.cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_imgArr.count) {
        
        if (indexPath.item < _imgArr.count) {
            
            cell.imageView.image = _imgArr[indexPath.item];
        }else{
            
            cell.imageView.image = [UIImage imageNamed:@"add"];
            cell.cancelBtn.hidden = YES;
        }
    }else{
        
        cell.imageView.image = [UIImage imageNamed:@"add"];
        cell.cancelBtn.hidden = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _index = indexPath.item;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self selectPhotoAlbumPhotos];
    }];
    UIAlertAction *takePic = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self takingPictures];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:takePic];
    [alertController addAction:photo];
    [alertController addAction:cancel];
    [self.navigationController presentViewController:alertController animated:YES completion:^{
        
    }];
}

#pragma mark - 选择头像

- (void)selectPhotoAlbumPhotos {
    // 获取支持的媒体格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    // 判断是否支持需要设置的sourceType
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        // 1、设置图片拾取器上的sourceType
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 2、设置支持的媒体格式
        _imagePickerController.mediaTypes = @[mediaTypes[0]];
        // 3、其他设置
        _imagePickerController.allowsEditing = YES; // 如果设置为NO，当用户选择了图片之后不会进入图像编辑界面。
        // 4、推送图片拾取器控制器
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }
}

// 拍照
- (void)takingPictures {
    // 获取支持的媒体格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    // 判断是否支持需要设置的sourceType
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // 1、设置图片拾取器上的sourceType
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 2、设置支持的媒体格式
        _imagePickerController.mediaTypes = @[mediaTypes[0]];
        // 3、其他设置
        // 设置相机模式
        _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 设置摄像头：前置/后置
        _imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 设置闪光模式
        _imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        
        // 4、推送图片拾取器控制器
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        
    } else {
        NSLog(@"当前设备不支持拍照");
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                  message:@"当前设备不支持拍照"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              //                                                              _uploadButton.hidden = NO;
                                                          }]];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
            
            _image = info[UIImagePickerControllerOriginalImage];;
            
            if (_index < _imgArr.count - 1) {
                
                [_imgArr replaceObjectAtIndex:_index withObject:_image];
            }else{
                
                [_imgArr addObject:_image];
            }
        }
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        
        _image = info[UIImagePickerControllerOriginalImage];
        
        if (_index < _imgArr.count) {
            
            [_imgArr replaceObjectAtIndex:_index withObject:_image];
        }else{
            
            [_imgArr addObject:_image];
        }
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.authenColl reloadData];
        
    }];
}

// 用户点击了取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)initUI{
    
    self.titleLabel.text = @"完善客户信息";
    self.navBackgroundView.hidden = NO;
    
    _scrolleView = [[UIScrollView alloc] init];
    _scrolleView.backgroundColor = YJBackColor;
    _scrolleView.bounces = NO;
    [self.view addSubview:_scrolleView];
    
    _infoView = [[UIView alloc] init];
    _infoView.backgroundColor = CH_COLOR_white;
    [_scrolleView addSubview:_infoView];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(313 *SIZE, 289 *SIZE, 25 *SIZE, 25 *SIZE);
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
    [_infoView addSubview:_addBtn];
    
    for(int i = 0; i < 7; i++){
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _nameL = label;
                _nameL.text = @"客户:";
                [_infoView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _intentionL = label;
                _intentionL.text = @"购房意向度:";
                [_infoView addSubview:_intentionL];
                break;
            }
            case 2:
            {
                _urgentL = label;
                _urgentL.text = @"购房紧迫度:";
                [_infoView addSubview:_urgentL];
                break;
            }
            case 3:
            {
                _phoneL = label;
                _phoneL.text = @"联系号码:";
                [_infoView addSubview:_phoneL];
                break;
            }
            case 4:
            {
                _identifyL = label;
                _identifyL.text = @"证件类型:";
                [_infoView addSubview:_identifyL];
                break;
            }
            case 5:
            {
                _codeL = label;
                _codeL.text = @"证件号:";
                [_infoView addSubview:_codeL];
                break;
            }
            case 6:
            {
                _collL = label;
                _collL.text = @"身份证照片:";
                [_infoView addSubview:_collL];
                break;
            }
            default:
                break;
        }
        
        if (i < 2) {
            
            DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            btn.tag = i;
            [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
            switch (i) {
                case 0:
                {
                    BorderTF *TF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
                    TF.textfield.text = _name;
                    _nameTF = TF;
//                    _nameBtn = btn;
                    [_infoView addSubview:_nameTF];
                    break;
                }
                case 1:
                {
                    _identifyBtn = btn;
                    [_infoView addSubview:_identifyBtn];
                    break;
                }
                default:
                    break;
            }
        }
        
        if (i < 6) {
            
            BorderTF *TF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            switch (i) {
                case 0:
                {
                    _intentionTF = TF;
                    _intentionTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                    [_infoView addSubview:_intentionTF];
                    break;
                }
                case 1:
                {
                    _urgentTF = TF;
                    _urgentTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                    [_infoView addSubview:_urgentTF];
                    break;
                }
                case 2:
                {
                    _phoneTF1 = TF;
                    _phoneTF1.textfield.keyboardType = UIKeyboardTypePhonePad;
                    _phoneTF1.frame = CGRectMake(0, 0, 217 *SIZE, 33 *SIZE);
                    [_infoView addSubview:_phoneTF1];
                    break;
                }
                case 3:
                {
                    _phoneTF2 = TF;
                    _phoneTF2.textfield.keyboardType = UIKeyboardTypePhonePad;
                    _phoneTF2.hidden = YES;
                    [_infoView addSubview:_phoneTF2];
                    break;
                }
                case 4:
                {
                    _phoneTF3 = TF;
                    _phoneTF3.textfield.keyboardType = UIKeyboardTypePhonePad;
                    _phoneTF3.hidden = YES;
                    [_infoView addSubview:_phoneTF3];
                    break;
                }
                case 5:
                {
                    _codeTF = TF;
                    _codeTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
                    [_infoView addSubview:_codeTF];
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
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 91 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _authenColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, 91 *SIZE) collectionViewLayout:_flowLayout];
    _authenColl.backgroundColor = CH_COLOR_white;
    _authenColl.delegate = self;
    _authenColl.dataSource = self;
    
    [_authenColl registerClass:[AuthenCollCell class] forCellWithReuseIdentifier:@"AuthenCollCell"];
    [_infoView addSubview:_authenColl];
    
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    _nextBtn.layer.cornerRadius = 2 *SIZE;
    _nextBtn.clipsToBounds = YES;
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
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
        make.bottom.equalTo(_nextBtn.mas_top).offset(-40 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_infoView).offset(31 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(12 *SIZE));
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_infoView).offset(21 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_intentionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(40 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(12 *SIZE));
    }];
    
    [_intentionTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
        make.bottom.equalTo(_intentionSlider.mas_top).offset(-24 *SIZE);
    }];
    
    [_intentionSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_intentionTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(327 *SIZE));
        make.height.equalTo(@(5 *SIZE));
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_intentionSlider.mas_bottom).offset(44 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(11 *SIZE));
    }];

    [_urgentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_intentionSlider.mas_bottom).offset(33 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_urgentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_urgentTF.mas_bottom).offset(28 *SIZE);
        make.width.equalTo(@(327 *SIZE));
        make.height.equalTo(@(5 *SIZE));
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_urgentSlider.mas_bottom).offset(50 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_phoneTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_urgentSlider.mas_bottom).offset(40 *SIZE);
        make.width.equalTo(@(217 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_identifyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_phoneTF1.mas_bottom).offset(31 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_identifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_phoneTF1.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_identifyBtn.mas_bottom).offset(32 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];

    
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(81 *SIZE);
        make.top.equalTo(_identifyBtn.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_collL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_codeTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_authenColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(0 *SIZE);
        make.top.equalTo(_codeTF.mas_bottom).offset(58 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(91 *SIZE));
        make.bottom.equalTo(_infoView.mas_bottom).offset( -32 *SIZE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrolleView).offset(22 *SIZE);
        make.top.equalTo(_infoView.mas_bottom).offset(40 *SIZE);
        make.right.equalTo(_scrolleView).offset(-22 *SIZE);
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrolleView.mas_bottom).offset(-51 *SIZE);
    }];
    
}

@end
