//
//  MomentsPageVC.m
//  WeChat 
//
//  Created by 宋开开 on 2022/5/29.
//

// 发布和评论的数据存储

#import "MomentsPageVC.h"

// VC
#import "PublishVC.h"
#import "CommentVC.h"
 
// View
#import "MomentsCell.h"
#import "popFuncView.h"

// MomentsModel
#import "MomentsModel.h"

// Tools
#import "YYText.h"
#import "Masonry.h"
#import "NSDate+Day.h"
#import "AvatarDatabase.h"  // 头像数据库

#define MomentModelManager [MomentsModelManager shareInstance]
#define AvatarDatabaseManager [AvatarDatabaseManager shareInstance]

@interface MomentsPageVC () <
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, strong) NSArray <MomentsModel *> *dataArray;

@property (nonatomic, strong) UITableView *tableView;

/// 多功能按钮
@property (nonatomic, strong) popFuncView *popFuncView;

/// 背景蒙版（使点击任意一处退出多功能按钮）
@property (nonatomic, strong) UIView *backView;

/// 朋友圈顶部的封面
@property (nonatomic, strong) UIView *topView;

/// 头像
@property (nonatomic, strong) UIImageView *avatarImgView;

/// 发布按钮
@property (nonatomic, strong) UIButton *publishBtn;

/// 是否已经点过赞
@property (nonatomic) BOOL liked;

@end

@implementation MomentsPageVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 从本地读取数据
    [self saveData];
    // 设置数据
    self.dataArray = [NSMutableArray array];
    self.dataArray = [MomentModelManager getAllPublishData];
    // 设置tableView
    [self.view addSubview:self.tableView];
    // 设置tableView的顶部视图
    self.tableView.tableHeaderView = self.topView;
    // 根据数据库信息来设置头像
    [self setAvatarImageView];
    // 设置发布按钮
    [self getIntoPublishVC];
    // 下拉刷新
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = control;
    // 加入SEL
    [self addSELAndGesture];
}

#pragma mark - Method

/// 下拉刷新
- (void)refreshTableView {
    [self.tableView reloadData];
    //根据数据库信息来设置头像
    [self setAvatarImageView];
    if ([self.tableView.refreshControl isRefreshing]) {
        [self.tableView.refreshControl endRefreshing];
    }
}

/// 根据数据库信息来设置头像
- (void)setAvatarImageView {
    // 从数据库取得数据
    NSData *data = [AvatarDatabaseManager getAvatarInformation];
    self.avatarImgView.image = [UIImage imageWithData:data];
}

/// 把plist文件里的数据写入数据存储
- (void)saveData {
    // 创建数据库
    BOOL result = [MomentModelManager creatWCDB];
    if (result) {
        // 创建成功，添加plist数据
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"momentData.plist" ofType:nil];
        NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *tempMa = [NSMutableArray array];
        
        for (NSDictionary *dic in data) {
            MomentsModel *model = [[MomentsModel alloc] init];
            [model MomentsModelWithDic:dic];
            NSLog(@"model.person = %@", model.person);
            model.published = 1;
            NSLog(@"%ld", (long)model.published);
            [tempMa addObject:model];
        }
        // 写入本地
        BOOL flag = [MomentModelManager insertDatas:tempMa];
        if (flag) {
            NSLog(@"初始数据写入成功");
        }
    } else {
        NSLog(@"VC表格已存在");
    }
}

