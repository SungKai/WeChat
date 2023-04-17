//
//  PublishView.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/6.
//

#import "PublishView.h"

// View
#import "PublishCollectionViewCell.h"
#import "PublishCollectionView.h"

// Tool
#import "Masonry.h"
#import <PhotosUI/PHPicker.h>

@interface PublishView () 

@end


@implementation PublishView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
        self.imageIsNine = NO;
        self.photosArray = [[NSMutableArray alloc] initWithCapacity:9];
        self.plusImage = [UIImage imageNamed:@"plus"];
        [self addView];
        [self setPosition];
    }
    return self;
}

#pragma mark - Method

- (void)addView {
    [self addSubview:self.cancelBtn];
    [self addSubview:self.publishBtn];
    [self addSubview:self.textView];
}

/// 设置初始数据
- (void)setData {
    // 没有图片时
    if (self.photosArray.count != 1) {
        if (self.photosArray.count == 0) {
            [self.photosArray addObject:self.plusImage];
        } else {
            self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
            self.publishBtn.enabled = YES;
        }
    }
    // 没有文本内容时
    if (self.textView.text.length == 0) {
        [self.textView addSubview:self.defaultLab];
        [self.defaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.textView);
            make.size.mas_equalTo(CGSizeMake(200, 30));
        }];
        if (self.photosArray.count == 1) {
            self.publishBtn.backgroundColor = [UIColor lightGrayColor];
            self.publishBtn.enabled = NO;
        }
    } else {
        self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
        self.publishBtn.enabled = YES;
    }
}

/// 设置位置
- (void)setPosition {
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40);
        make.left.equalTo(self).offset(25);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelBtn);
        make.right.equalTo(self).offset(-25);
        make.size.equalTo(self.cancelBtn);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelBtn.mas_bottom).offset(30);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.height.mas_equalTo(100);
    }];
}

#pragma mark - Getter

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
    }
    return _textView;
}

- (UILabel *)defaultLab {
    if (_defaultLab == nil) {
        _defaultLab = [[UILabel alloc] init];
        _defaultLab.text = @"这一刻的想法...";
        _defaultLab.textColor = [UIColor colorNamed:@"#B3B3B3'00^#5D5D5D'00"];
        _defaultLab.font = [UIFont systemFontOfSize:20];
    }
    return _defaultLab;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorNamed:@"#181818'00^#CFCFCF'00"] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _cancelBtn;
}

- (UIButton *)publishBtn {
    if (_publishBtn == nil) {
        _publishBtn = [[UIButton alloc] init];
        [_publishBtn setTitle:@"发布" forState:UIControlStateNormal];
        _publishBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _publishBtn.layer.masksToBounds = YES;
        _publishBtn.layer.cornerRadius = 5;
        [_publishBtn setBackgroundColor:[UIColor colorNamed:@"#FEFEFE'00^#191919'00"]];
    }
    return _publishBtn;
}
@end
