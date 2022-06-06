//
//  SKKImageZoom.h
//  放大图片与保存Demo
//
//  Created by 宋开开 on 2022/5/27.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SKKImageZoomDelegate <NSObject>

- (void)saveAlertControllerAppear:(UIAlertController *)alertController;

@end

@interface SKKImageZoom : NSObject 

@property (nonatomic, weak)id <SKKImageZoomDelegate> sKKDelegate;

///单例
+ (instancetype)shareInstance;

/// 接收image
/// @param contentImageView 接收到的图片
- (void)imageZoomWithImageView:(UIImageView *)contentImageView;



@end

NS_ASSUME_NONNULL_END
