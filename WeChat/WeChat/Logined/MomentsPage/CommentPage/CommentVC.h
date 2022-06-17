//
//  CommentVC.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/3.
//

//此类为朋友圈评论界面的VC
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentVC : UIViewController

///信息回调
@property (nonatomic, copy)void (^getCommentsData )(NSString *commentsText);

@end

NS_ASSUME_NONNULL_END
