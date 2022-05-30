//
//  FirstPageCellTableViewCell.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import <UIKit/UIKit.h>

//Tools
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstPageCellTableViewCell : UITableViewCell
/*


 */
@property (nonatomic, strong) UILabel *personLab;

@property (nonatomic, strong) UILabel *textLab;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *dateLab;

@property (nonatomic, strong) UIImageView *bellImageView;

@property (nonatomic, strong) UIView *separator;

- (instancetype)initWithPerson:(NSString *)person Text:(NSString *)text ImgView:(NSString *)imgViewData Date:(NSString *)date BellImage:(NSNumber *)bell;
@end

NS_ASSUME_NONNULL_END
