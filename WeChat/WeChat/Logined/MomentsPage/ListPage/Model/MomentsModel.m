//
//  MomentsMomentsModel.m
//  YYLabel图文混排
//
//  Created by 宋开开 on 2022/6/1.
//

#import "MomentsModel.h"

@implementation MomentsModel
/// KVC字典转模型
/// @param dic 字典
- (instancetype)MomentsModelWithDic:(NSDictionary *)dic {
    [self setValuesForKeysWithDictionary:dic];
    return self;
}
@end
