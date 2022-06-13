//
//  MomentsMomentsModel.m
//  YYLabel图文混排
//
//  Created by 宋开开 on 2022/6/1.
//

#import "MomentsModel.h"
#import "MomentsModel+WCTTableCoding.h"
#define PublishTableName @"publish"

@implementation MomentsModel

WCDB_IMPLEMENTATION(MomentsModel)
WCDB_SYNTHESIZE(MomentsModel, published)
WCDB_SYNTHESIZE(MomentsModel, person)
WCDB_SYNTHESIZE(MomentsModel, avatar)
WCDB_SYNTHESIZE(MomentsModel, text)
WCDB_SYNTHESIZE(MomentsModel, images)
WCDB_SYNTHESIZE(MomentsModel, time)
WCDB_SYNTHESIZE(MomentsModel, likes)
WCDB_SYNTHESIZE(MomentsModel, comments)
//WCDB_PRIMARY_AUTO_INCREMENT(MomentsModel, published)

/// KVC字典转模型
/// @param dic 字典
- (instancetype)MomentsModelWithDic:(NSDictionary *)dic {
    [self setValuesForKeysWithDictionary:dic];
    return self;
}

@end

@interface MomentsModelManager () {
    WCTDatabase *dataBase;
}

@end

@implementation MomentsModelManager

///单例
+ (instancetype)shareInstance {
    static MomentsModelManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MomentsModelManager alloc]init];
    });
    return instance;
}

///获取数据库路径
+ (NSString *)wcdbFilePath {
    NSString *rootFilePath = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath = [rootFilePath stringByAppendingPathComponent:@"Moments.db"];
    NSLog(@"%@", dbFilePath);
    return dbFilePath;
}

// MARK: 创建数据库
- (BOOL)creatWCDB {
    dataBase = [[WCTDatabase alloc] initWithPath:[MomentsModelManager wcdbFilePath]];
    if ([dataBase canOpen]) {
        if ([dataBase isOpened]) {
            if ([dataBase isTableExists:PublishTableName]) {
                NSLog(@"表格已存在");
                return NO;
            }else {
                return [dataBase createTableAndIndexesOfName:PublishTableName withClass:MomentsModel.class];
            }
        }
    }
    return NO;
}

// MARK: 增加信息
- (BOOL)insertData:(MomentsModel *)publishData {
    if (publishData == nil) {
        return NO;
    }
    if (dataBase == nil) {
        [self creatWCDB];
    }
    
    return [dataBase insertObject:publishData into:PublishTableName];
}

- (BOOL)insertDatas:(NSArray<MomentsModel *> *)publishData {
    if (dataBase == nil) {
        [self creatWCDB];
    }
    return [dataBase insertObjects:publishData into:PublishTableName];
}

// MARK: 修改信息
///text
- (BOOL)updataTextData:(MomentsModel *)publishData {
    if (dataBase == nil) {
        [self creatWCDB];
    }
    //text
    return [dataBase updateRowsInTable:PublishTableName onProperty:MomentsModel.text withObject:publishData where:MomentsModel.person == publishData.person && MomentsModel.time == publishData.time];
}

///images
- (BOOL)updataImgaesData:(MomentsModel *)publishData {
    return [dataBase updateRowsInTable:PublishTableName onProperty:MomentsModel.images withObject:publishData where:MomentsModel.person == publishData.person && MomentsModel.time == publishData.time];
}

///likes
- (BOOL)updataLikesData:(MomentsModel *)publishData {
    return [dataBase updateRowsInTable:PublishTableName onProperty:MomentsModel.likes withObject:publishData where:MomentsModel.person == publishData.person && MomentsModel.time == publishData.time];
}

///comments
- (BOOL)updataCommentsData:(MomentsModel *)publishData {
    return [dataBase updateRowsInTable:PublishTableName onProperty:MomentsModel.comments withObject:publishData where:MomentsModel.person == publishData.person && MomentsModel.time == publishData.time];
}

// MARK: 删除信息
- (BOOL)deleteData {
    //删除缓存的(published == 0)
    if (dataBase == nil) {
        [self creatWCDB];
    }
    return [dataBase deleteObjectsFromTable:PublishTableName where:MomentsModel.published == 0];
}

///删除数据
//- (void)deletePublishData {
//    //删除缓存的(published == 0)
//    if (dataBase == nil) {
//        [self creatWCDB];
//    }
//    return [dataBase deleteObjectsFromTable:PublishTableName where:Publish.published == 0];
//}
// MARK: 查找缓存信息
///查看是否有缓存
- (BOOL)isCache {
    if ([dataBase getObjectsOfClass:MomentsModel.class fromTable:PublishTableName where:MomentsModel.published == 0].count != 0) {
        return YES;
    }else {
        return NO;
    }
}

- (MomentsModel *)getData {  //published == 0
    if (dataBase == nil) {
        [self creatWCDB];
    }
    return [dataBase getObjectsOfClass:MomentsModel.class fromTable:PublishTableName where:MomentsModel.published == 0].firstObject;
}

///查找到某条数据
///

// MARK: 查找已发布信息
- (NSArray<MomentsModel *> *)getAllPublishData {  //published == 1
    if (dataBase == nil) {
        [self creatWCDB];
    }
    return [dataBase getObjectsOfClass:MomentsModel.class fromTable:PublishTableName where:MomentsModel.published == 1];
}

@end
