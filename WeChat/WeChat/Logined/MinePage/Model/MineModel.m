//
//  MineModel.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/4.
//

#import "MineModel.h"

@implementation MineModel
/// KVC字典转模型
/// @param dic 字典
- (instancetype)MineModelWithDic:(NSDictionary *)dic {
    [self setValuesForKeysWithDictionary:dic];
    return self;
}
@end
