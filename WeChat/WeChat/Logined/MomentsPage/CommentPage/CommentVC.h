//
//  CommentVC.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentVC : UIViewController

///信息回调
@property (nonatomic, copy)void (^getCommentsData )(NSString *commentsText);


@end

NS_ASSUME_NONNULL_END
