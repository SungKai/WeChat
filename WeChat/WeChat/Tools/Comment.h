//
//  Comment.h
//  WCDB——Demo
//
//  Created by 宋开开 on 2022/5/26.
//

#import <Foundation/Foundation.h>
@class Comment;
NS_ASSUME_NONNULL_BEGIN
@interface CommentManager : NSObject
///单例
+ (instancetype)shareInstance;

///获取数据库路径
+ (NSString *)wcdbFilePath;

///创建数据库
- (BOOL)creatWCDB;

///增加信息
- (BOOL)insertData:(Comment *)commentData;

///获得全部信息
- (NSArray<Comment *> *)getAllCommentData;

///获得某条特定信息
- (NSArray<Comment *> *)getOneCommentData:(NSInteger)cellID;

///不用更新cellID！
///修改数据库CellID信息
- (void)updateCellIDData;

///修改评论信息（增加评论）
- (BOOL)updateNextComment:(NSString *)nextComment CellID:(NSInteger)cellID;

@end

@interface Comment : NSObject
///评论属于的朋友圈cell的记号
@property (nonatomic, assign) NSInteger cellID;

///评论内容
@property (nonatomic, strong) NSArray<NSString *> *commentTextArray;
@end

NS_ASSUME_NONNULL_END
