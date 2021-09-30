//
//  WebController.m
//  UniversallyFramework
//
//  Created by liuf on 15/8/24.
//  Copyright (c) 2015年 liuf. All rights reserved.
//

#import "WebController.h"
#import <Masonry/Masonry.h>
#import <WebKit/WebKit.h>
@interface WebController ()<UIScrollViewDelegate,WKUIDelegate,WKNavigationDelegate> {
}

/// 与JS交互的桥接库
//@property WKWebViewJavascriptBridge *bridge;

@property (nonatomic, assign) BOOL isFromPush;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, assign) BOOL isRelation;
@property (nonatomic, assign) BOOL isGuess;
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) NSString *shareImageUrl;
@property (strong, nonatomic) NSString *shareDescription;
//@property (nonatomic, strong) ContentModel *contentModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *webBgView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation WebController
{
    BOOL _isShowMenu;
//    BaseNetService *_netService;
    UIView *errorView;
    BOOL _isNeedJumpNewWeb;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration * config =  [[WKWebViewConfiguration alloc]init];
    if (@available(iOS 10.0, *)) {
        config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAll;
        config.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
//        config.ignoresViewportScaleLimits = YES;
        config.allowsInlineMediaPlayback = YES;
    }
    
    config.userContentController = [WKUserContentController new];
        
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.webBgView.frame), CGRectGetHeight(self.webBgView.frame)) configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    if (!_isForChildController){
    }
    
    self.webView.scrollView.scrollEnabled = !_isOneCell;
    
    if(!_isOneCell){
    }
    [self loadData];
}




//#pragma mark loadData
- (void)reloadDataAagin
{
    [self loadData];
}

- (void)beginRefreshing{
    if (!_webView.isLoading) {
        [self loadData];
    }
}

- (void)loadData {
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
}


- (BOOL)urlPredicate: (NSString *)urlString{
    NSString *urlRegex = @"((http[s]{0,1})://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *urlPredicate  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlPredicate evaluateWithObject:urlString];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    // 清除cookies
}

@end
