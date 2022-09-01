//
//  CommentVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/3.
//

#import "CommentVC.h"

//Tools
#import "Masonry.h"

@interface CommentVC () <
UITextViewDelegate
>

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *publishBtn;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel *defaultLab;

@end

@implementation CommentVC


#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self setPosition];
    self.view.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
    self.publishBtn.backgroundColor = [UIColor lightGrayColor];
    //隐藏顶部和底部导航
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;  //返回时也隐藏了
}

#pragma mark - Method
///点击取消按钮，返回
- (void)clickCancelBtn {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

///点击发布按钮
- (void)clickPublishBtn {
    if (self.textView.text.length == 0) {
        self.publishBtn.enabled = NO;
    }else {
        //拿到输入的内容
        NSString *nameString = @"Vermouth : ";
        NSString *commentText = [nameString stringByAppendingString:self.textView.text];
        NSLog(@"commentText = %@", commentText);
        //回调
        self.getCommentsData(commentText);
    }
}

/// 点击任意一处退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}

///添加控件
- (void)addView {
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.publishBtn];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.defaultLab];
}
///设置位置
- (void)setPosition {
    //self.cancelBtn
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.left.equalTo(self.view).offset(25);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    //self.publishBtn
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelBtn);
        make.size.equalTo(self.cancelBtn);
        make.right.equalTo(self.view).offset(-25);
    }];
    //self.textView
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelBtn.mas_bottom).offset(15);
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
    }];
    //self.defaultLab
    [self.defaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.textView);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
}

#pragma mark - Delegate
// MARK: <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView{
    if (self.textView.text.length == 0) {
        self.publishBtn.backgroundColor = [UIColor grayColor];
        self.publishBtn.enabled = NO;
    }else{
        self.publishBtn.enabled = YES;
        self.publishBtn.backgroundColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
        self.defaultLab.hidden = YES;
    }
}
#pragma mark - Getter
- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorNamed:@"#181818'00^#CFCFCF'00"] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)publishBtn {
    if (_publishBtn == nil) {
        _publishBtn = [[UIButton alloc] init];
        [_publishBtn setTitle:@"发表" forState:UIControlStateNormal];
        _publishBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _publishBtn.layer.masksToBounds = YES;
        _publishBtn.layer.cornerRadius = 5;
        [_publishBtn addTarget:self action:@selector(clickPublishBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
}

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];

    }
    return _textView;
}

- (UILabel *)defaultLab {
    if (_defaultLab == nil) {
        _defaultLab = [[UILabel alloc] init];
        _defaultLab.text = @"发表你的评论...";
        _defaultLab.font = [UIFont systemFontOfSize:22];
        _defaultLab.textColor = [UIColor colorNamed:@"#B3B3B3'00^#5D5D5D'00"];
        _defaultLab.textAlignment = NSTextAlignmentLeft;
    }
    return _defaultLab;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
