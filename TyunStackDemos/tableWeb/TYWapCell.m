//
//  NewToutiaoWapCell.m
//  UniversalProject
//
//  Created by zwzh_14 on 2021/11/22.
//  Copyright © 2021 OMT. All rights reserved.
//

#import "TYWapCell.h"
#import <Masonry/Masonry.h>
//#import "MineCenterController.h"

@interface TYWapCell()

//第一次回调触发0.3秒之后刷新数据
@property (nonatomic, assign) BOOL refreshHeight;

@end

@implementation TYWapCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.web = [[ViewController3 alloc]init];
    _web.view.layer.masksToBounds = YES;
    UIViewController *vc = [self parentController];
    if (vc) {
        [vc addChildViewController:self.web];
    }
    [self addSubview:_web.view];
    [_web.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)setWebHeightBlock:(void (^)(CGFloat))webHeightBlock {
    __block typeof(self) weakself = self;
    _web.webHeightBlock = ^(CGFloat height) {
//        if (weakself.webHeight != height) {
        weakself.webHeight = height;
            NSLog(@"wap=======%f",height);
            if (!weakself.refreshHeight) {
                weakself.refreshHeight = YES;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    webHeightBlock(height);
                    weakself.refreshHeight = NO;
                });
            }
//        }
    };
}

- (void)updateCell:(NSString *)urlString isForceUpdate:(BOOL)isForceUpdate{
    if (![_web.url isEqualToString:urlString] || isForceUpdate) {
        _web.url = urlString;
        [_web reloadWeb];
    }
}

- (UIViewController *)parentController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
