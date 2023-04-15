//
//  FirstPageView.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import "FirstPageView.h"

@implementation FirstPageView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        self.data = [NSArray array];
        
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstPageModel *dataModel = self.data[indexPath.row];
    static NSString *firstPageCellID = @"firstPageCellID";
    FirstPageTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:firstPageCellID];
    if (firstCell == nil) {
        firstCell = [[FirstPageTableViewCell alloc]initWithPerson:dataModel.person Text:dataModel.text ImgView:dataModel.image Date:dataModel.date BellImage:dataModel.bell];
        // 设置cell无法点击
        [firstCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return firstCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}


@end
