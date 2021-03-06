//
//  BaseWebViewController.h
//  ThePartyBuild
//
//  Created by Sakya on 17/4/24.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BaseWebViewController : UIViewController

@property (nonatomic, weak) WKWebView *webView;
/**
 详情URL id
 */
@property (nonatomic, copy) NSString *urlID;
/**
 新闻标题
 */
@property (nonatomic, copy) NSString *newsTitle;
//是否显示progressView
@property (nonatomic, assign) BOOL hideProgressView;
//进度条
@property (weak, nonatomic) UIProgressView *progressView;
//直接输入url
- (void)loadHtml5WebViewurlString:(NSString *)urlString;



@end
