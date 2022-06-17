//
//  MinePageVC.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

//此类为我界面的VC

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MinePageVCDelegate <NSObject>
///退出
- (void)logout;

@end

@interface MinePageVC : UIViewController

@property (nonatomic, weak) id<MinePageVCDelegate> minePageDelegate;

@end

NS_ASSUME_NONNULL_END
