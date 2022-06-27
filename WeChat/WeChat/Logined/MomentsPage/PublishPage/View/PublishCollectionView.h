//
//  PublishCollectionView.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/12.
//

//此类为朋友圈发布界面中发布图片的CollectionView
#import <UIKit/UIKit.h>
#import "PublishCollectionViewCell.h"

//Tools
#import <PhotosUI/PHPicker.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PublishCollectionViewDelegate <NSObject>

/// 点击item选择照片
/// @param indexPath item的序号
- (void)chosePhotos:(NSIndexPath *)indexPath Image:(UIImage *)image;

@end

@interface PublishCollectionView : UICollectionView <
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
PHPickerViewControllerDelegate
>

@property (nonatomic, strong, nullable) NSMutableArray *photosArray;

@property (nonatomic, weak) id <PublishCollectionViewDelegate> publishCVDelegate;

@end

NS_ASSUME_NONNULL_END
