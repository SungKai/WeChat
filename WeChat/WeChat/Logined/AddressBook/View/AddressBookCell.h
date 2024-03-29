//
//  AddressBookCell.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/30.
//

// 此类为通讯录的TableView的cell
#import <UIKit/UIKit.h>

// Tools
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UIImageView *avatarImgView;

@end

NS_ASSUME_NONNULL_END
