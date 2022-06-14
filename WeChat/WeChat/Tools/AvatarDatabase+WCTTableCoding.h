//
//  AvatarDatabase+WCTTableCoding.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/14.
//

#import "AvatarDatabase.h"
#import <WCDB/WCDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface AvatarDatabase (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(avatarData)

@end

NS_ASSUME_NONNULL_END
