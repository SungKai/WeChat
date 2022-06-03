//
//  MomentsPageVC.m
//  WeChat 
//
//  Created by 宋开开 on 2022/5/29.
//

#import "MomentsPageVC.h"
//View
#import "MomentsCell.h"
#import "popFuncView.h"

//MomentsModel
#import "MomentsModel.h"

//Tools
#import "YYText.h"
#import "Masonry.h"

@interface MomentsPageVC ()<
UITableViewDataSource,
UITableViewDelegate,
MomentsCellDelegate,
popFuncViewDelegate
>

@property (nonatomic, strong) NSMutableArray <MomentsModel *> *dataArray;

@property (nonatomic, strong) UITableView *tableView;

//多功能按钮
@property (nonatomic, strong) popFuncView *popFuncView;

//背景蒙版（使点击任意一处退出多功能按钮）
@property (nonatomic, strong) UIView *backView;

@end

@implementation MomentsPageVC
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.view.backgroundColor = [UIColor greenColor];
//    }
//    return self;
//}
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - Method

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
    MomentsModel *model = self.dataArray[self.dataArray.count - 1 - indexPath.row];
    static NSString *momentsCellID = @"momentsCellID";
    MomentsCell *momentsCell = [tableView dequeueReusableCellWithIdentifier:momentsCellID];
    if (momentsCell == nil) {
        momentsCell = [[MomentsCell alloc] init];
        momentsCell.cellDelegate = self;
        //点赞
        NSMutableArray *likesMutArray = [NSMutableArray array];
        NSLog(@"model.likes.count = %lu", model.likes.count);
        for (int i = 0; i < model.likes.count; i++) {
            [likesMutArray addObject:model.likes[i]];
        }
        //评论
        NSMutableArray *commentsMutArray = [NSMutableArray array];
        for (int i = 0; i < model.comments.count; i++) {
            [commentsMutArray addObject:model.comments[i]];
        }
//        NSLog(@"likes : %@", likesMutArray);
        //设置数据
        [momentsCell setAvatarImgData:model.avatar NameText:model.person Text:model.text ImagesArray:model.images DateText:model.time LikesTextArray:likesMutArray CommentsTextArray:commentsMutArray];
        [momentsCell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
    //加入背景蒙版
    [self showBackViewWithGesture];
    //做标记
    self.popFuncView.likesBtn.tag = indexPath.row;
    self.popFuncView.commentsBtn.tag = indexPath.row;
    //给点赞设置标题
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
    long tag = self.dataArray.count - 1 - sender.tag;
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataArray[tag].likes];

    
    sender.selected = !sender.selected;
    //取消选中状态
    if (!sender.selected) {
        [tempArray removeObject:LikeName];
        //同时应该数据存储
    }else {  //选中状态
        [tempArray addObject:LikeName];
        //同时应该数据存储
    }
    self.dataArray[tag].likes = tempArray;
    [self.tableView reloadData];
    //2.取消点赞
    //1）.只有自己的一个点赞就去掉点赞，再把整个点赞框去掉
    //2）.多人点赞，只去掉自己的名字
}

/// 店家评论按钮
/// @param sender 该按钮
- (void)clickCommentBtn:(UIButton *)sender {
    
}
#pragma mark - Getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

- (NSMutableArray<MomentsModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"momentData.plist" ofType:nil];
        NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
//        NSMutableArray *tempMa = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            MomentsModel *model = [[MomentsModel alloc] init];
            [model MomentsMomentsModelWithDic:dic];
            [_dataArray addObject:model];
        }
//        //倒转
//        int i = (int)data.count - 1;
//        for (; i >= 0; i--) {
//            [_dataArray addObject:tempMa[i]];
//        }
    }
    return _dataArray;
}

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
