//
//  PublishView.h
//  WeChat
//
//  Created by 宋开开 on 2022/6/6.
//

// 此类为朋友圈发布界面的View
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishView : UIView

/// 文本编辑框
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong, nullable) NSMutableArray *photosArray;

/// 用于判断是否为满九宫格照片
@property (nonatomic) BOOL imageIsNine;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *publishBtn;

/// 当文本编辑框内的默认内容
@property (nonatomic, strong) UILabel *defaultLab;

@property (nonatomic, strong) UIImage *plusImage;

/// 设置初始数据
- (void)setData;

@end

NS_ASSUME_NONNULL_END
