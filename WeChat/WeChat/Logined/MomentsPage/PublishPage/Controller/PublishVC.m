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

//Tools
#import <PhotosUI/PHPicker.h>

#define MomentModelManager [MomentsModelManager shareInstance]

@interface PublishVC () <
PublishViewDelegate
>

@property (nonatomic, strong) PublishView *publishView;

@end

@implementation PublishVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    //获取缓存数据
    [self getcacheData];
    [self.view addSubview:self.publishView];
}

#pragma mark - Method
///获取缓存数据
- (void)getcacheData {
    if ([MomentModelManager isCache]) {
        MomentsModel *cacheData = [MomentModelManager getData];
        //把缓存数据传给PublishView
        [self.publishView getCacheData:cacheData];
    }else {  //没有缓存数据直接设置数据
        [self.publishView setData];
    }
}

/// 点击任意一处退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.publishView.textView resignFirstResponder];
}

#pragma mark - Delegate
// MARK: <PublishViewDelegate>
- (void)SaveCacheText:(NSString *)text Images:(NSMutableArray *)imageArray {
    MomentsModel *cacheData = [[MomentsModel alloc] init];
    cacheData.published = 0;
    cacheData.text = text;
    cacheData.images = imageArray;
    //1.把原来数据库里面的published == 0 的数据删除
    BOOL res = [MomentModelManager deleteData];
    if (res) {
        NSLog(@"删除成功");
    }
    //2.换成新的数据
    BOOL res1 = [MomentModelManager insertData:cacheData];
    if (res1) {
        NSLog(@"更换成功");
    }
    //退出
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)deleteCacheText {
    //删除
    [MomentModelManager deleteData];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)showPopView:(UIAlertController *)popView {
    [self presentViewController:popView animated:NO completion:nil];
}

- (void)showPHPicker:(PHPickerViewController *)pvc {
    [self presentViewController:pvc animated:YES completion:nil];
}

///发布
- (void)publishData:(NSString *)text ImageArray:(NSMutableArray *)imageArray ImageIsNine:(BOOL)imageIsNine {
    //把imageArray的UIImage类型转化为NSData类型
    NSMutableArray *ma = [NSMutableArray array];
    NSData *data = [[NSData alloc] init];
    if (imageArray.count != 1) {
        //除九张照片外，其他应该去掉第0张照片
        //imageIsNine:当有8张照片时，加上加号图片，也是9张，所以需要用imageIsNine作判断，当imageIsNine == YES时，说明有真正的9张照片，imageIsNine == NO时，少于9张或为8张+加号图片
        if (imageArray.count != 9 || imageIsNine == NO) {
            for (int i = 1; i < imageArray.count; i++) {
                data = UIImagePNGRepresentation(imageArray[i]);
                [ma addObject:data];
            }
        }else {
            //九宫格全都要
            for (int i = 0; i < imageArray.count; i++) {
                data = UIImagePNGRepresentation(imageArray[i]);
                [ma addObject:data];
            }
        }
    }
    //回调
    self.getPublishData(text, ma);
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
