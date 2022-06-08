//
//  MomentsCell.m
//  YYLabel图文混排
//
//  Created by 宋开开 on 2022/6/1.
//

#import "MomentsCell.h"
#define Right 80
#define TopAndBottomMargin 20
#define LeftAndRightMargin 14
@implementation MomentsCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorNamed:@"#FEFEFE'00^#191919'00"];
        [self setData];
        [self setPosition];
    }
    return self;
}

#pragma mark - Method

//设置数据
- (void)setAvatarImgData:(NSString *)avatarImgData NameText:(NSString *)name Text:(NSString *)text ImagesArray:(NSArray *)imagesArray DateText:(NSString *)dateText  LikesTextArray:(NSMutableArray <NSString *> *)likesTextArray CommentsTextArray:(NSMutableArray <NSString *> *)commentsTextArray {
    self.avatarImg.image = [UIImage imageNamed:avatarImgData];
    self.nameText = name;
    self.text = text;
    self.imagesArray = imagesArray;
    self.dateText = dateText;
    self.likesTextArray = likesTextArray;
    self.commentsTextArray = commentsTextArray;
    [self AddView];
}
//判断数据
- (void)AddView {
    unsigned long likesNumbers = self.likesTextArray.count;
    unsigned long commentsNumbers = self.commentsTextArray.count;
    //1.没有点赞也没有评论
    if (likesNumbers == 0 && commentsNumbers == 0) {  //1.没有点赞也没有评论
        //设置UI
        [self setTextWithImage];
        [self.contentView addSubview:self.yyTextLab];
        //定高度
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.singleHeight + TopAndBottomMargin);
    }
    //2.有点赞没评论
    if (likesNumbers != 0 && commentsNumbers == 0) {
        //设置UI
        [self setTextWithImage];
        [self setLikesCell];
        [self.contentView addSubview:self.yyTextLab];
        [self.contentView addSubview:self.yylikesLab];
        //定高度
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.likesHeight + TopAndBottomMargin);
    }
    //3.有评论没有点赞
    if (likesNumbers == 0 && commentsNumbers != 0) {
        //设置UI
        [self setTextWithImage];
        [self setCommentsCell];
        [self.contentView addSubview:self.yyTextLab];
        [self.contentView addSubview:self.yyCommentsLab];
        
        //评论的frame:
        self.yyCommentsLab.frame = CGRectMake(Right, self.singleHeight + 15, SCREEN_WIDTH - Right - LeftAndRightMargin, self.singleCommentsHeight);
        //定高度
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.commentsHeight + TopAndBottomMargin);
    }
    
    //3.有点赞有评论(有分割线）
    if (likesNumbers != 0 && commentsNumbers != 0) {
        //设置UI
        [self setTextWithImage];
        [self setLikesCell];
        [self setCommentsCell];
        [self.contentView addSubview:self.yyTextLab];
        [self.contentView addSubview:self.yylikesLab];
        [self.contentView addSubview:self.yyCommentsLab];
        
        //评论的frame:
        self.yyCommentsLab.frame = CGRectMake(Right, self.likesHeight + 0.8, SCREEN_WIDTH - Right - LeftAndRightMargin, self.singleCommentsHeight);
        //分割线
        [self.contentView addSubview:self.separator];
        [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.yylikesLab);
            make.right.equalTo(self.yylikesLab);
            make.top.equalTo(self.yylikesLab.mas_bottom);
            make.bottom.equalTo(self.yyCommentsLab.mas_top);
        }];
        //定高度
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.commentsHeight + self.likesHeight - self.singleHeight - 20 + TopAndBottomMargin);
    }
}
// MARK: YYText 富文本

