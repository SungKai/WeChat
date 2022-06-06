//
//  PublishView.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/6.
//

#import "PublishView.h"

//Tool
#import "Masonry.h"
#import <PhotosUI/PHPicker.h>

@interface PublishView () <
UIScrollViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
UITextViewDelegate,
PHPickerViewControllerDelegate
>

///九宫格照片收集
@property (nonatomic, strong) UICollectionView *collectionView;

///文本编辑框
@property (nonatomic, strong) UITextView *textView;

///当文本编辑框内的默认内容
@property (nonatomic, strong) UILabel *defaultLab;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *publishBtn;

@end


@implementation PublishView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.photosArray = [NSMutableArray array];
        //没有文本内容时
        if (self.textView.text.length == 0) {
            [self.textView addSubview:self.defaultLab];
            self.publishBtn.backgroundColor = [UIColor grayColor];
            self.publishBtn.enabled = NO;
        }else {
            self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
            self.publishBtn.enabled = YES;
        }
    }
    return self;
}

#pragma mark - Method
- (void)addView {
    [self addSubview:self.textView];
    [self addSubview:self.collectionView];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.publishBtn];
}
///取消
- (void)cancelEdit {
    
}
 
///发布
- (void)publishEdit {
    
}

#pragma mark - Delegate
// MARK: <UICollectionViewDelegate>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
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
                    [self.collectionView reloadData];
                });
            }
        }];
        
    }
}
#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        //创建布局类
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //设置最行小间距
        layout.minimumLineSpacing = 10;
        //设置最小列间距
        layout.minimumInteritemSpacing = 10;
        //设置上下左右四边距
        layout.sectionInset = UIEdgeInsetsMake(10,10,10,10);
        //设置滚动的方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(50, 200, SCREEN_WIDTH - 100, 330) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.frame = CGRectMake(20, 100, SCREEN_WIDTH - 40, 170);
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
        _cancelBtn.titleLabel.textColor = [UIColor colorNamed:@"#191919'00^#FEFEFE'00"];
        [_cancelBtn setBackgroundColor:[UIColor colorNamed:@"#FEFEFE'00^#191919'00"]];
        [_cancelBtn addTarget:self action:@selector(cancelEdit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)publishBtn {
    if (_publishBtn == nil) {
        _publishBtn = [[UIButton alloc] init];
        [_publishBtn setTitle:@"发布" forState:UIControlStateNormal];
        _publishBtn.titleLabel.textColor = [UIColor colorNamed:@"#191919'00^#FEFEFE'00"];
        [_publishBtn setBackgroundColor:[UIColor colorNamed:@"#FEFEFE'00^#191919'00"]];
        [_publishBtn addTarget:self action:@selector(publishEdit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
}
@end
