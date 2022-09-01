//
//  AddressBookVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import "AddressBookVC.h"

@interface AddressBookVC () <
    UISearchBarDelegate,
    UITableViewDelegate
>

///搜索框
@property (nonatomic, strong) UISearchBar *searchBar;

///搜索框内的文字内容
@property (nonatomic, strong) NSString *filterString;

@property (nonatomic, strong) AddressBookView *tableView;

@property (nonatomic, strong) NSArray <AddressBookModel *> *dataArray;

///复制的原始数据，用于结束搜素时使通讯录恢复默认情况
@property (nonatomic, strong) NSArray <AddressBookModel *> *duplicateDataArray;

@property (nonatomic, strong) UIView *topView;

@end

@implementation AddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self setData];
    self.tableView.data = self.dataArray;
    self.tableView.tableHeaderView = self.searchBar;
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
    //复制原始数据
    self.duplicateDataArray = [self.dataArray copy];
//    self.duplicateDataArray = self.dataArray;
}
#pragma mark - Delegate
// MARK: UISearchBarDelegate
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
    self.tableView.data = self.dataArray;
    [self.tableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.text = @"";
    self.dataArray = self.duplicateDataArray;
    self.tableView.data = self.dataArray;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

///每行高度
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

- (AddressBookView *)tableView {
    if (_tableView == nil) {
        _tableView = [[AddressBookView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + 50, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - 50) style:UITableViewStylePlain];
        _tableView.delegate = self;
    }
    return _tableView;
}

//- (NSArray<AddressBookModel *> *)dataArray {
//    if (_dataArray == nil) {
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"addressBookData.plist" ofType:nil];
//        NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePath];
//        NSMutableArray *ma = [NSMutableArray array];
//        for (NSDictionary *dic in dataArray) {
//            AddressBookModel *model = [[AddressBookModel alloc] AddressBoolModelWithDic:dic];
//            [ma addObject:model];
//        }
//        _dataArray = ma;
//    }
//    return _dataArray;
//}

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
