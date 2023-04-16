//
//  AddressBookVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
// 

#import "AddressBookVC.h"

// View
#import "AddressBookCell.h"

// Model
#import "AddressBookModel.h"

@interface AddressBookVC () <
    UISearchBarDelegate,
    UITableViewDataSource,
    UITableViewDelegate
>

/// 搜索框
@property (nonatomic, strong) UISearchBar *searchBar;

/// 搜索框内的文字内容
@property (nonatomic, strong) NSString *filterString;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <AddressBookModel *> *dataArray;

/// 复制的原始数据，用于结束搜素时使通讯录恢复默认情况
@property (nonatomic, strong) NSArray <AddressBookModel *> *duplicateDataArray;

@property (nonatomic, strong) UIView *topView;

@end

@implementation AddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self setData];
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - Method

- (void)setData {
    self.dataArray = [NSArray array];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"addressBookData.plist" ofType:nil];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *ma = [NSMutableArray array];
    for (NSDictionary *dic in dataArray) {
        AddressBookModel *model = [[AddressBookModel alloc] AddressBoolModelWithDic:dic];
        [ma addObject:model];
    }
    self.dataArray = ma;
    // 复制原始数据
    self.duplicateDataArray = [self.dataArray copy];
}

#pragma mark - Delegate



// MARK: <UISearchBarDelegate>
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.dataArray = self.duplicateDataArray;
    NSMutableArray *temp = [NSMutableArray array];
    if (![searchText isEqualToString:@""]) {
        for (int i = 4, j = 0; i < self.dataArray.count; i++, j++) {
            NSString *str = self.dataArray[i].title;
            if ([str.lowercaseString containsString:searchText.lowercaseString]) {
                AddressBookModel *model = [[AddressBookModel alloc] init];
                model.title = str;
                model.image = self.dataArray[i].image;
                [temp addObject:model];
            }
        }
        self.dataArray = temp;
    }
    [self.tableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.text = @"";
    self.dataArray = self.duplicateDataArray;
    [self.tableView reloadData];
}

#pragma mark - UITabelViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressBookModel *model = self.dataArray[indexPath.row];
    static NSString *addressBookID = @"addressBookID";
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:addressBookID];
    if (cell == nil) {
        cell = [[AddressBookCell alloc] init];
        cell.avatarImgView.image = [UIImage imageNamed:model.image];
        cell.nameLab.text = model.title;
        // 设置cell无法点击
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

/// 每行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

/// 点击任意一处退出键盘
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
}

/// 滑动时退出键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + 50, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - 50) style:UITableViewStylePlain];
    }
    return _tableView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor colorNamed:@"#EDEDED'00^#111111'00"];
        _topView.frame = CGRectMake(0, StatusBarHeight, SCREEN_WIDTH, 50);
        UILabel *addressBookLab = [[UILabel alloc] init];
        addressBookLab.text = @"通讯录";
        addressBookLab.font = [UIFont boldSystemFontOfSize:23];
        addressBookLab.textAlignment = NSTextAlignmentCenter;
        addressBookLab.textColor = [UIColor colorNamed:@"#181818'00^#CFCFCF'00"];
        [_topView addSubview:addressBookLab];
        [addressBookLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topView);
            make.size.mas_equalTo(CGSizeMake(100, 50));
            make.centerX.equalTo(_topView);
        }];
    }
    return _topView;
}

- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}


@end
