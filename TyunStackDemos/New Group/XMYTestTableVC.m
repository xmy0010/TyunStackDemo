//
//  XMYTestTableVC.m
//  TyunStackDemos
//
//  Created by T_yun on 2019/5/13.
//  Copyright © 2019年 优谱德. All rights reserved.
//

#import "XMYTestTableVC.h"

@interface XMYTestTableVC ()
@property (weak, nonatomic) IBOutlet UIView *xmyTestHeader;
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation XMYTestTableVC

#pragma mark --- life circle

// 非storyBoard(xib或非xib)都走这个方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog(@"%@", self.xmyTestHeader);
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

// 如果连接了串联图storyBoard 走这个方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"%@", self.xmyTestHeader);
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

// xib 加载 完成
- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%@", self.xmyTestHeader);
}

// 加载视图(默认从nib)
//- (void)loadView {
//    NSLog(@"%s", __FUNCTION__);
////    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
////    self.view.backgroundColor = [UIColor redColor];
//}

//视图控制器中的视图加载完成，viewController自带的view加载完成
- (void)viewDidLoad {
    NSLog(@"%@", self.xmyTestHeader);
    [super viewDidLoad];
}


//视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@", self.xmyTestHeader);
    [super viewWillAppear:animated];
}

// view 即将布局其 Subviews
- (void)viewWillLayoutSubviews {
    NSLog(@"%@", self.xmyTestHeader);
    [super viewWillLayoutSubviews];
}

// view 已经布局其 Subviews
- (void)viewDidLayoutSubviews {
    NSLog(@"%@", self.xmyTestHeader);
    [super viewDidLayoutSubviews];
}

//视图已经出现
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%@", self.xmyTestHeader);
    [super viewDidAppear:animated];
}

//视图将要消失
- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"%@", self.xmyTestHeader);
    [super viewWillDisappear:animated];
}

//视图已经消失
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"%@", self.xmyTestHeader);
    [super viewDidDisappear:animated];
}

//出现内存警告  //模拟内存警告:点击模拟器->hardware-> Simulate Memory Warning
- (void)didReceiveMemoryWarning {
    NSLog(@"%@", self.xmyTestHeader);
    [super didReceiveMemoryWarning];
}

// 视图被销毁
- (void)dealloc {
    NSLog(@"%@", self.xmyTestHeader);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


@end
