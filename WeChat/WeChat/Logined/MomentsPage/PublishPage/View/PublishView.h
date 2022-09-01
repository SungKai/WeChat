//
//  PublishView.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/6.
//

//此类为朋友圈发布界面的View
#import <UIKit/UIKit.h>

#import "MomentsModel.h"
//Tools
#import <PhotosUI/PHPicker.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PublishViewDelegate <NSObject>

/// 要保存的数据
/// @param text 文字
/// @param imageArray 图片
- (void)SaveCacheText:(NSString *)text Images:(NSMutableArray *)imageArray;

///删除缓存数据
- (void)deleteCacheText;

/// 展示退出弹窗
/// @param popView 弹窗
- (void)showPopView:(UIAlertController *)popView;

/// 展示图片弹窗
/// @param pvc 弹窗
- (void)showPHPicker:(PHPickerViewController *)pvc;

/// 正式发表
/// @param text 文字内容
/// @param imageArray 图片组
- (void)publishData:(NSString *)text ImageArray:(NSMutableArray *)imageArray ImageIsNine:(BOOL)imageIsNine;

@end

@interface PublishView : UIView

///文本编辑框
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong, nullable) NSMutableArray *photosArray;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, weak) id<PublishViewDelegate> publishViewDelegate;

///用于判断是否为满九宫格照片
@property (nonatomic) BOOL imageIsNine;

/// 拿到缓存数据
/// @param cacheData 缓存数据
- (void)getCacheData:(MomentsModel *)cacheData;

///设置初始数据
- (void)setData;

@end

NS_ASSUME_NONNULL_END
