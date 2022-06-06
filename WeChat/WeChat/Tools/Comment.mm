//
//  Comment.m
//  WCDB——Demo
//
//  Created by 宋开开 on 2022/5/26.
//

#import "Comment.h"
#import "Comment+WCTTableCoding.h"
#define CommentTableName @"comment"

@implementation Comment
WCDB_IMPLEMENTATION(Comment)
WCDB_SYNTHESIZE(Comment, cellID)
WCDB_SYNTHESIZE(Comment, commentTextArray)
WCDB_PRIMARY_AUTO_INCREMENT(Comment, cellID)
@end

@interface CommentManager() {
    WCTDatabase *dataBase;
}
@end

@implementation CommentManager
///单例
+ (instancetype)shareInstance {
    static CommentManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CommentManager alloc]init];
    });
    return instance;
}

///获取数据库路径
+ (NSString *)wcdbFilePath {
    NSString *rootFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath = [rootFilePath stringByAppendingPathComponent:@"Comment.db"];
    return dbFilePath;
}

///创建数据库
- (BOOL)creatWCDB {
    dataBase = [[WCTDatabase alloc] initWithPath:[CommentManager wcdbFilePath]];
    if ([dataBase canOpen]) {
        if ([dataBase isOpened]) {
            if ([dataBase isTableExists:CommentTableName]) {
                NSLog(@"表格已存在");
                return NO;
            }else {
                return [dataBase createTableAndIndexesOfName:CommentTableName withClass:Comment.class];
            }
        }
    }
    return NO;
}

///增加信息
- (BOOL)insertData:(Comment *)commentData {
    if (commentData == nil) {
        return NO;
    }
    if (dataBase == nil) {
        [self creatWCDB];
    }
    return [dataBase insertObject:commentData into:CommentTableName];
}

///获得全部信息
- (NSArray<Comment *> *)getAllCommentData {
    if (dataBase == nil) {
        [self creatWCDB];
    }
    return [dataBase getAllObjectsOfClass:Comment.class fromTable:CommentTableName];
}

///获得某条特定信息
- (NSArray<Comment *> *)getOneCommentData:(NSInteger)cellID {
    return [dataBase getObjectsOfClass:Comment.class fromTable:CommentTableName where:Comment.cellID == cellID];
}

///修改数据库信息
///不用更新cellID！
///1.更新cellID   什么时候更新？当发布了新pyq时，理所应当的每个cellID随着改变
///不单是修改cellID的信息，还要应对一种情况：本来已经评论后又在后面加一条评论，这时候需要更改的是该cellID对应的Comment对象的commentTextArray
- (void)updateCellIDData {
    if (dataBase == nil) {
        [self creatWCDB];
    }
    //先取得目前数据库里面的全部数据
    NSArray *data = [self getAllCommentData];
    for (int i = 0; i < data.count; i++) {
        Comment *newCom = [[Comment alloc] init];
        newCom = data[i];
        newCom.cellID++;
        //更新
        [dataBase updateRowsInTable:CommentTableName onProperty:Comment.cellID withObject:newCom where:Comment.commentTextArray == newCom.commentTextArray];
    }
}
//2.更新commentTextArray
///修改评论信息（增加评论）
- (BOOL)updateNextComment:(NSString *)nextComment CellID:(NSInteger)cellID {
    if (dataBase == nil) {
        [self creatWCDB];
    }
    //找到这条数据
    NSArray *newArray = [NSArray array];  //newArray是装新评论内容的数组
    NSMutableArray *ma = [NSMutableArray array];
    NSArray *data = [self getOneCommentData:cellID][0].commentTextArray;
    [ma addObjectsFromArray:data];
    [ma addObject:nextComment];
    newArray = ma;
    //创建新Comment对象
    Comment *newCom = [[Comment alloc] init];
    newCom.cellID = cellID;
    newCom.commentTextArray = newArray;
    //更新它
    return [dataBase updateRowsInTable:CommentTableName onProperty:Comment.commentTextArray withObject:newCom where:Comment.cellID == cellID];
}
@end
