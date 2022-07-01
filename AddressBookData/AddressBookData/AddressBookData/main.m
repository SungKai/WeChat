//
//  main.m
//  AddressBookData
//
//  Created by 宋开开 on 2022/5/30.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSArray *addressBookArray = @[
            @{@"title" : @"新的朋友",
              @"image" : @"AddressBookImage0"},
            @{@"title" : @"群聊",
              @"image" : @"AddressBookImage1"},
            @{@"title" : @"标签",
              @"image" : @"AddressBookImage2"},
            @{@"title" : @"公众号",
              @"image" : @"AddressBookImage3"},
            @{@"title" : @"Bourbon",
              @"image" : @"AddressBookImage4"},
            @{@"title" : @"Calvados",
              @"image" : @"AddressBookImage5"},
            @{@"title" : @"Carasuma乌丸莲耶",
              @"image" : @"AddressBookImage6"},
            @{@"title" : @"Chianti",
              @"image" : @"AddressBookImage7"},
            @{@"title" : @"Gin",
              @"image" : @"AddressBookImage8"},
            @{@"title" : @"工藤有希子",
              @"image" : @"AddressBookImage9"},
            @{@"title" : @"江户川柯南",
              @"image" : @"AddressBookImage10"},
            @{@"title" : @"Kir",
              @"image" : @"AddressBookImage11"},
            @{@"title" : @"Korn",
              @"image" : @"AddressBookImage12"},
            @{@"title" : @"铃木园子",
              @"image" : @"AddressBookImage13"},
            @{@"title" : @"Rum",
              @"image" : @"AddressBookImage14"},
            @{@"title" : @"Sherry",
              @"image" : @"AddressBookImage15"},
            @{@"title" : @"Vodka",
              @"image" : @"AddressBookImage16"},
            @{@"title" : @"小兰",
              @"image" : @"AddressBookImage17"},
            @{@"title" : @"朱蒂",
              @"image" : @"AddressBookImage18"}
        ];
        //保存
        BOOL flag = [addressBookArray writeToFile:@"/Users/songjiaming/Documents/GitHub/WeChat/AddressBookData/addressBookData.plist" atomically:YES];
        if (flag) {
            NSLog(@"写入成功");
        }
    }
    return 0;
}