///进入发布界面
- (void)getIntoPublishVC {
    self.publishBtn = [[UIButton alloc] init];
    [self.publishBtn setBackgroundImage:[UIImage systemImageNamed:@"camera.fill"] forState:UIControlStateNormal];
    self.publishBtn.tintColor = [UIColor colorNamed:@"#1A1A1A'00^#D0D0D0'00"];
    self.publishBtn.frame = CGRectMake(SCREEN_WIDTH - 40, 10, 28, 20);
    [self.publishBtn addTarget:self action:@selector(clickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    // navigationBar
    [self.navigationController.navigationBar addSubview:self.publishBtn];
}

/// 点击发布按钮
/// @param sender 该按钮
- (void)clickPublishBtn:(UIButton *)sender {
    [self.popFuncView removeFromSuperview];
    self.navigationController.navigationBarHidden = YES;
    PublishVC *publishVC = [[PublishVC alloc] init];
    [self.navigationController pushViewController:publishVC animated:NO];
    // 成功发布后的信息回调
    publishVC.getPublishData = ^(NSString * _Nullable text, NSMutableArray * _Nullable imageArray) {
        MomentsModel *newModel = [[MomentsModel alloc] init];
        // 设置数据
        newModel.published = 1;
        newModel.person = @"Vermouth";
        newModel.text = text;
        newModel.images = imageArray;
        newModel.time = [self currentTime];
        // 添加到数据库中
        [MomentModelManager insertData:newModel];
        self.dataArray = [MomentModelManager getAllPublishData];
        // 同时把缓存数据删除
        [MomentModelManager deleteData];
        // 发布成功后回到顶部
        [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        [self.tableView reloadData];
        // 返回
        [self.navigationController popViewControllerAnimated:YES];
        // 恢复头尾的bar
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
    };
}

/// 获取当前时间
- (NSString *)currentTime {
    NSString *hour = [[NSDate today] hour];
    NSString *separator = @" : ";
    NSString *min = [separator stringByAppendingString:[[NSDate today] min]];
    NSString *currentTime = [hour stringByAppendingString:min];
    return currentTime;
}

/// 加上背景蒙版（使点击任意一处退出多功能按钮）
- (void)showBackViewWithGesture {
    [self.view.window addSubview:self.backView];
}

- (void)addSELAndGesture {
    // popFuncView
    [self.popFuncView.likesBtn addTarget:self action:@selector(clickLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.popFuncView.commentsBtn addTarget:self action:@selector(clickCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
    // backView
    // 手势1:点击任意一处使多功能按钮消失
    UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBackViewWithGesture)];
    [self.backView addGestureRecognizer:dismiss];
    // 手势2:使上下滑动时也使多功能按钮消失
    UISwipeGestureRecognizer *swipeUP = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBackViewWithGesture)];
    swipeUP.direction = UISwipeGestureRecognizerDirectionUp;
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBackViewWithGesture)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.backView addGestureRecognizer:swipeUP];
    [self.backView addGestureRecognizer:swipeDown];
}

// MARK: SEL

// 点击多功能按钮
- (void)clickFuncBtn:(UIButton *)sender withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
    MomentsCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIWindow *window = self.view.window;
    CGRect frame = [cell.likeOrCommentBtn convertRect:cell.likeOrCommentBtn.bounds toView:window];
    // 取反
    long tag = [MomentModelManager getAllPublishData].count - indexPath.row - 1;
    // 加入背景蒙版
    [self showBackViewWithGesture];
    // 做标记
    self.popFuncView.likesBtn.tag = tag;
    self.popFuncView.commentsBtn.tag = tag;
    // 给点赞设置标题
    if ([self isLiked:tag]) {
        //之前已经点过赞
        self.popFuncView.likeLab.text = @"取消";
        self.liked = YES;
    } else {
        self.popFuncView.likeLab.text = @"赞";
        self.liked = NO;
    }
    self.popFuncView.frame = CGRectMake(frame.origin.x - SCREEN_WIDTH * 0.47, frame.origin.y, 172, 35);
    [self.view.window addSubview:self.popFuncView];
}

// 点击删除按钮
- (void)clickDeleteBtn:(UIButton *)sender withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
    // 取反
    long tag = [MomentModelManager getAllPublishData].count - indexPath.row - 1;
    // 删除此信息
    MomentsModel *momentModel = self.dataArray[tag];
    NSLog(@"momentModel.person = %@", momentModel.person);
    BOOL res = [MomentModelManager deleteOrderData:momentModel];
    if (res) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
    self.dataArray = [MomentModelManager getAllPublishData];
    [self.tableView reloadData];
}

/// 点击点赞按钮
/// @param sender 该按钮
- (void)clickLikeBtn:(UIButton *)sender {
    // 点赞爱心放大
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima.byValue = @(0.7);
    [self.popFuncView.likeImageView.layer addAnimation:anima forKey:@"scaleAnimation"];
    // popView自动消失
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500/*延迟执行时间*/*NSEC_PER_MSEC));
    dispatch_after(delayTime,dispatch_get_main_queue(), ^{
        [self.popFuncView removeFromSuperview];
        // 找到该cell(要倒转）
        long tag = sender.tag;
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataArray[tag].likes];
        // 需要查看是否在上一次已点赞
        if (self.liked) {  // 上次已经点了赞
            [tempArray removeObject:LikeName];
            self.popFuncView.likeLab.text = @"赞";
            self.liked = NO;
        } else {  // 上次没点赞
            [tempArray addObject:LikeName];
            self.popFuncView.likeLab.text = @"取消";
        }

        self.dataArray[tag].likes = tempArray;
        // 同时数据存储
        // 1.拿到该条数据
        MomentsModel *model = [MomentModelManager getAllPublishData][tag];
        // 2.修改点赞数据
        model.likes = tempArray;
        [MomentModelManager updataLikesData:model];
        // 刷新
        [self.tableView reloadData];
    });
}

