//
//  main.m
//  FirstPageData
//
//  Created by 宋开开 on 2022/5/28.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSArray *firstPageData = @[
            @{@"person" : @"Carasuma乌丸莲耶",
              @"text" : @"任务完成的如何？",
              @"image" : @"firstPageData0",
              @"date" : @"15:38",
              @"bell" : @0},
            @{@"person" : @"Gin",
              @"text" : @"不是说了等一下吗！！！",
              @"image" : @"firstPageData1",
              @"date" : @"10:00",
              @"bell" : @1},
            @{@"person" : @"江户川柯南",
              @"text" : @"你可是银色子弹哦，新一儿子",
              @"image" : @"firstPageData2",
              @"date" : @"10:30",
              @"bell" : @0},
            @{@"person" : @"Sherry",
              @"text" : @"Welcome~Sherry!",
              @"image" : @"firstPageData3",
              @"date" : @"10:28",
              @"bell" : @0},
            @{@"person" : @"Bourbon",
              @"text" : @"我死了，你和那位的关系就要暴露了哦",
              @"image" : @"firstPageData4",
              @"date" : @"昨天",
              @"bell" : @1},
            @{@"person" : @"Kir",
              @"text" : @"你这个卧底藏的很深呐",
              @"image" : @"firstPageData5",
              @"date" : @"昨天",
              @"bell" : @0},
            @{@"person" : @"朱蒂",
              @"text" : @"A secret makes a woman woman~",
              @"image" : @"firstPageData6",
              @"date" : @"昨天",
              @"bell" : @0},
            @{@"person" : @"Rum",
              @"text" : @"Sherry已死",
              @"image" : @"firstPageData7",
              @"date" : @"前天",
              @"bell" : @0},
            @{@"person" : @"工藤有希子",
              @"text" : @"Sharon，这回是我们赢了哦！",
              @"image" : @"firstPageData8",
              @"date" : @"前天",
              @"bell" : @0},
            @{@"person" : @"Calvados",
              @"text" : @"为什么叫我滚呀，怕我走路太累吗？555更加爱你了贝尔摩德我的宝❤️❤️❤️",
              @"image" : @"firstPageData9",
              @"date" : @"前天",
              @"bell" : @1}
        ];
//        保存
            BOOL flag = [firstPageData writeToFile:@"/Users/songjiaming/Documents/GitHub/WeChat/FirstPageData/firstPageData.plist" atomically:YES];
            if (flag) {
                NSLog(@"写入成功");
            }
    }
    return 0;
}
