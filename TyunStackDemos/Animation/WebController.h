//
//  WebController.h
//  UniversallyFramework
//
//  Created by liuf on 15/8/24.
//  Copyright (c) 2015年 liuf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ShareSuccessBlock)(void);

@interface WebController :UIViewController

// 本地传分享标题
@property (strong,nonatomic) NSString *titStr;
@property (strong,nonatomic) NSString *shareTitle;
// 本地传html内容
@property (strong,nonatomic) NSString *content;
//
@property (assign, nonatomic) BOOL isForChildController;
@property (assign, nonatomic) BOOL isForMainViewController;//是否来自于底部导航显示
@property (assign, nonatomic) BOOL isForMain;
@property (assign, nonatomic) BOOL isOneCell;//是否是一个cell

// 隐藏分享
@property (nonatomic, assign) BOOL isHideShare;

// url
@property (strong,nonatomic) NSString *url;

@property (copy,nonatomic) ShareSuccessBlock shareSuccessBlock;
- (void)reloadTableView;
- (void)reloadDataAagin;

@end
