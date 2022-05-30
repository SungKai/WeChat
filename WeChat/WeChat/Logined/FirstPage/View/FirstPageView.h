//
//  FirstPageView.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import <UIKit/UIKit.h>

//View
#import "FirstPageCellTableViewCell.h"

//Model

#import "FirstPageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstPageView : UITableView <
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) NSArray <FirstPageModel *> *data;

@end

NS_ASSUME_NONNULL_END
