//
//  FirstPageVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import "FirstPageVC.h"

// View
#import "FirstPageTableViewCell.h"

// Model
#import "FirstPageModel.h"

// Tools
#import "Masonry.h"

@interface FirstPageVC () <
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, strong) UITableView *firstTableView;

@property (nonatomic, strong) NSArray<FirstPageModel *> *dataArray;

@property (nonatomic, strong) UIView *topView;

@end

@implementation FirstPageVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.firstTableView];
    self.firstTableView.dataSource = self;
    self.firstTableView.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstPageModel *model = self.dataArray[indexPath.row];
    static NSString *firstPageCellID = @"firstPageCellID";
    FirstPageTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:firstPageCellID];
    if (firstCell == nil) {
        firstCell = [[FirstPageTableViewCell alloc] init];
        firstCell.personLab.text = model.person;
        firstCell.textLab.text = model.text;
        firstCell.imgView.image = [UIImage imageNamed:model.image];
        firstCell.dateLab.text = model.date;
        // 是否屏蔽信息
        // 把NSNumber转换为NSInteger
        // 把对数据的处理放在了Controller里面，这种是瘦Model，胖VC的做法
        NSInteger isBell = [model.bell integerValue];
        if (!isBell) {  // 如果不屏蔽，就把屏蔽的图案移除
            [firstCell.bellImageView removeFromSuperview];
        }
        // 设置cell无法点击
        [firstCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return firstCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
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

- (UITableView *)firstTableView {
    if (_firstTableView == nil) {
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + 50, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - 50) style:UITableViewStylePlain];
        _firstTableView.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
        _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