// MARK: 无点赞评论的情况
- (void)setTextWithImage {
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:20];
    
    //1.人名
    UILabel *lab = [[UILabel alloc] init];
    lab.text = self.nameText;
    lab.font = [UIFont boldSystemFontOfSize:23];
    lab.textColor = [UIColor colorNamed:@"#576B94'00^#7C90A8'00"];
    lab.frame = CGRectMake(Right, TopAndBottomMargin, SCREEN_WIDTH - Right - LeftAndRightMargin, 30);
    NSMutableAttributedString *nameAtt =
    [NSMutableAttributedString
        yy_attachmentStringWithContent:lab
                           contentMode:UIViewContentModeLeft
                        attachmentSize:CGSizeMake(SCREEN_WIDTH - Right - LeftAndRightMargin, 30)  //图片占位符
                           alignToFont:font
                             alignment:YYTextVerticalAlignmentBottom
    ];
    [text appendAttributedString:nameAtt];
    
    //2.正文
    NSMutableAttributedString *textAtt = [[NSMutableAttributedString alloc] initWithString:[self.text stringByAppendingString:@"\n"]];
    textAtt.yy_font = font;
    textAtt.yy_color = [UIColor colorNamed:@"#1A1A1A'00^#D0D0D0'00"];
    [text appendAttributedString:textAtt];
    
    //3.图片
    for (int i = 0; i < self.imagesArray.count; i++) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imagesArray[i]]];
        //点击放大保存手势
        UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageZoom:)];
        [image addGestureRecognizer:tapGestureRecognizer];
        [image setUserInteractionEnabled:YES];
        NSMutableAttributedString *imageAtt = [[NSMutableAttributedString alloc] init];
        //正常情况，一张图片的占位符应该是该图片本身的size
        imageAtt =
        [NSMutableAttributedString
            yy_attachmentStringWithContent:image
                               contentMode:UIViewContentModeLeft
                            attachmentSize:CGSizeMake(image.frame.size.width + 5, image.frame.size.height + 5) //图片占位符
                               alignToFont:font
                                 alignment:YYTextVerticalAlignmentBottom];
        [text appendAttributedString:imageAtt];
        //最后一张时需要回车换行
        if (i == self.imagesArray.count - 1) {
            NSMutableAttributedString *textAtt = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
            textAtt.yy_font = font;
            [text appendAttributedString:textAtt];
        }
    }
    
    //4.时间
    NSMutableAttributedString *timeAtt = [[NSMutableAttributedString alloc] initWithString:self.dateText];
    timeAtt.yy_font = [UIFont systemFontOfSize:18];
    timeAtt.yy_color = [UIColor colorNamed:@"#C5C5C5'00^#5D5D5D'00"];
    [text appendAttributedString:timeAtt];
    
    //5.设置YYText属性
    self.yyTextLab.attributedText = text;
    self.yyTextLab.numberOfLines = 0;  //设置多行
    self.yyTextLab.textAlignment = NSTextAlignmentLeft;
   
    //计算尺寸
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:self.maxSize text:text];
    self.yyTextLab.textLayout = layout;
    CGFloat introHeight = layout.textBoundingSize.height;
    self.yyTextLab.frame = CGRectMake(Right, TopAndBottomMargin, SCREEN_WIDTH - Right - LeftAndRightMargin, introHeight);
    self.singleHeight = introHeight + TopAndBottomMargin;
}
// MARK: 有点赞的情况
- (void)setLikesCell {
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size: 18];
    
    //1.点赞的爱心图案
    UIImage *img = [[UIImage alloc] init];
    img = [UIImage imageNamed:@"like"];
    NSMutableAttributedString *likeImageAtt =
    [NSMutableAttributedString
        yy_attachmentStringWithContent:img
                           contentMode:UIViewContentModeCenter
                        attachmentSize:CGSizeMake(30, 25)  //图片占位符
                           alignToFont:font
                             alignment:YYTextVerticalAlignmentBottom
    ];
    [text appendAttributedString:likeImageAtt];
    
    //2.点赞人
    for (int i = 0; i < self.likesTextArray.count; i++) {
        NSMutableAttributedString *nameAtt;
        //"Gin,
        if (i != self.likesTextArray.count - 1) {
            nameAtt = [[NSMutableAttributedString alloc] initWithString:[self.likesTextArray[i] stringByAppendingString:@", "]];
        }else {
            nameAtt = [[NSMutableAttributedString alloc] initWithString:self.likesTextArray[i]];
        }
        nameAtt.yy_font = font;
        nameAtt.yy_color = [UIColor colorNamed:@"#576B94'00^#7C90A8'00"];
        nameAtt.yy_headIndent = 10;
        nameAtt.yy_firstLineHeadIndent = 10;
        [text appendAttributedString:nameAtt];
    }
    
    //3.设置YYText属性
    self.yylikesLab.attributedText = text;
    self.yylikesLab.numberOfLines = 0;  //设置多行
    self.yylikesLab.textAlignment = NSTextAlignmentLeft;
    self.yylikesLab.backgroundColor = [UIColor colorNamed:@"#F7F7F7'00^#202020'00"];
   
    //计算尺寸
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:self.maxSize text:text];
    self.yylikesLab.textLayout = layout;
    CGFloat introHeight = layout.textBoundingSize.height;
    self.yylikesLab.frame = CGRectMake(Right, self.singleHeight + 15, SCREEN_WIDTH - Right - LeftAndRightMargin, introHeight + 10);
    self.likesHeight = self.singleHeight + 15 + introHeight + 10; //只有点赞信息的cell的高度
}

