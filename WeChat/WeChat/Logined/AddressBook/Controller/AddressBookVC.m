//
//  AddressBookVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import "AddressBookVC.h"

@interface AddressBookVC ()

@property (nonatomic, strong) AddressBookView *tableView;

@property (nonatomic, strong) NSArray <AddressBookModel *> *dataArray;

@property (nonatomic, strong) UIView *topView;

@end

@implementation AddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    self.tableView.data = self.dataArray;
}


#pragma mark - Getter
- (AddressBookView *)tableView {
    if (_tableView == nil) {
        _tableView = [[AddressBookView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + 60, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    }
    return _tableView;
}

- (NSArray<AddressBookModel *> *)dataArray {
    if (_dataArray == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"addressBookData.plist" ofType:nil];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *ma = [NSMutableArray array];
        for (NSDictionary *dic in dataArray) {
            AddressBookModel *model = [[AddressBookModel alloc] AddressBoolModelWithDic:dic];
            [ma addObject:model];
        }
        _dataArray = ma;
    }
    return _dataArray;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor colorNamed:@"#EDEDED'00^#111111'00"];
        _topView.frame = CGRectMake(0, StatusBarHeight, SCREEN_WIDTH, 60);
        UILabel *addressBookLab = [[UILabel alloc] init];
        addressBookLab.text = @"通讯录";
        addressBookLab.font = [UIFont boldSystemFontOfSize:23];
        addressBookLab.textAlignment = NSTextAlignmentCenter;
        addressBookLab.textColor = [UIColor colorNamed:@"#181818'00^#CFCFCF'00"];
        [_topView addSubview:addressBookLab];
        [addressBookLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topView).offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 50));
            make.centerX.equalTo(_topView);
        }];
    }
    return _topView;
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
