//
//  MomentsPageVC.m
//  WeChat 
//
//  Created by 宋开开 on 2022/5/29.
//

//发布和评论的数据存储

#import "MomentsPageVC.h"

//VC
#import "PublishVC.h"
#import "CommentVC.h"

//View
#import "MomentsCell.h"
#import "popFuncView.h"

//MomentsModel
#import "MomentsModel.h"

//Tools
#import "YYText.h"
#import "Masonry.h"
#import "NSDate+Day.h"

#define PublishManager [PublishManager shareInstance]
#define CommentManager [CommentManager shareInstance]
#define MomentModelManager [MomentsModelManager shareInstance]

@interface MomentsPageVC () <
UITableViewDataSource,
UITableViewDelegate,
MomentsCellDelegate,
popFuncViewDelegate
>

@property (nonatomic, strong) NSArray <MomentsModel *> *dataArray;

@property (nonatomic, strong) UITableView *tableView;

//多功能按钮
@property (nonatomic, strong) popFuncView *popFuncView;

//背景蒙版（使点击任意一处退出多功能按钮）
@property (nonatomic, strong) UIView *backView;

//朋友圈顶部的封面
@property (nonatomic, strong) UIView *topView;

///发布按钮
@property (nonatomic, strong) UIButton *publishBtn;

///是否已经点过赞
@property (nonatomic) BOOL liked;

@end

@implementation MomentsPageVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //从本地读取数据
    [self saveData];
    //设置数据
    self.dataArray = [NSMutableArray array];
    self.dataArray = [MomentModelManager getAllPublishData];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.topView;
    [self getIntoPublishVC];
}

