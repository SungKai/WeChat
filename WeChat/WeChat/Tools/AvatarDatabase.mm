//
//  AvatarDatabase.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/14.
//

#import "AvatarDatabase.h"
#import "AvatarDatabase+WCTTableCoding.h"
#define AvatarTableName @"avatar"

@implementation AvatarDatabase

WCDB_IMPLEMENTATION(AvatarDatabase)
WCDB_SYNTHESIZE(AvatarDatabase, avatarData)

@end

@interface AvatarDatabaseManager () {
    WCTDatabase *dataBase;
}

@end

@implementation AvatarDatabaseManager

/// 单例
+ (instancetype)shareInstance {
    static AvatarDatabaseManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AvatarDatabaseManager alloc]init];
    });
    return instance;
}

/// 获取数据库路径
+ (NSString *)wcdbFilePath {
    NSString *rootFilePath = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath = [rootFilePath stringByAppendingPathComponent:@"Avatar.db"];
    return dbFilePath;
}

// MARK: 创建数据库
- (BOOL)creatWCDB {
    dataBase = [[WCTDatabase alloc] initWithPath:[AvatarDatabaseManager wcdbFilePath]];
    if ([dataBase canOpen]) {
        if ([dataBase isOpened]) {
            if ([dataBase isTableExists:AvatarTableName]) {
                NSLog(@"表格已存在");
                return NO;
            }else {
                return [dataBase createTableAndIndexesOfName:AvatarTableName withClass:AvatarDatabase.class];
            }
        }
    }
    return NO;
}

///增加或修改信息
- (BOOL)insertOrUpdateData:(AvatarDatabase *)avatarData {
    if (avatarData == nil) {
        return NO;
    }
    if (dataBase == nil) {
        [self creatWCDB];
    }
    // 1.查看是否已经有头像信息了
    NSArray<AvatarDatabase *> *dataArray = [dataBase getAllObjectsOfClass:AvatarDatabase.class fromTable:AvatarTableName];
    if (dataArray.count == 0) {
        // 说明没有一行数据,需要添加
        return [dataBase insertObject:avatarData into:AvatarTableName];
    }
    // 已经有数据了，说明需要更换数据
    return [dataBase updateAllRowsInTable:AvatarTableName onProperty:AvatarDatabase.avatarData withObject:avatarData];
}

/// 查找信息（唯一：即图片信息）
- (NSData *)getAvatarInformation {
    if (dataBase == nil) {
        [self creatWCDB];
    }
    NSArray<AvatarDatabase *> *dataArray = [dataBase getAllObjectsOfClass:AvatarDatabase.class fromTable:AvatarTableName];
    NSData *imageData = dataArray.firstObject.avatarData;
    return imageData;
}

@end
