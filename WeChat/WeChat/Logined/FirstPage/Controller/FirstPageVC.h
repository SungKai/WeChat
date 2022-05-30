//
//  FirstPageVC.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import <UIKit/UIKit.h>

//View
#import "FirstPageView.h"

//Model
#import "FirstPageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstPageVC : UIViewController

@property (nonatomic, strong) FirstPageView *firstTableView;

@end

NS_ASSUME_NONNULL_END
