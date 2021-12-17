//
//  ViewController3.h
//  TyunStackDemos
//
//  Created by zwzh_14 on 2021/11/26.
//  Copyright © 2021 优谱德. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewController3 : UIViewController

@property (copy,nonatomic) void(^webHeightBlock)(CGFloat height);


@property (nonatomic, copy) NSString *url;

- (void)reloadWeb;

@end

NS_ASSUME_NONNULL_END
