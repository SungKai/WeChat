//
//  PublishVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/3.
//

#import "PublishVC.h"

//View
#import "PublishView.h"

//Model
#import "MomentsModel.h"

#define MomentModelManager [MomentsModelManager shareInstance]


@interface PublishVC () <
PublishViewDelegate
>

@property (nonatomic, strong) PublishView *publishView;

@end

@implementation PublishVC


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self.view addSubview:self.publishView];
    //获取缓存数据
    [self getcacheData];
    // Do any additional setup after loading the view.
}

#pragma mark - Method
///获取缓存数据
- (void)getcacheData {
    if ([MomentModelManager isCache]) {
        MomentsModel *cacheData = [MomentModelManager getData];
        //把缓存数据传给PublishView
        [self.publishView getCacheData:cacheData];
    }
//    else {  //没有缓存数据直接设置数据
//        [self.publishView setData];
//    }
}

#pragma mark - Delegate
// MARK: <PublishViewDelegate>
- (void)SaveCacheText:(NSString *)text Images:(NSData *)imageData {
    
}

- (void)deleteCacheText {
    NSLog(@"退出");
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)showPopView:(UIAlertController *)popView {
    [self presentViewController:popView animated:NO completion:nil];
}
#pragma mark - Getter
- (PublishView *)publishView {
    if (_publishView == nil) {
        _publishView = [[PublishView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _publishView.publishViewDelegate = self;
        
    }
    return _publishView;
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
