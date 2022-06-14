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
#import "AvatarDatabase.h"

#define AvatarDatabaseManager [AvatarDatabaseManager shareInstance]

@interface LoginVC () <LoginViewDelegate>

@property (nonatomic, strong) LoginView *loginView;

@end

@implementation LoginVC
#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    //写入初始数据
    [self initAvatarData];
    //设置头像
    [self setAvatarImageView];
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
///初始化头像数据
- (void)initAvatarData {
    //创建数据库
    BOOL result = [AvatarDatabaseManager creatWCDB];
    if (result) {
        //创建成功，添加初始头像数据
        UIImage *avatarImage = [UIImage imageNamed:@"avatar"];
        NSData *data = [[NSData alloc] init];
        data = UIImagePNGRepresentation(avatarImage);
        AvatarDatabase *avatarData = [[AvatarDatabase alloc] init];
        avatarData.avatarData = data;
        //写入本地
        BOOL flag = [AvatarDatabaseManager insertOrUpdateData:avatarData];
        if (flag) {
            NSLog(@"初始头像数据写入成功");
        }
    }else {
        NSLog(@"头像数据已存在");
    }
}

///获取头像数据
- (void)setAvatarImageView {
    //从数据库取得数据
    NSData *data = [AvatarDatabaseManager getAvatarInformation];
    self.loginView.avatarImageView.image = [UIImage imageWithData:data];
}
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