#pragma mark - Method
///把plist文件里的数据写入数据存储
- (void)saveData {
    //创建数据库
    BOOL result = [MomentModelManager creatWCDB];
    if (result) {
        //创建成功，添加plist数据
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
        //写入本地
        BOOL flag = [MomentModelManager insertDatas:tempMa];
        if (flag) {
            NSLog(@"初始数据写入成功");
        }
    }else {
        NSLog(@"VC表格已存在");
    }
}
///进入发布界面
- (void)getIntoPublishVC {
    self.publishBtn = [[UIButton alloc] init];
    [self.publishBtn setBackgroundImage:[UIImage systemImageNamed:@"camera.fill"] forState:UIControlStateNormal];
    self.publishBtn.tintColor = [UIColor colorNamed:@"#1A1A1A'00^#D0D0D0'00"];
    self.publishBtn.frame = CGRectMake(SCREEN_WIDTH - 40, StatusBarHeight - 8, 28, 20);
    [self.publishBtn addTarget:self action:@selector(clickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    //navigationBar
    [self.navigationController.navigationBar addSubview:self.publishBtn];
//    [self.navigationController.view addSubview:self.publishBtn];
}

///发布的数据中，images是NSData类型的，需要转化
- (void)convertPublishImageData {
    //属于自己发布的数据
    NSMutableArray *selfPublishDataMa = [NSMutableArray array];
    //自己发布的数据中NSData形式的图片组
    NSMutableArray<NSMutableArray *> *imagesMa = [NSMutableArray array];
    for (int i = 4; i < self.dataArray.count; i++) {
        [selfPublishDataMa addObject:self.dataArray[i]];
        [imagesMa addObject:self.dataArray[i].images];
    }
    //逐个转化
    for (int i = 0; i < selfPublishDataMa.count; i++) {
        for (int j = 0; j < imagesMa[i].count; j++) {
            //把NSData转换为UIImage
            
        }
    }
//    NSMutableArray *imagesArray = self.dataArray
}
///加上背景蒙版（使点击任意一处退出多功能按钮）
- (void)showBackViewWithGesture {
    [self.view.window addSubview:self.backView];
}

///退出多功能按钮
- (void)dismissBackViewWithGesture {
    [self.popFuncView removeFromSuperview];
    [self.backView removeFromSuperview];
}
#pragma mark - <UITableDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"self.dataArray.coun = %lu", self.dataArray.count);
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //要取倒转的
    unsigned long index = self.dataArray.count - 1 - indexPath.row;
    MomentsModel *model = self.dataArray[index];
    static NSString *momentsCellID = @"momentsCellID";
    MomentsCell *momentsCell = [tableView dequeueReusableCellWithIdentifier:momentsCellID];
    if (momentsCell == nil) {
        momentsCell = [[MomentsCell alloc] init];
        momentsCell.cellDelegate = self;
        //设置cell无法点击
        [momentsCell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        //点赞
//        NSMutableArray *likesMutArray = [NSMutableArray array];
//        for (int i = 0; i < model.likes.count; i++) {
//            [likesMutArray addObject:model.likes[i]];
//        }
//        //评论
//        NSMutableArray *commentsMutArray = [NSMutableArray array];
//        for (int i = 0; i < model.comments.count; i++) {
//            [commentsMutArray addObject:model.comments[i]];
//        }
//        NSLog(@"likes : %@", likesMutArray);
        //设置数据
        [momentsCell setAvatarImgData:model.avatar NameText:model.person Text:model.text ImagesArray:model.images DateText:model.time LikesTextArray:model.likes CommentsTextArray:model.comments Index:index];
    }
    return momentsCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *nowCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (nowCell == nil) {
        return 0;
    }else {
        return nowCell.frame.size.height;
    }
}

#pragma mark - Delegate
// MARK: <MomentsCellDelegate>
- (void)clickFuncBtn:(MomentsCell *)cell {
    UIWindow *window = self.view.window;
    CGRect frame = [cell.likeOrCommentBtn convertRect:cell.likeOrCommentBtn.bounds toView:window];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //取反
    long tag = [MomentModelManager getAllPublishData].count - indexPath.row - 1;
//    NSLog(@"indexPath = %@", indexPath);
    //加入背景蒙版
    [self showBackViewWithGesture];
    //做标记
    self.popFuncView.likesBtn.tag = tag;
    self.popFuncView.commentsBtn.tag = tag;
    //给点赞设置标题
    if ([self isLiked:tag]) {
        //之前已经点过赞
        self.popFuncView.likeLab.text = @"取消";
        self.liked = YES;
    }else {
        self.popFuncView.likeLab.text = @"赞";
        self.liked = NO;
    }
    //根据数据存储来设定是 "赞" 还是 "取消"
//    self.popFuncView.likeLab.text = @"赞";
    self.popFuncView.frame = CGRectMake(frame.origin.x - SCREEN_WIDTH * 0.47, frame.origin.y, 172, 35);
    [self.view.window addSubview:self.popFuncView];
    
}

// MARK: <popFuncViewDelegate>
/// 点击点赞按钮
/// @param sender 该按钮
- (void)clickLikeBtn:(UIButton *)sender {
    //找到该cell(要倒转）
    long tag = sender.tag;
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataArray[tag].likes];

    //需要查看是否在上一次已点赞
    if (self.liked) {  //上次已经点了赞
        [tempArray removeObject:LikeName];
        self.popFuncView.likeLab.text = @"赞";
        self.liked = NO;
    }else {
            [tempArray addObject:LikeName];
            self.popFuncView.likeLab.text = @"取消";
    }

    self.dataArray[tag].likes = tempArray;
    //同时数据存储
    //1.拿到该条数据
    MomentsModel *model = [MomentModelManager getAllPublishData][tag];
    NSLog(@"model.person = %@", model.person);
    //2.修改点赞数据
    model.likes = tempArray;
    [MomentModelManager updataLikesData:model];
//    [self.popFuncView removeFromSuperview];
    [self.tableView reloadData];
}

///查看是否在上一次已点赞
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
    //取反
    long tag = sender.tag;
    __block CommentVC *commentVC = [[CommentVC alloc] init];
    [self.navigationController pushViewController:commentVC animated:NO];
    //信息回调
    commentVC.getCommentsData = ^(NSString * _Nonnull commentsText) {
        //1.拿到该条cell
        MomentsModel *model = [MomentModelManager getAllPublishData][tag];
        //2.修改
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataArray[tag].comments];
        [tempArray addObject:commentsText];
        model.comments = tempArray;
        //3.更新
        [MomentModelManager updataCommentsData:model];
        self.dataArray = [MomentModelManager getAllPublishData];
        [self.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
    };
}

