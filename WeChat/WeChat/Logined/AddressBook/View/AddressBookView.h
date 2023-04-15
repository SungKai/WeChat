//
//  AddressBookView.h
//  WeChat
//
//  Created by 宋开开 on 2022/5/30.
//

// 此类为通讯录的TableView
#import <UIKit/UIKit.h>

// View
#import "AddressBookCell.h"

// Model
#import "AddressBookModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddressBookViewDelegate <NSObject>


@end

@interface AddressBookView : UITableView <UITableViewDataSource>

@property (nonatomic, strong) NSArray <AddressBookModel *> *data;

@property (nonatomic, weak) id<AddressBookViewDelegate> cellDelegate;

@end

NS_ASSUME_NONNULL_END
