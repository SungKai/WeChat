//
//  FirstPageModel.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import "FirstPageModel.h"

@implementation FirstPageModel
/// KVC字典转模型
/// @param dic 字典
- (instancetype)FirstPageModelWithDic:(NSDictionary *)dic {
    [self setValuesForKeysWithDictionary:dic];
    return self;
}
///防崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
 }

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
@end