/// 点击发布按钮
/// @param sender 该按钮
- (void)clickPublishBtn:(UIButton *)sender {
    [self.popFuncView removeFromSuperview];
    self.navigationController.navigationBarHidden = YES;
    //取反
//    long tag = sender.tag;
    PublishVC *publishVC = [[PublishVC alloc] init];
    [self.navigationController pushViewController:publishVC animated:NO];
    //成功发布后的信息回调
    publishVC.getPublishData = ^(NSString * _Nullable text, NSMutableArray * _Nullable imageArray) {
        MomentsModel *newModel = [[MomentsModel alloc] init];
        //设置数据
        newModel.published = 1;
        newModel.person = @"Vermouth";
        newModel.avatar = @"avatar";
        newModel.text = text;
        newModel.images = imageArray;
        newModel.time = [self currentTime];
//        newModel.likes = @[ ];
//        newModel.comments =
        //添加到数据库中
        [MomentModelManager insertData:newModel];
        self.dataArray = [MomentModelManager getAllPublishData];
        [self.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
    };
}
//获取时间
- (NSString *)currentTime {
    NSString *hour = [[NSDate today] hour];
    NSString *separator = @" : ";
    NSString *min = [separator stringByAppendingString:[[NSDate today] min]];
    NSString *currentTime = [hour stringByAppendingString:min];
    return currentTime;
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

//- (NSMutableArray<MomentsModel *> *)dataArray {
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"momentData.plist" ofType:nil];
//        NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
//        for (NSDictionary *dic in data) {
//            MomentsModel *model = [[MomentsModel alloc] init];
//            [model MomentsModelWithDic:dic];
//            [_dataArray addObject:model];
//        }
//    }
//    return _dataArray;
//}

- (popFuncView *)popFuncView {
    if (_popFuncView == nil) {
        _popFuncView = [[popFuncView alloc] init];
        _popFuncView.popFuncViewDelegate = self;
    }
    return _popFuncView;
}

- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _backView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBackViewWithGesture)];
        [_backView addGestureRecognizer:dismiss];
    }
    return _backView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.frame = CGRectMake(0, -65, SCREEN_WIDTH, 350);
        //topImageView
        UIImageView *topImageView = [[UIImageView alloc] init];
        topImageView.image = [UIImage imageNamed:@"topImage"];
        topImageView.frame = CGRectMake(0, -45, SCREEN_WIDTH, 350);
        //avatarImgView
        UIImageView *avatarImgView = [[UIImageView alloc] init];
        avatarImgView.image = [UIImage imageNamed:@"avatar"];
        avatarImgView.layer.masksToBounds = YES;
        avatarImgView.layer.cornerRadius = 8;
//        //nameLab
        UILabel *nameLab = [[UILabel alloc] init];
        nameLab.text = @"Vermouth";
        nameLab.textColor = [UIColor whiteColor];
        nameLab.textAlignment = NSTextAlignmentRight;
        nameLab.font = [UIFont boldSystemFontOfSize:22];
        
        [_topView addSubview:topImageView];
        [_topView addSubview:nameLab];
        [_topView addSubview:avatarImgView];
        
        //位置
        [avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_topView).offset(-15);
            make.bottom.equalTo(_topView).offset(-20);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
        
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(avatarImgView.mas_left).offset(-10);
            make.centerY.equalTo(avatarImgView).offset(-5);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
    }
    return _topView;
}
@end
