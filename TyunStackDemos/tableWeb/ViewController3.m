//
//  ViewController3.m
//  TyunStackDemos
//
//  Created by zwzh_14 on 2021/11/26.
//  Copyright © 2021 优谱德. All rights reserved.
//

#import "ViewController3.h"
#import <WebKit/WebKit.h>

@interface ViewController3()<WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic,strong) WKWebView *web;
@end

@implementation ViewController3


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [WKUserContentController new];
    config.allowsInlineMediaPlayback = NO;
    config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
//    WKUserContentController *userContent = config.userContentController;
    
    WKUserContentController* userContentController = WKUserContentController.new;
//    WKUserScript * cookieScript = [[WKUserScript alloc]
//                                    initWithSource: cookieValue
//                                    injectionTime:WKUserScriptInjectionTimeAtDocumentStart
//                                    forMainFrameOnly:NO];
//    [userContentController addUserScript:cookieScript];
//    [userContentController addScriptMessageHandler:self name:@"loadComplete"];

    config.userContentController = userContentController;
    
    WKWebView *web = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    web.navigationDelegate = self;
    web.backgroundColor = [UIColor redColor];
    self.web = web;
    
//    web.scrollView.scrollEnabled = NO;
//    [web.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];

//    web.mediaPlaybackRequiresUserAction
    
//    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
      [self.view addSubview:web];
//      web.allowsInlineMediaPlayback = YES;
//      web.delegate = self;
//      self.web = web;
    
    NSString *jsPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"content.js"];
    NSString *js = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
//    NSString *js = @"";
//    NSString *strHtml = @"";
//
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"content.html"];
    NSString *strHtml = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path1 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"content1.html"];
    NSString *strHtml1 = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
    
    CGFloat fontSize = 17;
    
    NSString *contentStr= [NSString stringWithFormat:strHtml,
                           [NSString stringWithFormat:@"%f", fontSize],
                           [NSString stringWithFormat:@"%f", fontSize + 1],
                           [NSString stringWithFormat:@"%f", fontSize - 1],
                           js,
                           @"",//隐藏video标签，暂不调整content.html
                           strHtml1,
                           @"",
                           @""];
    NSString *webContentStr = contentStr;
    [web loadHTMLString:webContentStr baseURL:[NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]]];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://rmt.analytics.cditv.cn/rmt/jinniu/top?openNewWeb=1"]]];

}

- (void)setUrl:(NSString *)url {
    _url = url;
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)reloadWeb {
    [_web reload];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        UIScrollView *scoll = (UIScrollView *)object;
        CGFloat height = scoll.contentSize.height;
        NSLog(@"==========scroll==%f",scoll.contentSize.height);
//        self.web.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
        if (self.webHeightBlock) {
            [self loadHeight];
            self.webHeightBlock(height);
        }
    }
}

//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    NSLog(@"当前的name:%@, 当前的body:%@", message.name, message.body);
//    if ([message.name isEqualToString:@"loadComplete"]) {//试卷加载完成
//        NSDictionary *dic = message.body;
//        NSString *height = [dic objectForKey:@"height"];
//        NSLog(@"%@", height);
//    }
//}

#pragma mark WKNavigationDelegate
// 执行顺序1 (在发送请求之前，决定是否跳转)
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    decisionHandler(WKNavigationActionPolicyAllow);
}

// 执行顺序2 (页面开始加载)
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {}

// 执行顺序3 (收到服务器的响应头，决定是否调整)
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 执行顺序4 (开始获取到网页内容)
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {}

// 执行顺序5 (页面加载完成)
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id height, NSError * _Nullable error) {
//        NSLog(@"%@", height);
//    }];
//    NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self loadHeight];
//    });
}

// 执行顺序5（页面加载失败）
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {}


- ( void )loadHeight{
    CGFloat height = 0.0 ;
    [self.web sizeToFit];
    height = self.web.scrollView.contentSize.height ;
    CGRect webFrame = self.web.frame;
    webFrame.size.height = height;
//    webFrame.origin.y = 0;
    self.web.frame = webFrame;
    NSLog(@"==========load==%f",height);

}


@end
