//
//  SKKImageZoom.m
//  放大图片与保存Demo
//
//  Created by 宋开开 on 2022/5/27.
//

#import "SKKImageZoom.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface SKKImageZoom() <UIScrollViewDelegate>

@end

@implementation SKKImageZoom

static CGRect oldframe;
UIImage *_image;
UIImageView *imgView;
UIButton *downloadBtn;

#pragma mark - Method
///单例
+ (instancetype)shareInstance {
    static SKKImageZoom * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SKKImageZoom alloc]init];
    });
    return instance;
}
/// 接收image
/// @param contentImageView 接收到的图片
- (void)imageZoomWithImageView:(UIImageView *)contentImageView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self scanBigImage:contentImageView.image Frame:[contentImageView convertRect:contentImageView.bounds toView:window]];
}

/// 放大图片
/// @param image 图片
/// @param frame 图片尺寸
- (void)scanBigImage:(UIImage *)image Frame:(CGRect)frame {
    _image = image;
    oldframe = frame;
    //当前视图
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIScrollView *backgroundView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    backgroundView.backgroundColor = [UIColor colorWithRed:41/255.0 green:42/255.0 blue:47/255.0 alpha:1.0];
    backgroundView.delegate = self;
    backgroundView.showsVerticalScrollIndicator = NO;
    backgroundView.showsHorizontalScrollIndicator = NO;
    //此时视图不会显示
    [backgroundView setAlpha:0];
    
    backgroundView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = image;
    [imgView setTag:1];
    [backgroundView addSubview:imgView];
    
    //动画放大
    CGFloat width = SCREENWIDTH;
    CGFloat height = image.size.height * (SCREENWIDTH / image.size.width);
    CGFloat y = (SCREENHEIGHT - height) * 0.5;
    
    [UIView animateWithDuration:0.4 animations:^{
        [imgView setFrame:CGRectMake(0, y, width, height)];
        //此时显示视图
        [backgroundView setAlpha:1];
    } completion:^(BOOL finished) {
        
    }];
    //设置缩放尺寸
    backgroundView.maximumZoomScale = SCREEN_HEIGHT / height + 0.1;
    backgroundView.minimumZoomScale = 1.0;
    backgroundView.zoomScale = 1.0;
    //使视图保持中心位置
    [self centerScrollViewContents:backgroundView];
    [window addSubview:backgroundView];

    //1.恢复原图手势
    UITapGestureRecognizer *tapRecoverGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    [backgroundView addGestureRecognizer:tapRecoverGestureRecognizer];
    //点击下载Btn，保存图片到相册
    downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(320, 550, 50, 50)];
    [downloadBtn setBackgroundImage:[UIImage systemImageNamed:@"square.and.arrow.down"] forState:UIControlStateNormal];
    [downloadBtn setTintColor:[UIColor whiteColor]];
    [downloadBtn addTarget:self action:@selector(clickDownload) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:downloadBtn];
}

//使图片居中
- (void)centerScrollViewContents:(UIScrollView *)scrollView{
    CGSize boundsSize = scrollView.bounds.size;
    CGRect contentsFrame = imgView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    imgView.frame = contentsFrame;
}

/// 恢复原图
/// @param tap 手势
- (void)hideImageView:(UITapGestureRecognizer *)tap {
    UIView *backgroundView = tap.view;
    //原始imageview
    UIImageView *imageView = [tap.view viewWithTag:1];
    //恢复
    [UIView animateWithDuration:0.4 animations:^{
        [imageView setFrame:oldframe];
        [backgroundView setAlpha:0];
    } completion:^(BOOL finished) {
        //完成后操作->将背景视图删掉
        [downloadBtn removeFromSuperview];
        [backgroundView removeFromSuperview];
    }];
}

/// 点击下载图片
- (void)clickDownload {
    UIImageWriteToSavedPhotosAlbum(imgView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:) ,nil);
}

/// 保存图片后的回调
/// @param image 图像
/// @param error 错误信息
/// @param contextInfo <#contextInfo description#>
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo {
    if(!error) {
        NSLog(@"成功保存到相册");
    }else {
        NSLog(@"保存出错：%@", error);
    }
}

#pragma mark - Delegate
// MARK: <UIScrollViewDelegate>
//要缩放的控件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imgView;
}

//保持中心位置
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents:(scrollView)];
}
@end
