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
        self.photosArray = [[NSMutableArray alloc]initWithCapacity:9];
//        self.plusImage = [[UIImage alloc] init];
        self.plusImage = [UIImage imageNamed:@"plus"];
//        [self setData];
        [self addView];

//        }
        [self setPosition];
//        [self setData];
//      //没有图片时
        if (self.photosArray.count == 0) {
    //        UIImage *plusImage = [[UIImage alloc] init];
    //        plusImage = [UIImage imageNamed:@"plus"];
            [self.photosArray addObject:self.plusImage];
        }
        //没有文本内容时
        if (self.textView.text.length == 0) {
            [self.textView addSubview:self.defaultLab];
            self.publishBtn.backgroundColor = [UIColor lightGrayColor];
            self.publishBtn.enabled = NO;
        }else {
            self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
            self.publishBtn.enabled = YES;
        }
        self.publishCV.photosArray = self.photosArray;
        [self.publishCV reloadData];
        //
//        [self.collectionView reloadData];
    }
    return self;
}

#pragma mark - Method
- (void)addView {
    [self addSubview:self.cancelBtn];
    [self addSubview:self.publishBtn];
    [self addSubview:self.textView];
//    [self addSubview:self.collectionView];
    [self addSubview:self.publishCV];
    [self.textView addSubview:self.defaultLab];
    
//    [self.photosArray addObject:plusImage];
}
///取消
- (void)cancelEdit {
    if (!(self.textView.text.length == 0 && self.photosArray.count == 0)){
        //弹窗
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出编辑" message:@"您想保存已编辑的内容吗" preferredStyle:UIAlertControllerStyleAlert];
        //保存数据
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSData *data = [[NSData alloc] init];
            for (int i = 0; i < self.photosArray.count; i++) {
                data = UIImagePNGRepresentation(self.photosArray[i]);
            }
            [self.publishViewDelegate SaveCacheText:self.textView.text Images:data];
            //得到当前数据
//            [self.navigationController popViewControllerAnimated:YES];
//            self.navigationController.navigationBar.hidden = NO;
//            self.tabBarController.tabBar.hidden = NO;
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
//        [self presentViewController:alert animated:YES completion:nil];
        
    }
}
 
///发布
- (void)publishEdit {
    
}

/// 拿到缓存数据
/// @param cacheData 缓存数据
- (void)getCacheData:(MomentsModel *)cacheData {
    self.text = cacheData.text;
    self.photosArray = cacheData.images;
    self.publishCV.photosArray = self.photosArray;
    [self.publishCV reloadData];
//    [self setData];
}
///设置初始数据
- (void)setData {
    //没有图片时
    if (self.photosArray.count == 0) {
//        UIImage *plusImage = [[UIImage alloc] init];
//        plusImage = [UIImage imageNamed:@"plus"];
        [self.photosArray addObject:self.plusImage];
    }
    //没有文本内容时
    if (self.textView.text.length == 0) {
        [self.textView addSubview:self.defaultLab];
        self.publishBtn.backgroundColor = [UIColor lightGrayColor];
        self.publishBtn.enabled = NO;
    }else {
        self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
        self.publishBtn.enabled = YES;
    }
    self.publishCV.photosArray = self.photosArray;
//    [self addSubview:self.collectionView];
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
    //self.defaultLab
    [self.defaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.textView);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
}

#pragma mark - collectionView数据源
//有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{  //个数
//    NSLog(@"self.photosArray.count = %lu", self.photosArray.count);
//    return self.photosArray.count;
    return 1;
}
//- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//    PublishCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"publishCell" forIndexPath:indexPath];
//    cell.imgView.image = self.photosArray[indexPath.row];
//    return cell;
//}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PublishCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"publishCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PublishCollectionViewCell alloc] initWithFrame:CGRectMake(30, 30, 200, 300)];
        cell.imgView.image = self.photosArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - Delegate
// MARK: <UICollectionViewDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}
//点击添加照片
//点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        PHPickerConfiguration *picker = [[PHPickerConfiguration alloc] init];
        picker.selectionLimit = 9;
        picker.filter = [PHPickerFilter imagesFilter];
        //安装配置
        PHPickerViewController *pVC = [[PHPickerViewController alloc] initWithConfiguration:picker];
        
        pVC.delegate = self;
        //show
//        [self presentViewController:pVC animated:YES completion:nil];
    }
}

// MARK: PHPickerViewControllerDelegate
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results{
    [picker dismissViewControllerAnimated:YES completion:nil];

    for (PHPickerResult *result in results) {
        [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id <NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
            //如果结果的类型是UIImage
            if ([object isKindOfClass:[UIImage class]]) {
               //获取主线程（更新UI）
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (object) {
                        self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
                        self.publishBtn.enabled = YES;
                    }
                    //把图片加载到数组中
                    [self.photosArray addObject:object];
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
    }
    return _publishCV;
}
- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor yellowColor];
//        _textView.frame = CGRectMake(20, 100, SCREEN_WIDTH - 40, 170);
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
