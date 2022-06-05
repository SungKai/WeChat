//
//  main.m
//  MinePageData
//
//  Created by 宋开开 on 2022/6/4.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSArray *minePageArray = @[
                  @{@"image" : @"p0",
                    @"title" : @"服务"},
                  @{@"image" : @"p1",
                    @"title" : @"收藏"},
                  @{@"image" : @"p2",
                    @"title" : @"朋友圈"},
                  @{@"image" : @"p3",
                    @"title" : @"卡包"},
                  @{@"image" : @"p4",
                    @"title" : @"表情"}
        ];
        BOOL flag = [minePageArray writeToFile:@"/Users/songjiaming/Documents/GitHub/WeChat/MinePageData/minePageData.plist" atomically:YES];
        if (flag) {
            NSLog(@"数据写入成功");
        }
    }
    return 0;
}
