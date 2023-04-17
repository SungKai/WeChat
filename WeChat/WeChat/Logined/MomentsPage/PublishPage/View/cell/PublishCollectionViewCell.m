//
//  PublishCollectionViewCell.m
//  WeChat
//
//  Created by 宋开开 on 2022/6/12.
//

#import "PublishCollectionViewCell.h"


@implementation PublishCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc] init];
        self.imgView.frame = CGRectMake(0, 0, 100, 100);
        [self.contentView addSubview:self.imgView];
    }
    return self;
}


@end
