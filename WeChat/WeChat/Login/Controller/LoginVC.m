//
//  LoginVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/28.
//

#import "LoginVC.h"

//VC
#import "TabBarVC.h"

//View
#import "LoginView.h"

//Tools
#import "Masonry.h"
@interface LoginVC () <LoginViewDelegate>

@property (nonatomic, strong) LoginView *loginView;

@end

@implementation LoginVC
#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    if ([UserDefaults boolForKey:@"login"]) {  //已登陆状态直接进入Logined
        TabBarVC *tabBarVC = [[TabBarVC alloc] init];
        [self.navigationController pushViewController:tabBarVC animated:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
    [self.view addSubview:self.loginView];
}

#pragma mark - Method


#pragma mark - Delegate
// MARK: <LoginViewDelegate>
//点击跳转
- (void)clickLogin {
    TabBarVC *tabBarVC = [[TabBarVC alloc] init];
    [self.navigationController pushViewController:tabBarVC animated:NO];
}
#pragma mark - Getter

- (LoginView *)loginView {
    if (_loginView == nil) {
        _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight)];
        _loginView.loginDelegate = self;
    }
    return _loginView;
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
