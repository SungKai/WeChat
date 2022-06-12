//
//  PublishVC.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishVC : UIViewController

///返回数据
@property (nonatomic, copy) void (^getPublishData)(NSString *text, NSMutableArray *imageArray);

@end

NS_ASSUME_NONNULL_END