// MARK: 有评论的情况
- (void)setCommentsCell {
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:19];
    //1.评论信息
    for (int i = 0; i < self.commentsTextArray.count; i++) {
        NSMutableAttributedString *commentsAtt = [[NSMutableAttributedString alloc] initWithString:[self.commentsTextArray[i] stringByAppendingString:@"\n"]];
        //找到评论人
        NSString *person = [self.commentsTextArray[i] componentsSeparatedByString: @" :"][0];
//        NSLog(@"person = %@", person);
        commentsAtt.yy_font = font;
        commentsAtt.yy_color = [UIColor colorNamed:@"#191919'00^#A5A5A5'00"];
        //设置不同颜色
        NSRange range = [self.commentsTextArray[i] rangeOfString:person];
        [commentsAtt yy_setColor:[UIColor colorNamed:@"#576B94'00^#7C90A8'00"] range:range];
        [commentsAtt yy_setFont:font range:range];
        commentsAtt.yy_headIndent = 10;
        commentsAtt.yy_firstLineHeadIndent = 10;
        [text appendAttributedString:commentsAtt];  //换行？
    }
    self.yyCommentsLab.attributedText = text;
    self.yyCommentsLab.numberOfLines = 0;  //设置多行
    
    self.yyCommentsLab.preferredMaxLayoutWidth = SCREEN_WIDTH - Right - LeftAndRightMargin;
    self.yyCommentsLab.textAlignment = NSTextAlignmentLeft;
    self.yyCommentsLab.backgroundColor = [UIColor colorNamed:@"#F7F7F7'00^#202020'00"];
    
    //计算尺寸
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:self.maxSize text:text];
    self.yyCommentsLab.textLayout = layout;
    CGFloat introHeight = layout.textBoundingSize.height;
    //commentsHeight 指的是评论高度加上内容高度singleHeight
    self.singleCommentsHeight = introHeight + TopAndBottomMargin;
    self.commentsHeight = self.singleHeight + 15 + self.singleCommentsHeight;
}

//点击图片放大与保存
- (void)clickImageZoom:(UIGestureRecognizer *)tap {
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [[SKKImageZoom shareInstance] imageZoomWithImageView:clickedImageView];
}
- (void)setPosition {
    //avatarImg
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(TopAndBottomMargin);
        make.left.equalTo(self.contentView).offset(LeftAndRightMargin);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
    //likeOrCommentBtn
    [self.likeOrCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.yyTextLab).offset(-5);
        make.bottom.equalTo(self.yyTextLab);
        make.size.mas_equalTo(CGSizeMake(35, 25));
    }];
}
// MARK: 初始化数据
- (void)setData {
    self.likesHeight = 0;
    self.commentsHeight = 0;
    self.self.maxSize = CGSizeMake(SCREEN_WIDTH - Right - LeftAndRightMargin, MAXFLOAT);
    //avatarImg
    self.avatarImg = [[UIImageView alloc] init];
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.cornerRadius = 6;
    [self.contentView addSubview:self.avatarImg];
    
    //imagesArray
    self.imagesArray = [NSArray array];
    
    //likesTextArray
    self.likesTextArray = [NSMutableArray array];
    
    //commentsTextArray
    self.commentsTextArray = [NSMutableArray array];
    
    //YYLabel
    self.yyTextLab = [[YYLabel alloc] init];
    self.yylikesLab = [[YYLabel alloc] init];
    self.yyCommentsLab = [[YYLabel alloc] init];
    
    //评论或点赞的按钮(多功能按钮)
    self.likeOrCommentBtn = [[UIButton alloc] init];
    [self.likeOrCommentBtn setBackgroundImage:[UIImage imageNamed:@"likeComment.white"] forState:UIControlStateNormal];
    self.likeOrCommentBtn.layer.masksToBounds = YES;
    self.likeOrCommentBtn.layer.cornerRadius = 5;
    [self.likeOrCommentBtn addTarget:self action:@selector(ClickFuncBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.yyTextLab addSubview:self.likeOrCommentBtn];
    
    //separator
    self.separator = [[UIView alloc] init];
    self.separator.backgroundColor = [UIColor colorNamed:@"#E5E5E5'00^#252524'00"];
    
}
//点击多功能按钮
- (void)ClickFuncBtn {
    [self.cellDelegate clickFuncBtn:self];
}
@end
