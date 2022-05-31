//
//  AddressBookView.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/30.
//

#import <UIKit/UIKit.h>

//View
#import "AddressBookCell.h"

//Model
#import "AddressBookModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray <AddressBookModel *> *data;

@end

NS_ASSUME_NONNULL_END
