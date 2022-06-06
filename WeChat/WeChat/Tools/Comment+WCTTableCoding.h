//
//  Comment+WCTTableCoding.h
//  WCDB——Demo
//
//  Created by 宋开开 on 2022/5/26.
//

#import "Comment.h"
#import <WCDB/WCDB.h>


@interface Comment (WCTTableCoding)<WCTTableCoding>
WCDB_PROPERTY(published)
WCDB_PROPERTY(text)

@end


