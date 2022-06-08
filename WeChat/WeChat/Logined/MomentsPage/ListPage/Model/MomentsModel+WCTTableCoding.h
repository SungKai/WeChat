//
//  MomentsModel+WCTTableCoding.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/7.
//

#import "MomentsModel.h"
#import <WCDB/WCDB.h>

/*
 ///判断内容是否已发布
 @property (nonatomic) BOOL published;

 @property (nonatomic, copy) NSString *person;

 @property (nonatomic, copy) NSString *avatar;

 @property (nonatomic, copy) NSString *text;

 @property (nonatomic, strong) NSArray *images;

 @property (nonatomic, copy) NSString *time;

 @property (nonatomic, strong) NSMutableArray *likes;

 @property (nonatomic, strong) NSMutableArray *comments;

 */
@interface MomentsModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(published)
WCDB_PROPERTY(person)
WCDB_PROPERTY(avatar)
WCDB_PROPERTY(text)
WCDB_PROPERTY(images)
WCDB_PROPERTY(time)
WCDB_PROPERTY(likes)
WCDB_PROPERTY(comments)


@end

