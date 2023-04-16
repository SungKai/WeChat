//
//  FirstPageTableViewCell.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

// 此类为消息主页的TableView中的cell
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstPageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *personLab;

@property (nonatomic, strong) UILabel *textLab;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *dateLab;

@property (nonatomic, strong) UIImageView *bellImageView;

@property (nonatomic, strong) UIView *separator;

@end

NS_ASSUME_NONNULL_END
