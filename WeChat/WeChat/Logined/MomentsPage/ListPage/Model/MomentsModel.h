//
//  MomentsMomentsModel.h
//  YYLabel图文混排
//
//  Created by 宋开开 on 2022/6/1.
//

#import <Foundation/Foundation.h>
@class MomentsModel;
NS_ASSUME_NONNULL_BEGIN
@interface MomentsModelManager : NSObject
///单例
+ (instancetype)shareInstance;

///获取数据库路径
+ (NSString *)wcdbFilePath;

///创建数据库
- (BOOL)creatWCDB;

///增加信息
- (BOOL)insertData:(MomentsModel *)publishData;

- (BOOL)insertDatas:(NSArray<MomentsModel *> *)publishData;

///修改信息
///修改文本信息
- (BOOL)updataTextData:(MomentsModel *)publishData;
///修改图片信息
- (BOOL)updataImgaesData:(MomentsModel *)publishData;
///修改点赞信息
- (BOOL)updataLikesData:(MomentsModel *)publishData;
///修改评论信息
- (BOOL)updataCommentsData:(MomentsModel *)publishData;

///删除信息
- (BOOL)deleteData:(MomentsModel *)publishData;

///查找缓存信息
- (BOOL)isCache;  //查看是否有缓存

- (MomentsModel *)getData;  //published == 0

///查找已发布信息
- (NSArray<MomentsModel *> *)getAllPublishData;  //published == 1
@end

@interface MomentsModel : NSObject

///判断内容是否已发布
@property (nonatomic, assign) NSInteger published;

@property (nonatomic, copy) NSString *person;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong, nullable) NSMutableArray *images;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong, nullable) NSMutableArray *likes;

@property (nonatomic, strong, nullable) NSMutableArray *comments;

/// KVC字典转模型
/// @param dic 字典
- (instancetype)MomentsModelWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
