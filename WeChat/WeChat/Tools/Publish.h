//
//  Publish.h
//  WCDB——Demo
//
//  Created by 宋开开 on 2022/5/26.
//

//Publish是用来储存pyq发布界面的将要发布的数据的，主要有缓存和得到数据的API
#import <Foundation/Foundation.h>
@class Publish;
NS_ASSUME_NONNULL_BEGIN
@interface PublishManager : NSObject
///单例
+ (instancetype)shareInstance;

///获取数据库路径
+ (NSString *)wcdbFilePath;

///创建数据库
- (BOOL)creatWCDB;

///增加信息
- (BOOL)insertData:(Publish *)publishData;

///删除信息
- (BOOL)deleteData:(Publish *)publishData;

///查找缓存信息
- (NSArray<Publish*> *)getData;  //published == 0

///查找已发布信息
- (NSArray<Publish *> *)getAllPublishData;  //published == 1

@end

@interface Publish : NSObject

///判断内容是否已发布
@property (nonatomic) BOOL published;

///缓存的文字内容
@property (nonatomic, copy) NSString *text;

///缓存的图片内容
@property (nonatomic, strong) NSArray<NSData *> *imageData;

@end

NS_ASSUME_NONNULL_END
