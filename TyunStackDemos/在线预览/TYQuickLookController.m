//
//  TYQuickLookController.m
//  TyunStackDemos
//
//  Created by T_yun on 2017/12/20.
//  Copyright © 2017年 优谱德. All rights reserved.
//

#import "TYQuickLookController.h"
#import <QuickLook/QuickLook.h>
#import "TYCusQuickViewController.h"
#import <AFNetworking.h>

#define TY_Files @"TY_Files"

@interface TYQuickLookController ()<QLPreviewControllerDelegate, QLPreviewControllerDataSource>

@property(nonatomic, copy) NSURL *filePath;

@property(nonatomic, strong) UILabel *label;

@property(nonatomic, strong) NSMutableArray *files;

@end

@implementation TYQuickLookController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:TY_Files];
    if (arr.count == 0) {
        
        arr = @[];
    }
    self.files = arr.mutableCopy;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 100, 40)];
    [self.view addSubview:label];
    _label = label;
    label.backgroundColor = [UIColor blueColor];
    
    

    NSArray *urls = @[@"doc",
                      @"mp3",
                      @"jpg",
                      @"mp4"];
    for (int index = 0; index < urls.count; index++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 100 + (50 * index), 375, 40);
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:urls[index] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.tag = index;
        [btn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBtn:(UIButton *)sender{
    
    NSArray *urls = @[@"http://www.bobo023.xyz/file/a.doc",
                      @"http://192.168.0.187:8088/Frequency/20171213/7163a663-4621-4333-a5b1-ee08dbe71f57.mp3",
                      @"http://192.168.0.187:8088/Picture/News/20171218/753a9f5f-5e8b-4a64-b682-24aafb1c86f6.jpg",
                      @"http://192.168.0.187:8088/Video/20171219/de31d9a8-7099-4d85-b841-523673c6bce3.mp4"];
//
//    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.bobo023.xyz/file/a.doc"]]];
//    [self.view addSubview:web];
//    web.;
//
//
//
//    return;
    

    
    //构造资源链接
    
    NSString *urlString = urls[sender.tag];
    NSString *name0 = [urlString componentsSeparatedByString:@"/"].lastObject;
    NSString *name =[name0 componentsSeparatedByString:@"."].firstObject;
    
    NSString *type = [urlString componentsSeparatedByString:@"."].lastObject;

    if (name.length == 0) {
        
        name = urlString;
    }
    NSString *filename = [NSString stringWithFormat:@"%@.%@", name, type];
    if ([self.files containsObject:filename]) {

        //如果已下载
        NSURL *pathURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
        
        //文件后缀
        pathURL = [pathURL URLByAppendingPathComponent:filename];

        self.filePath = pathURL;
        TYCusQuickViewController *vc = [[TYCusQuickViewController alloc] init];
        vc.dataSource = self;
        [vc.navigationItem setRightBarButtonItem:nil];
        [self showViewController:vc sender:nil];

        return;
    }
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //创建AFN的manager对象
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    //构造URL对象
    NSURL *url = [NSURL URLWithString:urlString];
    //构造request对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //使用系统类创建downLoad Task对象
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"%@", downloadProgress);//下载进度
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            CGFloat persent = (CGFloat)downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
            NSString *persentStr = [NSString stringWithFormat:@"%.2f",persent];
            
            _label.text = persentStr;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //返回下载到哪里(返回值是一个路径)
        //拼接存放路径
        NSURL *pathURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
        
        //文件后缀
        pathURL = [pathURL URLByAppendingPathComponent:filename];
        
//        pathURL = [pathURL URLByAppendingPathComponent:[response suggestedFilename]];
       
        
        
        //下载文件存入
        [self.files addObject:filename];
        [[NSUserDefaults standardUserDefaults] setObject:self.files.copy forKey:TY_Files];
        return pathURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完成走这个block
        if (!error)
        {
            //如果请求没有错误(请求成功), 则打印地址
            NSLog(@"%@", filePath);
            
            self.filePath = filePath;
            TYCusQuickViewController *vc = [[TYCusQuickViewController alloc] init];
            vc.dataSource = self;
            [vc.navigationItem setRightBarButtonItem:nil];
            [self showViewController:vc sender:nil];
        } else{
            
            NSLog(@"下载失败");
        }
    }];
    //开始请求
    [task resume];
    

}


#pragma mark Datasource
-(NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    
    return 1;
}

-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    
    return self.filePath;
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
