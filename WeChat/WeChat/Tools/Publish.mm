//
//  Publish.m
//  WCDB——Demo
//
//  Created by 宋开开 on 2022/5/26.
//

#import "Publish.h"
#import "Publish+WCTTableCoding.h"
#define PublishTableName @"publish"
@implementation Publish

WCDB_IMPLEMENTATION(Publish)
WCDB_SYNTHESIZE(Publish, published)
WCDB_SYNTHESIZE(Publish, text)
WCDB_SYNTHESIZE(Publish, imageData)
WCDB_PRIMARY_AUTO_INCREMENT(Publish, published)
@end

@interface PublishManager() {
    WCTDatabase *dataBase;
}

@end

@implementation PublishManager
///单例
+ (instancetype)shareInstance {
    static PublishManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PublishManager alloc]init];
    });
    return instance;
}

///获取数据库路径
+ (NSString *)wcdbFilePath {
    NSString *rootFilePath = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath = [rootFilePath stringByAppendingPathComponent:@"Publish.db"];
    NSLog(@"%@", dbFilePath);
    return dbFilePath;
}

///创建数据库
- (BOOL)creatWCDB {
    dataBase = [[WCTDatabase alloc] initWithPath:[PublishManager wcdbFilePath]];
    if ([dataBase canOpen]) {
        if ([dataBase isOpened]) {
            if ([dataBase isTableExists:PublishTableName]) {
                NSLog(@"表格已存在");
                return NO;
            }else {
                return [dataBase createTableAndIndexesOfName:PublishTableName withClass:Publish.class];
            }
        }
    }
    return NO;
}

///增加信息
- (BOOL)insertData:(Publish *)publishData {
    if (publishData == nil) {
        return NO;
    }
    if (dataBase == nil) {
        [self creatWCDB];
    }
    return [dataBase insertObject:publishData into:PublishTableName];
}

///删除信息
- (BOOL)deleteData:(Publish *)publishData {
    //删除缓存的(published == 0)
    if (dataBase == nil) {
        [self creatWCDB];
    }
    return [dataBase deleteObjectsFromTable:PublishTableName where:Publish.published == 0];
}

///查找缓存信息
- (NSArray<Publish*> *)getData {  //published == 0
    if (dataBase == nil) {
        [self creatWCDB];
    }
    return [dataBase getObjectsOfClass:Publish.class fromTable:PublishTableName where:Publish.published == 0];
}
///查找已发布信息
- (NSArray<Publish *> *)getAllPublishData {  //published == 1
    if (dataBase == nil) {
        [self creatWCDB];
    }
    return [dataBase getObjectsOfClass:Publish.class fromTable:PublishTableName where:Publish.published == 1];
}
@end
