//
//  FirstPageTableViewCell.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import "FirstPageTableViewCell.h"

// Tools
#import "Masonry.h"

@implementation FirstPageTableViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
        [self.contentView addSubview:self.personLab];
        [self.contentView addSubview:self.textLab];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.dateLab];
        [self.contentView addSubview:self.separator];
        [self setPosition];
    }
    return self;
}

#pragma mark - Method

- (void)setPosition {
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(58, 58));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
    }];
    [self.personLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-40);
        make.top.equalTo(self.imgView).offset(1);
        make.height.mas_equalTo(30);
    }];
    [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personLab.mas_bottom).offset(5);
        make.left.equalTo(self.personLab);
        make.right.equalTo(self.personLab);
        make.bottom.equalTo(self.imgView).offset(-3);
    }];
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.personLab);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.right.equalTo(self.contentView);
        make.left.equalTo(self.personLab);
    }];
}

#pragma mark - Getter

- (UILabel *)personLab {
    if (_personLab == nil) {
        _personLab = [[UILabel alloc] init];
        _personLab.font = [UIFont systemFontOfSize:22];
        _personLab.textColor = [UIColor colorNamed:@"#181818'00^#CFCFCF'00"];
        _personLab.textAlignment = NSTextAlignmentLeft;
    }
    return _personLab;
}

- (UILabel *)textLab {
    if (_textLab == nil) {
        _textLab = [[UILabel alloc] init];
        _textLab.font = [UIFont systemFontOfSize:17];
        _textLab.textColor = [UIColor colorNamed:@"#B3B3B3'00^#5D5D5D'00"];
        _textLab.textAlignment = NSTextAlignmentLeft;
    }
    return _textLab;
}

- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = 5;
    }
    return _imgView;
}

- (UILabel *)dateLab {
    if (_dateLab == nil) {
        _dateLab = [[UILabel alloc] init];
        _dateLab.font = [UIFont systemFontOfSize:15];
        _dateLab.textColor = [UIColor colorNamed:@"#B3B3B3'00^#5D5D5D'00"];
        _dateLab.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLab;
}

- (UIImageView *)bellImageView {
    if (_bellImageView == nil) {
        _bellImageView = [[UIImageView alloc] init];
        _bellImageView.image = [UIImage systemImageNamed:@"bell.slash"];
        _bellImageView.tintColor = [UIColor colorNamed:@"#B3B3B3'00^#5D5D5D'00"];
    }
    return _bellImageView;
}

- (UIView *)separator {
    if (_separator == nil) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor colorNamed:@"#E5E5E5'00^#252524'00"];
    }
    return _separator;
}
@end
