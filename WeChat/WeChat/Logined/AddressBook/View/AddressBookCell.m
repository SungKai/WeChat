//
//  AddressBookCell.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/30.
//

#import "AddressBookCell.h"

@implementation AddressBookCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
        [self.contentView addSubview:self.avatarImgView];
        [self.contentView addSubview:self.nameLab];
        [self setPosition];
    }
    return self;
}

#pragma mark - Method
- (void)setPosition {
    [self.avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerY.equalTo(self.contentView);
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.avatarImgView.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(25);
    }];
}

#pragma mark - Getter
- (UILabel *)nameLab {
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor colorNamed:@"#181818'00^#CFCFCF'00"];
        _nameLab.font = [UIFont systemFontOfSize:23];
        _nameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLab;
}

- (UIImageView *)avatarImgView {
    if (_avatarImgView == nil) {
        _avatarImgView = [[UIImageView alloc] init];
        _avatarImgView.layer.masksToBounds = YES;
        _avatarImgView.layer.cornerRadius = 5;
    }
    return _avatarImgView;
}



@end