/// 查看是否在上一次已点赞
- (BOOL)isLiked:(long)tag {
    MomentsModel *model = [MomentModelManager getAllPublishData][tag];
    NSArray *likes = model.likes;
    for (NSString *s in likes) {
        if ([s isEqual: LikeName]) {
            return YES;
        }
    }
    return NO;
}

/// 点击评论按钮
/// @param sender 该按钮
- (void)clickCommentBtn:(UIButton *)sender {
    [self.popFuncView removeFromSuperview];
    self.navigationController.navigationBarHidden = YES;
    // 取反
    long tag = sender.tag;
    CommentVC *commentVC = [[CommentVC alloc] init];
    // 跳转到评论界面
    [self.navigationController pushViewController:commentVC animated:NO];
    // 信息回调
    commentVC.getCommentsData = ^(NSString * _Nonnull commentsText) {
        // 1.拿到该条cell
        MomentsModel *model = [MomentModelManager getAllPublishData][tag];
        // 2.修改
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataArray[tag].comments];
        [tempArray addObject:commentsText];
        model.comments = tempArray;
        // 3.更新
        [MomentModelManager updataCommentsData:model];
        self.dataArray = [MomentModelManager getAllPublishData];
        [self.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
    };
}

/// 退出多功能按钮
- (void)dismissBackViewWithGesture {
    [self.popFuncView removeFromSuperview];
    [self.backView removeFromSuperview];
}

#pragma mark - <UITableDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 要取倒转的
    unsigned long index = self.dataArray.count - 1 - indexPath.row;
    MomentsModel *model = self.dataArray[index];
    static NSString *momentsCellID = @"momentsCellID";
    MomentsCell *momentsCell = [tableView dequeueReusableCellWithIdentifier:momentsCellID];
    if (momentsCell == nil) {
        momentsCell = [[MomentsCell alloc] init];
        momentsCell.nameText = model.person;
        momentsCell.text = model.text;
        momentsCell.imagesArray = model.images;
        momentsCell.dateText = model.time;
        momentsCell.likesTextArray = model.likes;
        momentsCell.commentsTextArray = model.comments;
        momentsCell.index = index;
        // 设置cell无法点击
        [momentsCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        // 头像设置
        // plist文件里的头像设置
        if (index < 4) {
            momentsCell.avatarImageView.image = [UIImage imageNamed:model.avatar];
        } else {  // 自己发布的朋友圈头像
            [momentsCell setAvatarImageView];
        }
        // 设置布局
        [momentsCell AddViews];
        if ([momentsCell.nameText isEqual:@"Vermouth"]) {
            [momentsCell addDeleteBtn];
        }
        [momentsCell.likeOrCommentBtn addTarget:self action:@selector(clickFuncBtn:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        [momentsCell.deleteBtn addTarget:self action:@selector(clickDeleteBtn:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return momentsCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *nowCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (nowCell == nil) {
        return 0;
    } else {
        return nowCell.frame.size.height;
    }
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, - StatusBarHeight - 60, SCREEN_WIDTH, SCREEN_HEIGHT + 60) style:UITableViewStylePlain];
       _tableView.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

- (popFuncView *)popFuncView {
    if (_popFuncView == nil) {
        _popFuncView = [[popFuncView alloc] init];
    }
    return _popFuncView;
}

- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _backView.backgroundColor = [UIColor clearColor];
    }
    return _backView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.frame = CGRectMake(0, -65, SCREEN_WIDTH, 350);
        // topImageView
        UIImageView *topImageView = [[UIImageView alloc] init];
        topImageView.image = [UIImage imageNamed:@"topImage"];
        topImageView.frame = CGRectMake(0, -45, SCREEN_WIDTH, 350);
        // avatarImgView
        _avatarImgView = [[UIImageView alloc] init];
        _avatarImgView.layer.masksToBounds = YES;
        _avatarImgView.layer.cornerRadius = 8;
        // 图片宽高适配
        _avatarImgView.clipsToBounds = YES;
        [_avatarImgView setContentMode:UIViewContentModeScaleAspectFill];
        UILabel *nameLab = [[UILabel alloc] init];
        nameLab.text = @"Vermouth";
        nameLab.textColor = [UIColor whiteColor];
        nameLab.textAlignment = NSTextAlignmentRight;
        nameLab.font = [UIFont boldSystemFontOfSize:22];
        
        [_topView addSubview:topImageView];
        [_topView addSubview:nameLab];
        [_topView addSubview:_avatarImgView];
        // 位置
        [_avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_topView).offset(-15);
            make.bottom.equalTo(_topView).offset(-20);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
        // nameLab
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_avatarImgView.mas_left).offset(-10);
            make.centerY.equalTo(_avatarImgView).offset(-5);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
    }
    return _topView;
}
@end
