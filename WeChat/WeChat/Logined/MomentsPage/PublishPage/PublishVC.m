//
//  PublishVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/3.
//

#import "PublishVC.h"
////发布和评论的数据存储
#define PublishManager [PublishManager shareInstance]
#define CommentManager [CommentManager shareInstance]
@interface PublishVC ()

//@property (nonatomic, )
@end

@implementation PublishVC


#pragma mark - Method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    // Do any additional setup after loading the view.
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
