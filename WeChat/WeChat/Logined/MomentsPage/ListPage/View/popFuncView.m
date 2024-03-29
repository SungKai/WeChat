//
//  popFuncView.m
//  YYLabel图文混排
//
//  Created by 宋开开 on 2022/6/2.
//

#import "popFuncView.h"

// Tools
#import "Masonry.h"

@implementation popFuncView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorNamed:@"#4C5153'00^#606060'00"];
        self.layer.cornerRadius = 7;
        [self addSubview:self.likesBtn];
        [self addSubview:self.commentsBtn];
        [self addSubview:self.separator];
        [self addSubview:self.likeLab];
        [self addSubview:self.commentLab];
        [self addSubview:self.likeImageView];
        [self addSubview:self.commentImageView];
        [self setPosition];
    }
    return self;
}

#pragma mark - Method

- (void)setPosition {
    [self.likesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.mas_centerX).offset(-0.3);
        make.height.equalTo(self);
    }];
    [self.likeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.likesBtn).offset(8);
        make.centerY.equalTo(self.likesBtn);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.likesBtn);
        make.right.equalTo(self.likeLab.mas_left).offset(-2);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [self.commentsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self.mas_centerX).offset(0.3);
        make.height.equalTo(self);
    }];
    [self.commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.commentsBtn).offset(8);
        make.centerY.equalTo(self.commentsBtn);
        make.size.mas_equalTo(CGSizeMake(35, 30));
    }];
    [self.commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commentsBtn);
        make.right.equalTo(self.commentLab.mas_left);
        make.size.mas_equalTo(CGSizeMake(18, 16));
    }];
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.center.equalTo(self);
        make.width.mas_equalTo(0.6);
    }];
    
}

#pragma mark - Getter

- (UIButton *)likesBtn {
    if (_likesBtn == nil) {
        _likesBtn = [[UIButton alloc] init];
    }
    return _likesBtn;
}

- (UIButton *)commentsBtn {
    if (_commentsBtn == nil) {
        _commentsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _commentsBtn;
}

- (UIView *)separator {
    if (_separator == nil) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor colorNamed:@"#909090'00^#373D40'00"];
    }
    return _separator;
}

- (UILabel *)likeLab {
    if (_likeLab == nil) {
        _likeLab = [[UILabel alloc] init];
        _likeLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 15];
        _likeLab.textColor = [UIColor whiteColor];
        _likeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _likeLab;
}

- (UILabel *)commentLab {
    if (_commentLab == nil) {
        _commentLab = [[UILabel alloc] init];
        _commentLab.text = @"评论";
        _commentLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 15];
        _commentLab.textColor = [UIColor whiteColor];
        _commentLab.textAlignment = NSTextAlignmentCenter;
    }
    return _commentLab;
}

- (UIImageView *)likeImageView {
    if (_likeImageView == nil) {
        _likeImageView = [[UIImageView alloc] init];
        _likeImageView.image = [UIImage systemImageNamed:@"heart"];
        _likeImageView.tintColor = [UIColor whiteColor];
    }
    return _likeImageView;
}

- (UIImageView *)commentImageView {
    if (_commentImageView == nil) {
        _commentImageView = [[UIImageView alloc] init];
        _commentImageView.image = [UIImage systemImageNamed:@"bubble.left"];
        _commentImageView.tintColor = [UIColor whiteColor];
    }
    return _commentImageView;
}

@end
