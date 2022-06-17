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
    return [self initWithFrame:frame collectionViewLayout:layout];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.clipsToBounds = NO;
        self.dataSource = self;
        self.delegate = self;
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
    //图片宽高适配
    cell.imgView.clipsToBounds = YES;
    [cell.imgView setContentMode:UIViewContentModeScaleAspectFill];
    return cell;
}
#pragma mark - Delegete

// MARK: <UICollectionViewDelegateFlowLayout>
//点击添加照片
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了%ld", indexPath.row);
    [self.publishCVDelegate chosePhotos:indexPath];
}


@end
