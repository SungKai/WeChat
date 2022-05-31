//
//  FirstPageCellTableViewCell.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import "FirstPageCellTableViewCell.h"

@implementation FirstPageCellTableViewCell

- (instancetype)initWithPerson:(NSString *)person Text:(NSString *)text ImgView:(NSString *)imgViewData Date:(NSString *)date BellImage:(NSNumber *)bell {
    self = [super init];
    if (self) {
        self.personLab.text = person;
        self.textLab.text = text;
        self.imgView.image = [UIImage imageNamed:imgViewData];
        self.dateLab.text = date;
        [self.contentView addSubview:self.personLab];
        [self.contentView addSubview:self.textLab];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.dateLab];
        [self.contentView addSubview:self.separator];
        //把NSNumber转换为NSInteger
        NSInteger isBell = [bell integerValue];
        if (isBell) {
            [self.contentView addSubview:self.bellImageView];
        }
        [self setPosition];
        self.bellImageView.frame = CGRectMake(SCREEN_WIDTH - 40, self.contentView.frame.size.height + 7, 20, 20);
    }
    return self;
}

#pragma mark - Method
- (void)setPosition {
    //imgView
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(67, 67));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
    }];
    //personLab
    [self.personLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-40);
        make.top.equalTo(self.imgView);
        make.height.mas_equalTo(30);
    }];
//    //textLab
    [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personLab.mas_bottom).offset(10);
        make.left.equalTo(self.personLab);
        make.right.equalTo(self.personLab);
        make.height.mas_equalTo(20);
    }];
    //dateLab
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.personLab);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    //separator
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.7);
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
        _textLab.font = [UIFont systemFontOfSize:18];
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
        _dateLab.textColor = [UIColor colorNamed:@"#CCCCCC'00^#2F2F2F"];
        _dateLab.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLab;
}

- (UIImageView *)bellImageView {
    if (_bellImageView == nil) {
        _bellImageView = [[UIImageView alloc] init];
        _bellImageView.image = [UIImage systemImageNamed:@"bell.slash"];
        _bellImageView.tintColor = [UIColor colorNamed:@"#CCCCCC'00^#2F2F2F"];
    }
    return _bellImageView;
}

- (UIView *)separator {
    if (_separator == nil) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor colorNamed:@"#CCCCCC'00^#2F2F2F"];
    }
    return _separator;
}
@end
