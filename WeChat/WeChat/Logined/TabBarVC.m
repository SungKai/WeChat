//
//  TabBarVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import "TabBarVC.h"
//VC
#import "FirstPageVC.h"
#import "AddressBookVC.h"
#import "MomentsPageVC.h"
#import "PersonPageVC.h"

@interface TabBarVC ()

@property (nonatomic, strong) FirstPageVC *firstPageVC;

@property (nonatomic, strong) AddressBookVC *addressBookVC;

@property (nonatomic, strong) MomentsPageVC *momentsPageVC;

@property (nonatomic, strong) PersonPageVC *personPageVC;

@end

@implementation TabBarVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorNamed:@"#EDEDED'00^#111111'00"];
        [[UITabBar appearance] setBackgroundColor:[UIColor colorNamed:@"#F8F8F8'90^#1D1D1D'90"]];
        self.viewControllers = @[self.firstPageVC, self.addressBookVC, self.momentsNav, self.personNav];
        self.tabBar.tintColor = [UIColor colorNamed:@"#00DF6C'00^#00DF6C'00"];
    }
    return self;
}
#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Getter
- (UINavigationController *)momentsNav {
    UINavigationController *momentsNav = [[UINavigationController alloc] initWithRootViewController:self.momentsPageVC];
    momentsNav.navigationBarHidden = NO;
    momentsNav.navigationBar.translucent = YES;
    return momentsNav;
}

- (UINavigationController *)personNav {
    UINavigationController *personNav = [[UINavigationController alloc] initWithRootViewController:self.personPageVC];
    personNav.navigationBarHidden = NO;
    personNav.navigationBar.translucent = YES;
    return personNav;
}

- (FirstPageVC *)firstPageVC {
    if (_firstPageVC == nil) {
        _firstPageVC = [[FirstPageVC alloc] init];
        _firstPageVC.title = @"微信";
        _firstPageVC.tabBarItem.title = @"微信";
        _firstPageVC.tabBarItem.image = [UIImage systemImageNamed:@"message"];
        _firstPageVC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"message.fill"];
    }
    return _firstPageVC;
}

- (AddressBookVC *)addressBookVC {
    if (_addressBookVC == nil) {
        _addressBookVC = [[AddressBookVC alloc] init];
        _addressBookVC.tabBarItem.title = @"通讯录";
        _addressBookVC.tabBarItem.image = [UIImage systemImageNamed:@"person.3"];
        _addressBookVC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"person.3.fill"];
    }
    return _addressBookVC;
}

- (MomentsPageVC *)momentsPageVC {
    if (_momentsPageVC == nil) {
        _momentsPageVC = [[MomentsPageVC alloc] init];
        _momentsPageVC.title = @"发现";
        _momentsPageVC.tabBarItem.title = @"发现";
        _momentsPageVC.tabBarItem.image = [UIImage systemImageNamed:@"safari"];
        _momentsPageVC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"safari.fill"];
        
    }
    return _momentsPageVC;
}

- (PersonPageVC *)personPageVC {
    if (_personPageVC == nil) {
        _personPageVC = [[PersonPageVC alloc] init];
        _personPageVC.title = @"我";
        _personPageVC.tabBarItem.title = @"我";
        _personPageVC.tabBarItem.image = [UIImage systemImageNamed:@"person"];
        _personPageVC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"person.fill"];
    }
    return _personPageVC;
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
