//
//  FirstPageVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import "FirstPageVC.h"

// Tools
#import "Masonry.h"

@interface FirstPageVC ()

@property (nonatomic, strong) NSArray<FirstPageModel *> *dataArray;

@property (nonatomic, strong) UIView *topView;

@end

@implementation FirstPageVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.firstTableView];
    // 传递数据给TableView
    self.firstTableView.data = self.dataArray;
}

#pragma mark - Getter

- (NSArray<FirstPageModel *> *)dataArray {
    if (_dataArray == nil) {
        // 从plist文件中加载
        NSString *path = [[NSBundle mainBundle] pathForResource:@"firstPageData.plist" ofType:nil];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *ma = [NSMutableArray array];
        for (NSDictionary *dic in dataArray) {
            FirstPageModel *model = [[FirstPageModel alloc] init];
            [model FirstPageModelWithDic:dic];
            [ma addObject:model];
        }
        _dataArray = ma;
    }
    return _dataArray;
}

- (FirstPageView *)firstTableView {
    if (_firstTableView == nil) {
        _firstTableView = [[FirstPageView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + 50, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - 50) style:UITableViewStylePlain];
        _firstTableView.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
    }
    return _firstTableView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.frame = CGRectMake(0, StatusBarHeight, SCREEN_WIDTH, 50);
        _topView.backgroundColor = [UIColor colorNamed:@"#EDEDED'00^#111111'00"];
        UILabel *weChatLab = [[UILabel alloc] init];
        weChatLab.text = @"微信";
        weChatLab.font = [UIFont boldSystemFontOfSize:23];
        weChatLab.textAlignment = NSTextAlignmentCenter;
        weChatLab.textColor = [UIColor colorNamed:@"#181818'00^#CFCFCF'00"];
        [_topView addSubview:weChatLab];
        [weChatLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topView);
            make.size.mas_equalTo(CGSizeMake(100, 50));
            make.centerX.equalTo(_topView);
        }];
    }
    return _topView;
}
@end
