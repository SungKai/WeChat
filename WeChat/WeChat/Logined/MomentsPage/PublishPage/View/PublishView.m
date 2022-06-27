//
//  PublishView.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/6.
//

#import "PublishView.h"

//View
#import "PublishCollectionViewCell.h"
#import "PublishCollectionView.h"
//Tool
#import "Masonry.h"
#import <PhotosUI/PHPicker.h>

@interface PublishView () <
UITextViewDelegate,
PublishCollectionViewDelegate,
PHPickerViewControllerDelegate
>

@property (nonatomic, strong) PublishCollectionView *publishCV;
///文本编辑框
@property (nonatomic, strong) UITextView *textView;

///当文本编辑框内的默认内容
@property (nonatomic, strong) UILabel *defaultLab;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *publishBtn;

@property (nonatomic, strong) UIImage *plusImage;


@end


@implementation PublishView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
        self.imageIsNine = NO;
        self.photosArray = [[NSMutableArray alloc]initWithCapacity:9];
        self.plusImage = [UIImage imageNamed:@"plus"];
        [self addView];
        [self setPosition];
    }
    return self;
}

#pragma mark - Method
- (void)addView {
    [self addSubview:self.cancelBtn];
    [self addSubview:self.publishBtn];
    [self addSubview:self.textView];
    [self addSubview:self.publishCV];
}
///取消
- (void)cancelEdit {
    if (!(self.textView.text.length == 0 && self.photosArray.count == 1)){
        //弹窗
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出编辑" message:@"您想保存已编辑的内容吗" preferredStyle:UIAlertControllerStyleAlert];
        //保存数据
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSMutableArray *ma = [NSMutableArray array];
            NSData *data = [[NSData alloc] init];
            for (int i = 0; i < self.photosArray.count; i++) {
                data = UIImagePNGRepresentation(self.photosArray[i]);
                [ma addObject:data];
            }
            [self.publishViewDelegate SaveCacheText:self.textView.text Images:ma];
        }];
        //不保存数据
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.publishViewDelegate deleteCacheText];
        }];
        //添加弹窗操作
        [alert addAction:yes];
        [alert addAction:no];
        //展示弹窗
        [self.publishViewDelegate showPopView:alert];
    }else {  //直接退出
        [self.publishViewDelegate deleteCacheText];
    }
}
 
///发布
- (void)publishEdit {
    NSLog(@"点击发布");
    [self.publishViewDelegate publishData:self.textView.text ImageArray:self.photosArray ImageIsNine:self.imageIsNine];
}

/// 拿到缓存数据
/// @param cacheData 缓存数据
- (void)getCacheData:(MomentsModel *)cacheData {
    self.text = cacheData.text;
    self.textView.text = self.text;
    
    if (cacheData.images != nil) {
        //把NSData转换成UIImage
        NSMutableArray *ma = [NSMutableArray array];
        for (int i = 0; i < cacheData.images.count; i++) {
            UIImage *image = [UIImage imageWithData:cacheData.images[i]];
            [ma addObject:image];
        }
        self.photosArray = ma;
    }
    self.publishCV.photosArray = self.photosArray;
//    [self.publishCV reloadData];
    [self setData];
}
///设置初始数据
- (void)setData {
    //没有图片时
    if (self.photosArray.count != 1) {
        if (self.photosArray.count == 0) {
            [self.photosArray addObject:self.plusImage];
        }else {
            self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
            self.publishBtn.enabled = YES;
        }
    }
    self.publishCV.photosArray = self.photosArray;
    
    //没有文本内容时
    if (self.textView.text.length == 0) {
        [self.textView addSubview:self.defaultLab];
        //self.defaultLab
        [self.defaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.textView);
            make.size.mas_equalTo(CGSizeMake(200, 30));
        }];
        if (self.photosArray.count == 0) {
            self.publishBtn.backgroundColor = [UIColor lightGrayColor];
            self.publishBtn.enabled = NO;
        }
    }else {
        self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
        self.publishBtn.enabled = YES;
    }
    [self.publishCV reloadData];
   
}
///设置位置
- (void)setPosition {
    //self.cancelBtn
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40);
        make.left.equalTo(self).offset(25);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    //self.publishBtn
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelBtn);
        make.right.equalTo(self).offset(-25);
        make.size.equalTo(self.cancelBtn);
    }];
    //self.textView
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelBtn.mas_bottom).offset(30);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.height.mas_equalTo(100);
    }];
}

#pragma mark - Delegate
// MARK: <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView{
    //文本为0
    if (self.textView.text.length == 0) {
        //发布按钮不可用，为灰色
        self.publishBtn.backgroundColor = [UIColor grayColor];
        self.publishBtn.enabled = NO;
    }else{
        //发布按钮可用，为绿色
        self.publishBtn.enabled = YES;
        self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
        self.defaultLab.hidden = YES;
    }
}
// MARK: <PublishCollectionViewDelegate>
- (void)chosePhotos:(NSIndexPath *)indexPath Image:(UIImage *)image{
    if (indexPath.item == 0 && self.photosArray.count <= 9 && image == self.plusImage) {
        PHPickerConfiguration *picker = [[PHPickerConfiguration alloc] init];
        picker.selectionLimit = 9;
        picker.filter = [PHPickerFilter imagesFilter];
        //安装配置
        PHPickerViewController *pVC = [[PHPickerViewController alloc] initWithConfiguration:picker];
        pVC.delegate = self;
//        show
        [self.publishViewDelegate showPHPicker:pVC];
    }
}

// MARK: PHPickerViewControllerDelegate
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results{
    [picker dismissViewControllerAnimated:YES completion:nil];
    for (PHPickerResult *result in results) {
        [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id <NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
            if ([object isKindOfClass:[UIImage class]]) {
                //更新
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (object) {
                        self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
                        self.publishBtn.enabled = YES;
                    }
                    //把图片加载到数组中
                    [self.photosArray addObject:object];
                    self.publishCV.photosArray = self.photosArray;
                    //用于判断是否为9张选择的照片
                    if (self.photosArray.count > 9) {
                        //满九宫格
                        self.imageIsNine = YES;
                        [self.photosArray removeObject:self.photosArray.firstObject];
                    }
                    [self.publishCV reloadData];
                });
            }
        }];
    }

}

#pragma mark - Getter
- (PublishCollectionView *)publishCV {
    if (_publishCV == nil) {
        _publishCV = [[PublishCollectionView alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _publishCV.publishCVDelegate = self;
        _publishCV.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
    }
    return _publishCV;
}
- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
        _textView.delegate = self;
    }
    return _textView;
}

- (UILabel *)defaultLab {
    if (_defaultLab == nil) {
        _defaultLab = [[UILabel alloc] init];
        _defaultLab.text = @"这一刻的想法...";
        _defaultLab.textColor = [UIColor colorNamed:@"#B3B3B3'00^#5D5D5D'00"];
        _defaultLab.font = [UIFont systemFontOfSize:20];
    }
    return _defaultLab;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorNamed:@"#181818'00^#CFCFCF'00"] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_cancelBtn addTarget:self action:@selector(cancelEdit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)publishBtn {
    if (_publishBtn == nil) {
        _publishBtn = [[UIButton alloc] init];
        [_publishBtn setTitle:@"发布" forState:UIControlStateNormal];
        _publishBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _publishBtn.layer.masksToBounds = YES;
        _publishBtn.layer.cornerRadius = 5;
        [_publishBtn setBackgroundColor:[UIColor colorNamed:@"#FEFEFE'00^#191919'00"]];
        [_publishBtn addTarget:self action:@selector(publishEdit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
}
@end
