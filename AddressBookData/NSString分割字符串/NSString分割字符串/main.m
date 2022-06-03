//
//  main.m
//  NSString分割字符串
//
//  Created by 宋开开 on 2022/6/1.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString *s = @"aaaa : dadasd";
        NSArray *array = [s componentsSeparatedByString:@":"]; //从字符A中分隔成2个元素的数组
        NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
    }
    return 0;
}
