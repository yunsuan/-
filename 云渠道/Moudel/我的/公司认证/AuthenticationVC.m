//
//  AuthenticationVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AuthenticationVC.h"
#import "AuthenTableCell.h"
#import "AuthenCollCell.h"
#import "SelectCompanyVC.h"
#import "AuditStatusVC.h"

@interface AuthenticationVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
    NSMutableArray *_imgArr;
    UIImagePickerController *_imagePickerController;
    UIImage *_image;
    NSInteger _index;
    NSString *_companyId;
    NSString *_workCode;
    NSString *_role;
    NSString *_projectId;
    NSString *_department;
    NSString *_position;
    NSString *_entryTime;
    NSString *_imgUrl;
}

@property (nonatomic, strong) UICollectionView *authenColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UITextField *numTextField;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *roleL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *departL;

@property (nonatomic, strong) UILabel *positionL;

@property (nonatomic, strong) UILabel *timeL;

@end

@implementation AuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _contentArr = [[NSMutableArray alloc] init];
    _imgArr = [[NSMutableArray alloc] init];
    _titleArr = @[@"所属公司",@"工号",@"角色",@"申请项目",@"所属部门",@"职位",@"入职/申请时间"];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
}



- (void)ActionCancelBtn:(UIButton *)btn{
    [_imgArr removeObjectAtIndex:btn.tag];
    [self.authenColl reloadData];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (!_companyId) {
        
        [self showContent:@"请选择公司"];
        return;
    }
    
    if (!_workCode) {
        
        [self showContent:@"请输入工号"];
        return;
    }
    
    if (!_role) {
        
        return;
    }
    
    if (!_projectId) {
        
        return;
    }
    
    if (!_department) {
        
        return;
    }
    
    if (!_position) {
        
        return;
    }
    
    if (!_entryTime) {
        
        return;
    }
    
    if (!_imgUrl) {
        
        return;
    }
    
    [dic setObject:_companyId forKey:@"company_id"];
    [dic setObject:_role forKey:@"role"];

    
    [BaseRequest GET:AddAuthInfo_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
//    AuditStatusVC *nextVC = [[AuditStatusVC alloc] init];
//    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    [_numTextField endEditing:YES];
    switch (btn.tag) {
        case 0:
        {
            SelectCompanyVC *nextVC = [[SelectCompanyVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 1:
        {
            SelectCompanyVC *nextVC = [[SelectCompanyVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 2:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择角色" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *agent = [UIAlertAction actionWithTitle:@"经纪人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
                _role = @"1";
                _roleL.text = @"经纪人";
            }];
            
            UIAlertAction *comfirm = [UIAlertAction actionWithTitle:@"确认人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                _role = @"2";
                _roleL.text = @"确认人";
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            }];
            
            [alert addAction:agent];
            [alert addAction:comfirm];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
            break;
        }
        case 3:
        {
            if ([_role isEqualToString:@"2"]) {
                
                if (_companyId) {
                    
                    
                }else{
                    
                    [self showContent:@"请先选择公司"];
                }
            }else{
                
                [self showContent:@"只有确认人才能申请固定项目"];
            }
            break;
        }
        case 4:
        {
            SelectCompanyVC *nextVC = [[SelectCompanyVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 5:
        {
            SelectCompanyVC *nextVC = [[SelectCompanyVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 6:
        {
            SelectCompanyVC *nextVC = [[SelectCompanyVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 1;
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
            
            cell.imageView.image =[UIImage imageNamed:@"uploadphotos"];
            cell.cancelBtn.hidden = YES;
        }
    }else{
        
        cell.imageView.image =[UIImage imageNamed:@"uploadphotos"];
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
    
    self.titleLabel.text = @"认证信息填写";
    self.navBackgroundView.hidden = NO;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width, 672 *SIZE);
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    UIView *whiteView11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 361 *SIZE)];
    whiteView11.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:whiteView11];
    
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 16 *SIZE + i * 50 *SIZE, 100 *SIZE, 12 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _titleArr[i];
        [whiteView11 addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 49 *SIZE * (i + 1), SCREEN_Width, SIZE)];
        line.backgroundColor = YJBackColor;
        [whiteView11 addSubview:line];
        
        
        if (i == 1) {
            
            UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(100 *SIZE, 50 *SIZE * i, 230 *SIZE, 49 *SIZE)];
            textFiled.textAlignment = NSTextAlignmentRight;
            _numTextField = textFiled;
            [whiteView11 addSubview:_numTextField];
        }else{
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100 *SIZE, 18 *SIZE + i * 50 *SIZE, 230 *SIZE, 12 *SIZE)];
            label.textColor = YJContentLabColor;
            label.textAlignment = NSTextAlignmentRight;
            label.font = [UIFont systemFontOfSize:13 *SIZE];
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(343 *SIZE, 19 *SIZE + i * 50*SIZE, 12 *SIZE, 12 *SIZE)];
            img.image = [UIImage imageNamed:@"rightarrow"];
            [whiteView11 addSubview:img];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, i * 50 *SIZE, SCREEN_Width, 50 *SIZE);
            [button addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            switch (i) {
                case 0:
                {
                    _companyL = label;
                    [whiteView11 addSubview:_companyL];
                    break;
                }
                case 2:
                {
                    _roleL = label;
                    [whiteView11 addSubview:_roleL];
                    break;
                }
                case 3:
                {
                    _projectL = label;
                    [whiteView11 addSubview:_projectL];
                    break;
                }
                case 4:
                {
                    _departL = label;
                    [whiteView11 addSubview:_departL];
                    break;
                }
                case 5:
                {
                    _positionL = label;
                    [whiteView11 addSubview:_positionL];
                    break;
                }
                case 6:
                {
                    _timeL = label;
                    [whiteView11 addSubview:_timeL];
                    break;
                }
                default:
                    break;
            }
            [whiteView11 addSubview:button];
        }
    }
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(whiteView11.frame), SCREEN_Width, 174 *SIZE)];
    whiteView.backgroundColor = CH_COLOR_white;
    [_scrollView addSubview:whiteView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 100 *SIZE, 13 *SIZE)];
    label1.textColor = YJContentLabColor;
    label1.font = [UIFont systemFontOfSize:13 *SIZE];
    label1.text = @"工牌照片";
    [whiteView addSubview:label1];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 91 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _authenColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, 91 *SIZE) collectionViewLayout:_flowLayout];
    _authenColl.backgroundColor = CH_COLOR_white;
    _authenColl.delegate = self;
    _authenColl.dataSource = self;
    
    [_authenColl registerClass:[AuthenCollCell class] forCellWithReuseIdentifier:@"AuthenCollCell"];
    [whiteView addSubview:_authenColl];
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.frame = CGRectMake(21 *SIZE, 37 *SIZE + CGRectGetMaxY(whiteView.frame), 317 *SIZE, 40 *SIZE);
    _commitBtn.layer.masksToBounds = YES;
    _commitBtn.layer.cornerRadius = 2 *SIZE;
    _commitBtn.backgroundColor = YJLoginBtnColor;
    [_commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_commitBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_commitBtn];
}

@end
