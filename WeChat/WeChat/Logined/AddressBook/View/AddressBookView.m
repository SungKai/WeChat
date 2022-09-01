//
//  AddressBookView.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/30.
//

#import "AddressBookView.h"

@implementation AddressBookView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
//        self.delegate = self;
        self.data = [NSArray array];
//        [self addSubview:self.searchBar];
    }
    return self;
}

#pragma mark - UITabelViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressBookModel *model = self.data[indexPath.row];
    static NSString *addressBookID = @"addressBookID";
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:addressBookID];
    if (cell == nil) {
        cell = [[AddressBookCell alloc] initWithTitle:model.title ImageData:model.image];
        //设置cell无法点击
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}


@end
