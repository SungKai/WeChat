//
//  AddressBookModel.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/30.
//

#import "AddressBookModel.h"

@implementation AddressBookModel
/// KVC字典转模型
/// @param dic 字典
- (instancetype)AddressBoolModelWithDic:(NSDictionary *)dic {
    [self setValuesForKeysWithDictionary:dic];
    return self;
}
@end
