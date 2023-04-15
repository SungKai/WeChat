//
//  AvatarDatabase.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/14.
//

// 此工具类为储存头像的数据库
#import <Foundation/Foundation.h>
@class AvatarDatabase;
NS_ASSUME_NONNULL_BEGIN

@interface AvatarDatabaseManager : NSObject

/// 单例
+ (instancetype)shareInstance;

///获取数据库路径
+ (NSString *)wcdbFilePath;

/// 创建数据库
- (BOOL)creatWCDB;

/// 增加或修改信息
- (BOOL)insertOrUpdateData:(AvatarDatabase *)avatarData;

/// 查找信息（唯一：即图片信息）
- (NSData *)getAvatarInformation;

@end


@interface AvatarDatabase : NSObject

/// 唯一的图片信息
@property (nonatomic) NSData *avatarData;

@end

NS_ASSUME_NONNULL_END
