//
//  MomentsCell.h
//  YYLabel图文混排
//
//  Created by 宋开开 on 2022/6/1.
//

// 此类为朋友圈主界面的VC的TableView中的cell

#import <UIKit/UIKit.h>

// Tools
#import "YYText.h"  //富文本布局工具
#import "Masonry.h"
#import "SKKImageZoom.h"  //点击图片放大保存

NS_ASSUME_NONNULL_BEGIN
@class MomentsCell;

@protocol MomentsCellDelegate <NSObject>

@required

/// 点击了多功能按钮
/// @param cell 点到的cell
- (void)clickFuncBtn:(MomentsCell *)cell;

/// 点击了删除按钮
/// @param cell 点到的cell
- (void)clickDeleteBtn:(MomentsCell *)cell;

@end

@interface MomentsCell : UITableViewCell

/// 头像
@property (nonatomic, strong) UIImageView *avatarImageView;

/// 人
@property (nonatomic, copy) NSString *nameText;

/// 正文文字
@property (nonatomic, copy) NSString *text;

/// 图片数组
@property (nonatomic, strong) NSArray *imagesArray;

/// 时间
@property (nonatomic, copy) NSString *dateText;

/// 自己发的朋友圈可以删除
@property (nonatomic, strong) UIButton *deleteBtn;

/// 评论或点赞的按钮(多功能按钮)
@property (nonatomic, strong) UIButton *likeOrCommentBtn;

/// 第一个YYLabel:处理上面的信息（无评论和点赞)
@property (nonatomic, strong) YYLabel *yyTextLab;

/// 点赞情况
@property (nonatomic, strong) NSMutableArray <NSString *> *likesTextArray;

/// 分割线
@property (nonatomic, strong) UIView *separator;

/// 评论情况
@property (nonatomic, strong) NSMutableArray <NSString *> *commentsTextArray;

/// 第二个YYLabel:处理点赞信息
@property (nonatomic, strong) YYLabel *yylikesLab;

/// 第二个YYLabel:处理评论信息
@property (nonatomic, strong) YYLabel *yyCommentsLab;

/// 只有内容的的高度
@property (nonatomic, assign) CGFloat singleHeight;

/// 有点赞的高度
@property (nonatomic, assign) CGFloat likesHeight;

/// 有评论的高度
@property (nonatomic, assign) CGFloat commentsHeight;

/// cell总高度
@property (nonatomic, assign) CGFloat cellHeight;

/// 不包括头像在内的最大宽度
@property (nonatomic, assign) CGSize maxSize;

/// 评论的高度
@property (nonatomic, assign) CGFloat singleCommentsHeight;

/// 查看该cell的标号，用于判断是否为自己发布的朋友圈
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, weak) id <MomentsCellDelegate> cellDelegate;

/// 设置数据
/// @param avatarImageViewData 头像数据
/// @param name 名字
/// @param text 正文内容
/// @param imagesArray 图片
/// @param dateText 发布时间
/// @param likesTextArray 点赞人数组
/// @param commentsTextArray 评论数组
/// @param index cell标号
- (void)setAvatarImgData:(NSString *)avatarImageViewData
                NameText:(NSString *)name
                    Text:(NSString *)text
             ImagesArray:(NSArray *)imagesArray
                DateText:(NSString *)dateText
          LikesTextArray:(NSMutableArray <NSString *> *)likesTextArray
       CommentsTextArray:(NSMutableArray <NSString *> *)commentsTextArray
                   Index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
