//
//  PublishCollectionView.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/12.
//

#import <UIKit/UIKit.h>
#import "PublishCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PublishCollectionView : UICollectionView <
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>
@property (nonatomic, strong, nullable) NSMutableArray *photosArray;

@end

NS_ASSUME_NONNULL_END
