//
//  FirstPageCellTableViewCell.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

//此类为消息主页的TableView中的cell
#import <UIKit/UIKit.h>

//Tools
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstPageCellTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *personLab;

@property (nonatomic, strong) UILabel *textLab;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *dateLab;

@property (nonatomic, strong) UIImageView *bellImageView;

@property (nonatomic, strong) UIView *separator;

/// 初始化方法
/// @param person 朋友名字
/// @param text 信息
/// @param imgViewData 图片信息
/// @param date 日期
/// @param bell 是否免打扰   
- (instancetype)initWithPerson:(NSString *)person Text:(NSString *)text ImgView:(NSString *)imgViewData Date:(NSString *)date BellImage:(NSNumber *)bell;
@end

NS_ASSUME_NONNULL_END
