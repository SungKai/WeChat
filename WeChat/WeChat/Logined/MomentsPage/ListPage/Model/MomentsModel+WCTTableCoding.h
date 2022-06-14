//
//  MomentsModel+WCTTableCoding.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/7.
//

#import "MomentsModel.h"
#import <WCDB/WCDB.h>


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

