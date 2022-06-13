//
//  MomentsCell.h
//  YYLabel图文混排
//
//  Created by 宋开开 on 2022/6/1.
//
// some difine about [UIScreen mainScreen]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>

//Tools
#import "YYText.h"
#import "Masonry.h"
#import "SKKImageZoom.h"

NS_ASSUME_NONNULL_BEGIN
@class MomentsCell;
@protocol MomentsCellDelegate <NSObject>
@required
/// 点击了多功能按钮
/// @param cell 点到的cell
- (void)clickFuncBtn:(MomentsCell *)cell;

@end

@interface MomentsCell : UITableViewCell
//头像
@property (nonatomic, strong) UIImageView *avatarImg;
//人
@property (nonatomic, copy) NSString *nameText;
//正文文字
@property (nonatomic, copy) NSString *text;
//图片数组
@property (nonatomic, strong) NSArray *imagesArray;
//时间
@property (nonatomic, copy) NSString *dateText;
//评论或点赞的按钮(多功能按钮)
@property (nonatomic, strong) UIButton *likeOrCommentBtn;
//第一个YYLabel:处理上面的信息（无评论和点赞)
@property (nonatomic, strong) YYLabel *yyTextLab;
//点赞情况
@property (nonatomic, strong) NSMutableArray <NSString *> *likesTextArray;
//分割线
@property (nonatomic, strong) UIView *separator;
//评论情况
@property (nonatomic, strong) NSMutableArray <NSString *> *commentsTextArray;
//第二个YYLabel:处理点赞信息
@property (nonatomic, strong) YYLabel *yylikesLab;
//第二个YYLabel:处理评论信息
@property (nonatomic, strong) YYLabel *yyCommentsLab;
//只有内容的的高度
@property (nonatomic, assign) CGFloat singleHeight;
//有点赞的高度
@property (nonatomic, assign) CGFloat likesHeight;
//有评论的高度
@property (nonatomic, assign) CGFloat commentsHeight;
//cell总高度
@property (nonatomic, assign) CGFloat cellHeight;
//不包括头像在内的最大宽度
@property (nonatomic, assign) CGSize maxSize;
//评论的高度 
@property (nonatomic, assign) CGFloat singleCommentsHeight;
//查看该cell的标号，用于判断是否为自己发布的朋友圈
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, weak) id <MomentsCellDelegate> cellDelegate;

//设置数据
- (void)setAvatarImgData:(NSString *)avatarImgData NameText:(NSString *)name Text:(NSString *)text ImagesArray:(NSArray *)imagesArray DateText:(NSString *)dateText  LikesTextArray:(NSMutableArray <NSString *> *)likesTextArray CommentsTextArray:(NSMutableArray <NSString *> *)commentsTextArray Index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
