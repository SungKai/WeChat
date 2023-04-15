//
//  AddressBookModel.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/30.
//

// 此类为通讯录的Model
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

/// KVC字典转模型
/// @param dic 字典
- (instancetype)AddressBoolModelWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
