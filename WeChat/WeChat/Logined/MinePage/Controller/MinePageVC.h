//
//  MinePageVC.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MinePageVCDelegate <NSObject>

- (void)logout;

@end
@interface MinePageVC : UIViewController

@property (nonatomic, weak) id<MinePageVCDelegate> minePageDelegate;

@end

NS_ASSUME_NONNULL_END
