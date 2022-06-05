//
//  popFuncView.h
//  YYLabel图文混排
//
//  Created by 宋开开 on 2022/6/2.
//

#import <UIKit/UIKit.h>

//Tools
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN
@protocol popFuncViewDelegate <NSObject>

/// 点击点赞按钮
/// @param sender 该按钮
- (void)clickLikeBtn:(UIButton *)sender;

/// 店家评论按钮
/// @param sender 该按钮
- (void)clickCommentBtn:(UIButton *)sender;

@end
@interface popFuncView : UIView

@property (nonatomic, strong) UIButton *likesBtn;

@property (nonatomic, strong) UIButton *commentsBtn;
//点赞和评论之间的分隔线
@property (nonatomic, strong) UIView *separator;
//点赞文字
@property (nonatomic, strong) UILabel *likeLab;
//评论文字
@property (nonatomic, strong) UILabel *commentLab;
//点赞爱心
@property (nonatomic, strong) UIImageView *likeImageView;
//评论方框图案
@property (nonatomic, strong) UIImageView *commentImageView;

@property (nonatomic, weak) id <popFuncViewDelegate> popFuncViewDelegate;

@end

NS_ASSUME_NONNULL_END