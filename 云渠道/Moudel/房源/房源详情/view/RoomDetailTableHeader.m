//
//  RoomDetailTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableHeader.h"

@interface RoomDetailTableHeader()<UIScrollViewDelegate>
{
    
    NSInteger _num;
    NSInteger _nowNum;
}

@end

@implementation RoomDetailTableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setImgArr:(NSMutableArray *)imgArr{
    
    _imgArr = [NSMutableArray arrayWithArray:imgArr];
    _num = imgArr.count;
    if (imgArr.count) {
        
        _numL.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)imgArr.count];
    }else{
        
        _numL.text = @"0/0";
    }
    
    
    [_imgScroll setContentSize:CGSizeMake(imgArr.count *SCREEN_Width, 183 *SIZE)];
    for (UIView *view in _imgScroll.subviews) {
        
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < imgArr.count; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, 183 *SIZE)];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_Net,imgArr[i][@"img_url"]]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
            if (error) {
                
                img.image = [UIImage imageNamed:@""];
            }
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionImgBtn)];
        [img addGestureRecognizer:tap];
        img.userInteractionEnabled = YES;
        [_imgScroll addSubview:img];
    }
}

- (void)setModel:(RoomDetailModel *)model{
    
    _titleL.text = model.absolute_address;
    _statusL.text = [NSString stringWithFormat:@"%@",model.sale_state];
    
    NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
    NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",11]];
    NSArray *tempArr = dic[@"param"];
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    NSArray *subArr = [model.project_tags componentsSeparatedByString:@","];
    for (int i = 0; i < subArr.count; i++) {
        
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if ([obj[@"id"] integerValue] == [subArr[i] integerValue]) {
                
                [arr addObject:obj[@"param"]];
                *stop = YES;
            }
        }];
    }

    _wuyeview = [[TagView alloc]initWithFrame:CGRectMake(10 *SIZE, 216 *SIZE, 200*SIZE, 20 *SIZE) DataSouce:model.property_type type:@"0"];
    [self.contentView addSubview:_wuyeview];
    
    _tagview = [[TagView alloc]initWithFrame:CGRectMake(10 *SIZE, 245 *SIZE, 200 *SIZE, 20 *SIZE) DataSouce:arr type:@"1"];
    [self.contentView addSubview:_tagview];
    
//    _addressL.text =
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价 ￥%@/㎡",model.average_price]];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, 3)];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 *SIZE] range:NSMakeRange(3, 1)];
    [attr addAttribute:NSForegroundColorAttributeName value:YJContentLabColor range:NSMakeRange(0, 3)];
    _priceL.attributedText = attr;
}

- (void)ActionAttentBtn:(UIButton *)btn{
    
    
}

- (void)ActionImgBtn{
    
    if (self.imgBtnBlock) {
        
        if (_imgArr.count) {
            
            self.imgBtnBlock(_num, _imgArr);
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _nowNum = scrollView.contentOffset.x / SCREEN_Width;
    _numL.text = [NSString stringWithFormat:@"%.0f/%ld",(scrollView.contentOffset.x / SCREEN_Width) + 1, (long)_num];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    _imgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 183 *SIZE)];
    _imgScroll.pagingEnabled = YES;
    _imgScroll.delegate = self;
    _imgScroll.showsVerticalScrollIndicator = NO;
    _imgScroll.showsHorizontalScrollIndicator = NO;
    _imgScroll.backgroundColor = YJGreenColor;
    [self.contentView addSubview:_imgScroll];
    
//    _ImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _ImgBtn.frame = CGRectMake(0, 0, SCREEN_Width, 183 *SIZE);
//    [_ImgBtn addTarget:self action:@selector(ActionImgBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_ImgBtn];
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(319 *SIZE, 144 *SIZE, 30 *SIZE, 30 *SIZE)];
    _numL.backgroundColor = COLOR(255, 255, 255, 0.6);
    _numL.textColor = YJTitleLabColor;
    _numL.font = [UIFont systemFontOfSize:10 *SIZE];
    _numL.textAlignment = NSTextAlignmentCenter;
    _numL.layer.cornerRadius = 15 *SIZE;
    _numL.clipsToBounds = YES;
    _numL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_numL];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 11 *SIZE + CGRectGetMaxY(_imgScroll.frame), 280 *SIZE, 13 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(321 *SIZE, 11 *SIZE + CGRectGetMaxY(_imgScroll.frame), 30 *SIZE, 12 *SIZE)];
    _statusL.textColor = COLOR(27, 152, 255, 1);
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentBtn.frame = CGRectMake(326 *SIZE, 28 *SIZE + CGRectGetMaxY(_imgScroll.frame), 29 *SIZE, 29 *SIZE);
    [_attentBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setImage:[UIImage imageNamed:@"Focus"] forState:UIControlStateNormal];
    [self.contentView addSubview:_attentBtn];
    
    _attentL = [[UILabel alloc] initWithFrame:CGRectMake(269 *SIZE, 32 *SIZE + CGRectGetMaxY(_imgScroll.frame), 80 *SIZE, 12 *SIZE)];
    _attentL.textColor = YJContentLabColor;
    _attentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _attentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_attentL];
    
    _payL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 100 *SIZE + CGRectGetMaxY(_imgScroll.frame), 300 *SIZE, 12 *SIZE)];
    _payL.textColor = YJContentLabColor;
    _payL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_payL];
    
    
    _priceL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 123 *SIZE + CGRectGetMaxY(_imgScroll.frame), 280 *SIZE, 17 *SIZE)];
    _priceL.textColor = COLOR(250, 70, 70, 1);
    _priceL.font = [UIFont systemFontOfSize:16 *SIZE];
    [self.contentView addSubview:_priceL];
    
    UIImageView *addressImg = [[UIImageView alloc] initWithFrame:CGRectMake(11 *SIZE, 335 *SIZE, 16 *SIZE, 16 *SIZE)];
    addressImg.image = [UIImage imageNamed:@"map"];
    [self.contentView addSubview:addressImg];
    
    _addressL = [[UILabel alloc] initWithFrame:CGRectMake(31 *SIZE, 155 *SIZE + CGRectGetMaxY(_imgScroll.frame), 300 *SIZE, 11 *SIZE)];
    _addressL.textColor = YJContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_addressL];
    
}

@end
