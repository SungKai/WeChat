//
//  popFuncView.h
//  YYLabel图文混排
//
//  Created by 宋开开 on 2022/6/2.
//

// 此类为朋友圈主界面每个cell中点击多功能按钮（评论或点赞）弹出的弹窗View
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface popFuncView : UIView

@property (nonatomic, strong) UIButton *likesBtn;

@property (nonatomic, strong) UIButton *commentsBtn;

/// 点赞和评论之间的分隔线
@property (nonatomic, strong) UIView *separator;

/// 点赞文字
@property (nonatomic, strong) UILabel *likeLab;

/// 评论文字
@property (nonatomic, strong) UILabel *commentLab;

/// 点赞爱心
@property (nonatomic, strong) UIImageView *likeImageView;

/// 评论方框图案
@property (nonatomic, strong) UIImageView *commentImageView;

@end

NS_ASSUME_NONNULL_END
