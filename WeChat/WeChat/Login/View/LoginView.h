//
//  LoginView.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LoginViewDelegate <NSObject>

- (void)clickLogin;

@end

@interface LoginView : UIView

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, weak) id<LoginViewDelegate> loginDelegate;

/// 创建方法
/// @param frame View尺寸
- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
