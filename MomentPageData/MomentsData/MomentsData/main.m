//
//  main.m
//  MomentsData
//
//  Created by 宋开开 on 2022/5/30.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSArray *momentsArray = @[
            @{
                @"person" : @"Carasuma乌丸莲耶",
                @"avatar" : @"M1.1",
                @"text" : @"最近听说组织内部有奸细，我决定谁把他揪出来，奖给谁一辆空调车！",
                @"images" : @[@"M1.2"],
                @"time" : @"昨天",
                @"likes" : @[@"Gin", @"Vodka", @"Rum",@"Bourbon", @"Chianti", @"korn", @"Kir"],
                @"comments" : @[@"Gin : 谁tm都别给我抢,这个奖我要定了",
                                @"Vodka : 大哥四季黑色长大衣不容易的!"]
            },
            @{
                @"person" : @"Gin",
                @"avatar" : @"M2.1",
                @"text" : @"我能怎么办？在线等，急！",
                @"images" : @[@"M2.2"],
                @"time" : @"昨天",
                @"likes" : @[@"Bourbon", @"Kir"],
                @"comments" : @[@"Vodka : 大哥别怕还有我！！！",
                                @"Gin : ......"]
            },
            @{
                @"person" : @"铃木园子",
                @"avatar" : @"M3.1",
                @"text" : @"这波模仿给个十分不过分吧，u1s1大叔笑得太ws了",
                @"images" : @[@"M3.2.1", @"M3.2.2"],
                @"time" : @"10 : 38",
                @"likes" : @[ ],
                @"comments" : @[@"江户川柯南 : 这不是大叔在见到洋子小姐，吹nb的时候笑的吗"]
            },
            @{
                @"person" : @"江户川柯南",
                @"avatar" : @"M4.1",
                @"text" : @"排除所有不可能的，剩下的那个即使再不可思议，那也是事实。-- 福尔摩斯。没有完美的犯罪，而侦探就是得在细节当中，找到犯罪的关键性证据。",
                @"images" : @[@"M4.2"],
                @"time" : @"15 : 10",
                @"likes" : @[@"江户川柯南", @"小兰"],
//                @"likes" : @[ ],
                @"comments" : @[@"小兰 : 你呀，和新一一样，眼里就只有福尔摩斯"]
            }
        ];
        BOOL flag = [momentsArray writeToFile:@"/Users/songjiaming/Documents/GitHub/WeChat/MomentPageData/momentData.plist" atomically:YES];
        if (flag) {
            NSLog(@"测试数据写入成功");
        }
    }
    return 0;
}
