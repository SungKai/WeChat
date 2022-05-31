//
//  AddressBookCell.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/30.
//

#import <UIKit/UIKit.h>

//Tools
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UIImageView *avatarImgView;

/// 初始化方法
/// @param title 朋友名字
/// @param imageData 图片信息   
- (instancetype)initWithTitle:(NSString *)title ImageData:(NSString *)imageData;

@end

NS_ASSUME_NONNULL_END
