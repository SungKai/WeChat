//
//  MomentsMomentsModel.h
//  YYLabel图文混排
//
//  Created by 宋开开 on 2022/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MomentsModel : NSObject

@property (nonatomic, copy) NSString *person;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) NSMutableArray *likes;

@property (nonatomic, strong) NSMutableArray *comments;

/// KVC字典转模型
/// @param dic 字典
- (instancetype)MomentsModelWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
