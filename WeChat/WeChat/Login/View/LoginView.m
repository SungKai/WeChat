//
//  LoginView.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import "LoginView.h"

//Tools
#import "Masonry.h"

@interface LoginView()


@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.avatarImageView];
        [self addSubview:self.nameLab];
        [self addSubview:self.loginBtn];
        [self setPosition];
    }
    return self;
}
#pragma mark - Method
///点击登录
- (void)clickLogin {
    [self.loginDelegate clickLogin];
    //保存登录状态
    [UserDefaults setBool:YES forKey:@"login"];
}

- (void)setPosition {
    //avatarImageView
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 110));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(100);
    }];
    //nameLab
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 35));
        make.centerX.equalTo(self);
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(30);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(270, 50));
        make.top.equalTo(self.nameLab.mas_bottom).offset(65);
        make.centerX.equalTo(self);
    }];
}

#pragma mark - Getter
- (UIImageView *)avatarImageView {
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 10;
    }
    return _avatarImageView;
}

- (UILabel *)nameLab {
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.text = @"Vermouth";
        _nameLab.font = [UIFont boldSystemFontOfSize:24];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.textColor = [UIColor colorNamed:@"#191919'00^#FEFEFE'00"];
    }
    return _nameLab;
}
- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setBackgroundColor:[UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"]];
        [_loginBtn setTitle:@"登 陆" forState:UIControlStateNormal];
        _loginBtn.titleLabel.textColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
        _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        _loginBtn.layer.cornerRadius = 7;
        //点击登录
        [_loginBtn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}



@end
