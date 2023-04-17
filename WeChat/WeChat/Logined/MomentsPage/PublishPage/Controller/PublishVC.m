//
//  PublishVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/3.
//

#import "PublishVC.h"

// View
#import "PublishView.h"
#import "PublishCollectionView.h"

// Model
#import "MomentsModel.h"

// Tools
#import <PhotosUI/PHPicker.h>

#define MomentModelManager [MomentsModelManager shareInstance]

@interface PublishVC () <
    UITextViewDelegate,
    PHPickerViewControllerDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) PublishView *publishView;

@property (nonatomic, strong) PublishCollectionView *publishCV;

@property (nonatomic, strong, nullable) NSMutableArray *photosArray;

@end

@implementation PublishVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.photosArray = [[NSMutableArray alloc]initWithCapacity:9];
    // 获取缓存数据
    [self getcacheData];
    [self.view addSubview:self.publishView];
    [self.publishView addSubview:self.publishCV];
    self.publishCV.dataSource = self;
    self.publishCV.delegate = self;
    self.publishView.textView.delegate = self;
    [self addSEL];
}

#pragma mark - Method

/// 获取缓存数据
- (void)getcacheData {
    if ([MomentModelManager isCache]) {
        MomentsModel *cacheData = [MomentModelManager getData];
        // 把缓存数据传给PublishView
        self.publishView.textView.text = cacheData.text;
        
        if (cacheData.images != nil) {
            // 把NSData转换成UIImage
            NSMutableArray *ma = [NSMutableArray array];
            // 使第一张图片永远是self.plusImage
            if (cacheData.images.count < 9) {
                [ma addObject:self.publishView.plusImage];
            } else {
                [ma addObject:[UIImage imageWithData:cacheData.images[0]]];
            }
            for (int i = 1; i < cacheData.images.count; i++) {
                UIImage *image = [UIImage imageWithData:cacheData.images[i]];
                [ma addObject:image];
            }
            self.publishView.photosArray = ma;
        }
        [self.publishView setData];
        self.photosArray = self.publishView.photosArray;
    } else {  // 没有缓存数据直接设置数据
        [self.publishView setData];
        self.photosArray = self.publishView.photosArray;
    }
    [self.publishCV reloadData]; 
}

/// 点击任意一处退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.publishView.textView resignFirstResponder];
}

- (void)saveCacheText:(NSString *)text Images:(NSMutableArray *)imageArray {
    MomentsModel *cacheData = [[MomentsModel alloc] init];
    cacheData.published = 0;
    cacheData.text = text;
    cacheData.images = imageArray;
    // 1.把原来数据库里面的published == 0 的数据删除
    BOOL res = [MomentModelManager deleteData];
    if (res) {
        NSLog(@"删除成功");
    }
    // 2.换成新的数据
    BOOL res1 = [MomentModelManager insertData:cacheData];
    if (res1) {
        NSLog(@"更换成功");
    }
    // 退出
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)deleteCacheText {
    // 删除
    [MomentModelManager deleteData];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)showPopView:(UIAlertController *)popView {
    [self presentViewController:popView animated:NO completion:nil];
}

- (void)showPHPicker:(PHPickerViewController *)pvc {
    [self presentViewController:pvc animated:YES completion:nil];
}

/// 发布
- (void)publishData:(NSString *)text ImageArray:(NSMutableArray *)imageArray ImageIsNine:(BOOL)imageIsNine {
    // 把imageArray的UIImage类型转化为NSData类型
    NSMutableArray *ma = [NSMutableArray array];
    NSData *data = [[NSData alloc] init];
    if (imageArray.count != 1) {
        // 除九张照片外，其他应该去掉第0张照片
        // imageIsNine:当有8张照片时，加上加号图片，也是9张，所以需要用imageIsNine作判断，当imageIsNine == YES时，说明有真正的9张照片，imageIsNine == NO时，少于9张或为8张+加号图片
        if (imageArray.count != 9 || imageIsNine == NO) {
            for (int i = 1; i < imageArray.count; i++) {
                data = UIImagePNGRepresentation(imageArray[i]);
                [ma addObject:data];
            }
        } else {
            // 九宫格全都要
            for (int i = 0; i < imageArray.count; i++) {
                data = UIImagePNGRepresentation(imageArray[i]);
                [ma addObject:data];
            }
        }
    }
    // 回调
    self.getPublishData(text, ma);
}

