//
//  Publish+WCTTableCoding.h
//  WCDB——Demo
//
//  Created by 宋开开 on 2022/5/26.
//



#import "Publish.h"
#import <WCDB/WCDB.h>

@interface Publish (WCTTableCoding) <WCTTableCoding>
WCDB_PROPERTY(published)
WCDB_PROPERTY(text)
WCDB_PROPERTY(imageData)
@end


