//
//  PublishView.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/6.
//

#import <UIKit/UIKit.h>

//Tools
#import "MomentsModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol PublishViewDelegate <NSObject>

/// 要保存的数据
/// @param text 文字
/// @param imageData 图片
- (void)SaveCacheText:(NSString *)text Images:(NSData *)imageData;

///删除缓存数据
- (void)deleteCacheText;

///展示弹窗
- (void)showPopView:(UIAlertController *)popView;

@end
@interface PublishView : UIView

@property (nonatomic, strong, nullable) NSMutableArray *photosArray;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, weak) id<PublishViewDelegate> publishViewDelegate;

/// 拿到缓存数据
/// @param cacheData 缓存数据
- (void)getCacheData:(MomentsModel *)cacheData;

///设置初始数据
- (void)setData;

@end

NS_ASSUME_NONNULL_END