- (void)chosePhotos:(NSIndexPath *)indexPath Image:(UIImage *)image {
    if (indexPath.item == 0 && self.photosArray.count <= 9 && image == self.publishView.plusImage) {
        PHPickerConfiguration *picker = [[PHPickerConfiguration alloc] init];
        picker.selectionLimit = 9;
        picker.filter = [PHPickerFilter imagesFilter];
        // 安装配置
        PHPickerViewController *pVC = [[PHPickerViewController alloc] initWithConfiguration:picker];
        pVC.delegate = self;
        [self showPHPicker:pVC];
    }
}

- (void)addSEL {
    [self.publishView.cancelBtn addTarget:self action:@selector(cancelEdit) forControlEvents:UIControlEventTouchUpInside];
    [self.publishView.publishBtn addTarget:self action:@selector(publishEdit) forControlEvents:UIControlEventTouchUpInside];
}

// MARK: SEL

/// 取消
- (void)cancelEdit {
    if (!(self.publishView.textView.text.length == 0 && self.photosArray.count == 1)){
        // 弹窗
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出编辑" message:@"您想保存已编辑的内容吗" preferredStyle:UIAlertControllerStyleAlert];
        // 保存数据
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSMutableArray *ma = [NSMutableArray array];
            NSData *data = [[NSData alloc] init];
            for (int i = 0; i < self.photosArray.count; i++) {
                data = UIImagePNGRepresentation(self.photosArray[i]);
                [ma addObject:data];
            }
            [self saveCacheText:self.publishView.textView.text Images:ma];
        }];
        // 不保存数据
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self deleteCacheText];
        }];
        // 添加弹窗操作
        [alert addAction:yes];
        [alert addAction:no];
        // 展示弹窗
        [self showPopView:alert];
    } else {  // 直接退出
        [self deleteCacheText];
    }
}
 
/// 发布
- (void)publishEdit {
    NSLog(@"点击发布");
    [self publishData:self.publishView.textView.text ImageArray:self.publishView.photosArray ImageIsNine:self.publishView.imageIsNine];
}

#pragma mark - Delegate



// MARK: <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView{
    // 文本为0
    if (self.publishView.textView.text.length == 0) {
        // 发布按钮不可用，为灰色
        self.publishView.publishBtn.backgroundColor = [UIColor lightGrayColor];
        self.publishView.publishBtn.enabled = NO;
    } else {
        // 发布按钮可用，为绿色
        self.publishView.publishBtn.enabled = YES;
        self.publishView.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
        self.publishView.defaultLab.hidden = YES;
    }
}

// MARK: PHPickerViewControllerDelegate
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results{
    [picker dismissViewControllerAnimated:YES completion:nil];
    for (PHPickerResult *result in results) {
        [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id <NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
            if ([object isKindOfClass:[UIImage class]]) {
                // 更新
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (object) {
                        self.publishView.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
                        self.publishView.publishBtn.enabled = YES;
                    }
                    // 把图片加载到数组中
                    [self.photosArray addObject:object];
                    // 用于判断是否为9张选择的照片
                    if (self.photosArray.count > 9) {
                        // 满九宫格
                        self.publishView.imageIsNine = YES;
                        [self.photosArray removeObject:self.photosArray.firstObject];
                    }
                    [self.publishCV reloadData];
                });
            }
        }];
    }

}

// MARK: UICollectionViewDataSource

// 有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 每组有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"self.photosArray.count = %lu", self.photosArray.count);
    return self.photosArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PublishCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.imgView.image = self.photosArray[indexPath.row];
    // 图片宽高适配
    cell.imgView.clipsToBounds = YES;
    [cell.imgView setContentMode:UIViewContentModeScaleAspectFill];
    return cell;
}

// MARK: <UICollectionViewDelegateFlowLayout>

// 点击添加照片
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了%ld", indexPath.row);
    [self chosePhotos:indexPath Image:self.photosArray[indexPath.row]];
}



#pragma mark - Getter

- (PublishView *)publishView {
    if (_publishView == nil) {
        _publishView = [[PublishView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _publishView;
}

- (PublishCollectionView *)publishCV {
    if (_publishCV == nil) {
        _publishCV = [[PublishCollectionView alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _publishCV.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
    }
    return _publishCV;
}

@end
