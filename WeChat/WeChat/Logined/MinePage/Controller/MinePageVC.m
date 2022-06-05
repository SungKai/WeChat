//
//  MinePageVC.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/29.
//

#import "MinePageVC.h"

//Model
#import "MineModel.h"

//Tool
#import "Masonry.h"
#import <PhotosUI/PHPicker.h>

@interface MinePageVC () <
UITableViewDataSource,
UITableViewDelegate,
PHPickerViewControllerDelegate
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) NSArray<MineModel *> *dataArray;

@end

@implementation MinePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.topView;
}

#pragma mark - Method
- (void)clickToChangeAvater {
    NSLog(@"换头像");
}
///生成退出登录的UILabel
- (UILabel *)logoutLab {
    UILabel *logoutLab = [[UILabel alloc] init];
    logoutLab.text = @"退出登录";
    logoutLab.textColor = [UIColor redColor];
    logoutLab.textAlignment = NSTextAlignmentCenter;
    logoutLab.font = [UIFont boldSystemFontOfSize:20];
    return logoutLab;
}
///点击退出登录
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) {
        NSLog(@"%@", self.navigationController);
        [UserDefaults setBool:NO forKey:@"login"];
        [self.minePageDelegate logout];
//        [self.navigationController popToViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 4;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
    MineModel *model = [[MineModel alloc] init];
    if (indexPath.section != 2) {
        if (indexPath.section == 0) {
            model = self.dataArray[0];
        }else{
            model = self.dataArray[indexPath.row + 1];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:model.image];
        cell.textLabel.text = model.title;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else {
        UILabel *logoutLab = [self logoutLab];
        [cell addSubview:logoutLab];
        [logoutLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
            make.size.mas_equalTo(CGSizeMake(200, 40));
        }];
    }
    
    
    return cell;
}

#pragma mark - Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}
//heightForHeaderInSection
#pragma mark - Getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, - StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
        _topView.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
        //avaterImageView
        UIImageView *avaterImageView = [[UIImageView alloc] init];
        avaterImageView.image = [UIImage imageNamed:@"avatar"];
        avaterImageView.layer.masksToBounds = YES;
        avaterImageView.layer.cornerRadius = 7;
        //nameLab
        UILabel *nameLab = [[UILabel alloc] init];
        nameLab.text = @"Vermouth";
        nameLab.font = [UIFont boldSystemFontOfSize:23];
        nameLab.textColor = [UIColor colorNamed:@"#181818'00^#CFCFCF'00"];
        nameLab.textAlignment = NSTextAlignmentLeft;
        //chevron.right
        UIImageView *chevronImageView = [[UIImageView alloc] init];
        chevronImageView.image = [UIImage systemImageNamed:@"chevron.right"];
        chevronImageView.tintColor = [UIColor colorNamed:@"#B3B3B3'00^#5D5D5D'00"];
        
        [_topView addSubview:avaterImageView];
        [_topView addSubview:nameLab];
        [_topView addSubview:chevronImageView];
        //设置位置
        [avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_topView).offset(30);
            make.left.equalTo(_topView).offset(30);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(avaterImageView);
            make.left.equalTo(avaterImageView.mas_right).offset(30);
            make.size.mas_equalTo(CGSizeMake(200, 50));
        }];
        [chevronImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(avaterImageView);
            make.right.equalTo(_topView).offset(-20);
//            make.size.mas_equalTo(CGSizeMake(17, 22));
        }];
        //设置点击手势
        UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToChangeAvater)];
        [_topView addGestureRecognizer:tapGestureRecognizer];
        _topView.userInteractionEnabled = YES;
    }
    return _topView;
}

- (NSArray<MineModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"minePageData.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *ma = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            MineModel *model = [[MineModel alloc] init];
            [model MineModelWithDic:dic];
            [ma addObject:model];
        }
        _dataArray = ma;
    }
    return _dataArray;
}
@end
