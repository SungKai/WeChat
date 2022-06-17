//
//  MineModel.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/4.
//

//此类为我界面的Model
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineModel : NSObject

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *title;

/// KVC字典转模型
/// @param dic 字典
- (instancetype)MineModelWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
