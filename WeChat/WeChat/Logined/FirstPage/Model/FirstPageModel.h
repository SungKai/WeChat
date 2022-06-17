//
//  FirstPageModel.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

//此类为消息主页的Model
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstPageModel : NSObject

@property (nonatomic, copy) NSString *person;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *date;
///是否屏蔽此人消息
@property (nonatomic) NSNumber *bell;

/// KVC字典转模型
/// @param dic 字典
- (instancetype)FirstPageModelWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
