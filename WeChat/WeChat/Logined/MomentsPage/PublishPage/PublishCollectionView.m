//
//  PublishCollectionView.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/12.
//

#import "PublishCollectionView.h"

@implementation PublishCollectionView

static NSString * const cellID = @"cellID";

#pragma mark - Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self.photosArray = [[NSMutableArray alloc]initWithCapacity:9];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumLineSpacing = 10; //上下间隔
    layout.minimumInteritemSpacing = 10;  //左右间隔 //可能会被强制调整,取决于UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(10, 25, 10, 25);
    //垂直滚动
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置头部视图
//    layout.headerReferenceSize = CGSizeMake(300, 300);
//    layout.itemCount = 100;
    return [self initWithFrame:frame collectionViewLayout:layout];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
//        self.backgroundColor = [UIColor systemBlueColor];
//        self.showsVerticalScrollIndicator = NO;
//        self.showsHorizontalScrollIndicator = NO;
        self.clipsToBounds = NO;
        self.dataSource = self;

        self.delegate = self;
//        self.pagingEnabled = YES;
//        self.bounces = NO;
        [self registerClass:[PublishCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return self;
}
// MARK: UICollectionViewDataSource
//有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每组有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"self.photosArray.count = %lu", self.photosArray.count);
    return self.photosArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PublishCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.imgView.image = self.photosArray[indexPath.row];
    return cell;
}
#pragma mark - Delegete

// MARK: <UICollectionViewDelegateFlowLayout>
//点击添加照片
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了%ld", indexPath.row);
    [self.publishCVDelegate chosePhotos:indexPath];
//    if (indexPath.item == 0) {
//        PHPickerConfiguration *picker = [[PHPickerConfiguration alloc] init];
//        picker.selectionLimit = 9;
//        picker.filter = [PHPickerFilter imagesFilter];
//        //安装配置
//        PHPickerViewController *pVC = [[PHPickerViewController alloc] initWithConfiguration:picker];
//        
//        pVC.delegate = self;
//        //show
////        [self presentViewController:pVC animated:YES completion:nil];
//    }
}

//// MARK: PHPickerViewControllerDelegate
//- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    for (PHPickerResult *result in results) {
//        [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id <NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
//            if ([object isKindOfClass:[UIImage class]]) {
//                //更新UI
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (object) {
//                        
////                        self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
////                        self.publishBtn.enabled = YES;
//                    }
//                    //把图片加载到数组中
////                    [self.photosArray addObject:object];
////                    [self.publishCV reloadData];
//                });
//            }
//        }];
//        
//    }
//}
@end
