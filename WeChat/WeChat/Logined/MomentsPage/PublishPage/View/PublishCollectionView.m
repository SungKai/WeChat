//
//  PublishCollectionView.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/12.
//

#import "PublishCollectionView.h"

@implementation PublishCollectionView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumLineSpacing = 10;  // 上下间隔
    layout.minimumInteritemSpacing = 10;  // 左右间隔 可能会被强制调整,取决于UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(10, 25, 10, 25);
    // 垂直滚动
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置头部视图
    return [self initWithFrame:frame collectionViewLayout:layout];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.clipsToBounds = NO;
        [self registerClass:[PublishCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    }
    return self;
}



@end
