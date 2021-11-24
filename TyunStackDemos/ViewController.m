//
//  ViewController.m
//  TyunStackDemos
//
//  Created by T_yun on 2016/11/8.
//  Copyright © 2016年 优谱德. All rights reserved.
//

#import "ViewController.h"

//typedef NS_OPTIONS(NSUInteger, MyEnum);

typedef enum : NSUInteger {
    MyEnumValueA = 1,
    MyEnumValueB = 3,
    MyEnumValueC,      //4
    MyEnumValueD = 2,
    MyEnumValueE,      //3 可能有相同数值的枚举值 此枚举 B和E相等
} MyEnum;

static NSString *const onlySelfClassUseString = @"xxxxx";

#import "BaseWebViewController.h"
#import "Person.h"
#import <PNChart.h>
#import <SDCycleScrollView.h>
//#import "MYAnimationView.h"
#import <WebKit/WebKit.h>
#import <FMDB.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "TYNetWorking.h"
#import <MJRefresh.h>

#import "NSString+TYExtension.h"
#import <Masonry.h>

#import "XMYSon.h"
#import "XMYTestTableVC.h"
#import "WebController.h"

#define VALUE(_INDEX_) [NSValue valueWithCGPoint:points[_INDEX_]]

NSString *const kMyConstString = @"kMyConstString";

@interface ViewController () <SDCycleScrollViewDelegate, CAAnimationDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, WKNavigationDelegate, WKUIDelegate,UITextFieldDelegate>

@property (nonatomic, strong) PNLineChart *lineChart;
@property (nonatomic, strong)PNLineChartData *data01;
@property (nonatomic, strong)PNLineChartData *data02;


@property (nonatomic, strong) UIBezierPath *bezierPath;

@property (nonatomic, strong) NSMutableArray *imagesArray;

//
@property (nonatomic, strong) UIImageView *frontImageView;

@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) NSMutableArray *m_btnEthinic;

@property (nonatomic, assign) NSInteger count;

//动画完成
@property (nonatomic, assign) BOOL finished;

//动画执行
@property (nonatomic, assign) BOOL executing;

@property (nonatomic, strong) dispatch_queue_t myQueue;

//@property (nonatomic, strong) MYAnimationView *animationView;

//布局
@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (weak, nonatomic) IBOutlet UIView *redView;

@property (nonatomic, strong) NSMutableArray *gameArr;


@property (nonatomic, copy) NSMutableString *propertyString;
@property (nonatomic, copy) NSMutableString *propertyString1;


@end

@implementation ViewController

NSInteger global_val = 1; // 全局变量
static NSInteger global_static_val = 1; // 静态全局变量

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)onBtnComplete:(id)sender {
    [self customLineChart];
}

- (IBAction)onBtn11:(UIButton *)sender {
    
//    for (int index = 0; index < 100; index++) {
//          [sender setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)self.gameArr.count] forState:UIControlStateNormal];
//          [self testGame];
//    }
    
//    [self testPredicate];
    
//        BaseWebViewController *vc = [[BaseWebViewController alloc] init];
//        [vc loadHtml5WebViewurlString:@"http://10.100.44.17:8020/stdk/entry.html?__hbt=1630481483075"];
//        vc.view.frame = CGRectMake(0, 50, 320, 300);
    
//    MyEnum enum1 = MyEnumValueC;
//    MyEnum enum2 = MyEnumValueE;
//    NSInteger number1 = 3;
////    NSLog(@"%d---%d",enum1,enum2);
//    if (number1 == MyEnumValueE) {
//        NSLog(@"1");
//    }
    
//    [self SystemDocumentTest];
//    for (int i = 0; i < 5; i++) {
//        [self testAboutStatic];
//    }
//    [self testAboutConst];
    

    
    //dic   number number number number date date
//    NSArray *ignoreArr = @[@"setValue:forKey:",@"_axRecursivelyPropertyListCoercedRepresentationWithError:",@"initWithCPLArchiver:",@"plistArchiveWithCPLArchiver:",@"CA_interpolateValues:::interpolator:",@"decimalValue",@"cppData",@"initWithCPPData:copy:"];
//
////    @"decimalValue" @"setValue:forKey:"
//        NSDictionary *dic = @{@"key1":@"value1",@"key2":[NSNull new],@"key3":@""};
//        NSLog(@"%@",dic);
//        NSMutableDictionary *nilValue = dic[@"key2"];
////        [nilValue setValue:@"" forKey:@""];   //不可调用此方法
//
//
//    NSNumber *nullNum = [[NSNull alloc] init];
//    [nullNum decimalValue];                   //不可调用此方法
    

    
    
//
    NSDictionary *dic = @{@"key1":@"value1",@"key2":[NSNull new],@"key3":@""};
    NSLog(@"%@",dic);
    NSDictionary *nilValue = dic[@"key2"];

//    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithDictionary:nilValue];
    

    //判断
    NSArray *classArr = @[
        [NSMutableArray class],
        [NSMutableDictionary class],
        [NSMutableString class],
        [NSNumber class],
        [NSDate class],
        [NSData class]];

    for (Class class in classArr) {
        [self callAllMethods:class target:nilValue];
    }
    
    
//    nil
}


- (void)callAllMethods:(Class)class target:(id)obj{
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(class, &methodCount);
    NSMutableArray *methodArray = [NSMutableArray arrayWithCapacity:methodCount];
    NSLog(@"%@------------------------------------------",NSStringFromClass(class));
    for (int i = 0; i < methodCount; i++) {
        Method temp = methodList[i];
        SEL name_F = method_getName(temp);
        
        NSString *methodName = NSStringFromSelector(name_F);
        NSArray *ignoreArr = @[@"setValue:forKey:",@"_axRecursivelyPropertyListCoercedRepresentationWithError:",@"initWithCPLArchiver:",@"plistArchiveWithCPLArchiver:",@"CA_interpolateValues:::interpolator:",@"decimalValue",@"cppData",@"initWithCPPData:copy:"];
        
        BOOL skip = NO;
        for (NSString *ignoreName in ignoreArr) {
            if ([methodName isEqualToString:ignoreName]) {
                skip = YES;
                break;;
            }
        }
        if (skip) {
            continue;
        }
        
        //调用方法
        NSMethodSignature *signature = [class instanceMethodSignatureForSelector:name_F];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = obj;
        invocation.selector = name_F;
        [invocation invoke];
        
        const char *name_s = sel_getName(name_F);
        int arguments = method_getNumberOfArguments(temp);
        const char * encoding = method_getTypeEncoding(temp);
        NSLog(@"%@,",[NSString stringWithUTF8String:name_s]);
//  NSLog(@"MethodName: %@,ArgumentCount: %d,EncodingStyle: %@",[NSString stringWithUTF8String:name_s],arguments,[NSString stringWithUTF8String:encoding]);
//        [methodArray addObject:[NSString stringWithUTF8String:name_s]];
//        [methodArray addObject:temp];
    }
    free(methodList);
    
//    return methodArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    NSArray *arr = [NSArray arrayWithObjects:@1,@3,nil,@4, nil];
//    NSLog(@"%@",arr);
//    NSArray *arr1 = @[@1,@3,nil,@4];
    
//    [self blockAndGlobalStaticValue];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.gameArr = @[].mutableCopy;
//    [self testGame];
//    _greenView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self testMasonry];
    
//    //__block修饰符
//    [self _blockTest];
//
//    //子类和父类
//    XMYSon *son = [[XMYSon alloc] init];
//
//
//    //分类添加属性
//    NSString *str = @"";
//    str.pro = @"1";
    
    //百度鹰眼轨迹
//    [self testYY];
    
    
//    BaseWebViewController *vc = [[BaseWebViewController alloc] init];
//    [vc loadHtml5WebViewurlString:@"http://www.baidu.com"];
////////    UINavigationController *navi = []
//    [self presentViewController:vc animated:YES completion:nil];
    //获取当前时间戳
//    NSDate *senddate = [NSDate date];
//    
//    NSLog(@"date1时间戳 = %ld",time(NULL));
//    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970] * 1000];
//    NSLog(@"date2时间戳 = %@",date2);
    
//    https://v.qq.com/x/page/v0348dt855s.html
//    http://tv.sohu.com/20131225/n392354303.shtml
//                           http://jx.api.163ren.com/vod.php?url=https://v.qq.com/x/cover/47xswolfi4iamlx.html
//    [self watchTVWithUrl:@"https://v.qq.com/x/cover/rjae621myqca41h/b0033kl134e.html"];
    
    
//    [self customLineChart];

    //排序数组里对象的生日属性(NSDate)
//    [self sortArrayWithBirthday];
    
//    //随机数
//    for (int index = 0; index < 100; index++) {
//        
//        NSLog(@"%d", arc4random() % 4);
//    }
    
    
    //轮播图
//    [self customSDCycleScrollView];
    
    //打印系统字体
//    [self logFontFamily];
    
    //动画
//    [self customAnimation];
    
//    NSArray *points = [self points];
    
    //button点击状态改变
//    [self changeButtonBorder];
    
    //FMDB
//    [self learnFMDB];
    
    //SEO相关
//    [self aboutSEO];
    
    //GCD多异步线程运行
//    [self aboutGCDGroups];
    
    //UIImagePickerController
    //选择本地视频
//    [self selectedLocalVedios];
    
    //密钥请求
//    [self getSessionKey];
    
    //
//    [self testSet];
    
//    [self MJRefresh];
    [self testSetterAndGetter];
}

#pragma mark setter和getter方法与直接访问实例变量
- (void)testSetterAndGetter {
    
    NSMutableString *string = @"1234".mutableCopy;
    self.propertyString = @"123".mutableCopy;
    self.propertyString1 = @"123".mutableCopy;

    NSLog(@"%@------%@",_propertyString,_propertyString1);
    
    _propertyString = string;
    self.propertyString1 = string;
    NSLog(@"%@------%@",_propertyString,_propertyString1);

    [string appendString:@"567"];
    NSLog(@"%@------%@",_propertyString,_propertyString1);

}

#pragma mark static const extern 相关
- (void)testAboutStatic {
    //1.局部变量a是在test方法的代码块内声明的，所以它的生命周期就是这个代码块，当我们调用完一次test方法后，局部变量a就被销毁了，不存在了。在下一次调用test方法时又在栈区重新申请内存。
    //    int a = 0;  //循环调用方法打印结果不变 1  1  1  1  1
    
    //2.当我们用static修饰局部变量时，变量被称为静态局部变量，这个静态局部变量和全局变量，静态全局变量一样，是存储在静态存储区。**由于存储在静态存储区，所以这块内存直到程序结束才会销毁。也就是说，静态局部变量的生命周期是整个源程序。但是它只在声明它的代码块可见，也就是说它的作用域是声明它的代码块
//    static int a = 0; //循环调用方法打印结果改变 1  2  3  4  5
//    a++;
//    NSLog(@"%d",a);
    
    //3.当全局变量没有使用static修饰符时，其存储在静态存储区，直到程序结束才销毁。也就是其作用域是整个源程序。我们可以使用extern关键字来引用这个全局变量。
//    extern int globalA;
//    NSLog(@"%d",globalA); //报错 需导入GlobalValue头文件才可用
    
    extern int globalB;
    NSLog(@"%d",globalB);
//    static修饰局部变量：将局部变量的本来分配在栈区改为分配在静态存储区，也就改变了局部变量的生命周期。
//    static修饰全局变量：本来是在整个源程序的所有文件都可见，static修饰后，改为只在申明自己的文件可见，即修改了作用域。
}

- (void)testAboutConst {
    //1.
    //在栈区分配一块内存，这块内存区域名字叫a,里面存放着int类型数据10
    int a = 10;
    //声明一个指针指向名称为a的这块内存区域
    int *p = &a;
    //将名称为a的这块内存区域的值改为20
    *p = 20;
    NSLog(@"%d",a);  //结果为20
    
    //2.
    //需要注意的一点是，const修饰的是其右边的值，也就是const右边的这个整体的值不能改变。
    const int b = 10;
    *p = &b;
    *p = 30;
    NSLog(@"%d",b); //结果为10
    
    //3.
    //这里str是指针，*str就是指针指向的内存里面的值，const修饰 *str,也即是指针指向的内存里面的值不能变，但是str这个指针是可以变的，即可以指向其他地方
    NSString const *str = @"test";
    str = @"haha";
    
    //这里str是指针，*str就是指针指向的内存里面的值，const修饰str,也即是指针指向的内存里面的地址不能变
//    NSString * const str1 = @"test1";
//    str1 = "haha1"; //Cannot assign to variable 'str1' with const-qualified type 'NSString *const __strong'
//
    //一般联合使用static和const来定义一个只能在本文件中使用的，不能修改的变量：


}

#pragma mark 系统文档一些测试
- (void)SystemDocumentTest {
    
    NSArray *names = UIFont.familyNames;
    NSLog(@"%@",names);
    
    UILabel *label = UILabel.new;
}

#pragma mark blcok - 访问静态全局变量
- (void)blockAndGlobalStaticValue {
    
    static NSInteger static_val = 1; // 静态局部变量
        __block  NSInteger auto_val = 1; // 局部变量
            
            NSLog(@"0: %ld - %ld - %ld - %ld ~ %p - %p - %p - %p", global_val, global_static_val, static_val, auto_val, &global_val, &global_static_val, &static_val, &auto_val);
            
            // 定义block
            void (^myBlock)(void) = ^{
                global_val ++;
                global_static_val ++;
                static_val ++;
                auto_val ++;
                
                NSLog(@"1: %ld - %ld - %ld - %ld ~ %p - %p - %p - %p", global_val, global_static_val, static_val, auto_val, &global_val, &global_static_val, &static_val, &auto_val);
            };
            
            global_val ++;
            global_static_val ++;
            static_val ++;
            auto_val ++;

            NSLog(@"2: %ld - %ld - %ld - %ld ~ %p - %p - %p - %p", global_val, global_static_val, static_val, auto_val, &global_val, &global_static_val, &static_val, &auto_val);
            
            // 调用block
            myBlock();
            
            NSLog(@"3: %ld - %ld - %ld - %ld ~ %p - %p - %p - %p", global_val, global_static_val, static_val, auto_val, &global_val, &global_static_val, &static_val, &auto_val);
}

#pragma mark 本地模糊搜索
- (void)testPredicate {
    //1.生成数据
    NSMutableArray *data = @[].mutableCopy;
    for (int index = 0; index < 50; index++) {
        Person *person = [[Person alloc] init];
        person.name = [[NSString alloc] initWithFormat:@"%i",index];
        [data addObject:person];
    }
    
    //2.筛选数据
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS '1'"];
    NSArray *arr = [data filteredArrayUsingPredicate:predicate1];
    for (Person *item in arr) {
        NSLog(@"%@",item.name);
    }
}

#pragma mark 模拟炉子


#pragma mark 模拟装备25上30
- (void)testGame{
    
    int number = 26;
    int result = 30;
    int times = 0;
    
    while (number < result) {
        times += 1;
        int random = arc4random() % 100 + 1; //[1 - 100]
        if (random <= 30) {
            //百分之三十几率 成功
            number += 1;
            NSLog(@"强化成功,当前加成%d",number);
        } else {
            //失败
            if (number == 26){
                NSLog(@"强化失败,加成不变");
            } else if (number == 27) {
                number -= 1;
                NSLog(@"强化失败,当前加成%d",number);
            } else {
                number -= 2;
                NSLog(@"强化失败,当前加成%d",number);
            }
        }
    }
    
    [self.gameArr addObject:@(times * 5)];
    NSLog(@"强化成功，共花费魔魂%d",times * 5);
}

#pragma mark __block修饰符
- (void)_blockTest{
    
//    __block int a = 0;
//    NSLog(@"定义前：%p", &a);         //栈区
//    void (^foo)(void) = ^{
//        a = 1;
//        NSLog(@"block内部：%p", &a);    //堆区
//    };
//    NSLog(@"定义后：%p", &a);         //堆区
//    foo();
    
     NSMutableString *b = [NSMutableString stringWithString:@"Tom"];
    NSLog(@"\n 定以前：------------------------------------\n\
          a指向的堆中地址：%p；a在栈中的指针地址：%p", b, &b);               //a在栈区
    void (^foo1)(void) = ^{
        b.string = @"Jerry";
        NSLog(@"\n block内部：------------------------------------\n\
              a指向的堆中地址：%p；a在栈中的指针地址：%p", b, &b);               //a在栈区
//        b = [NSMutableString stringWithString:@"William"];
    };
    foo1();
    NSLog(@"\n 定以后：------------------------------------\n\
          a指向的堆中地址：%p；a在栈中的指针地址：%p", b, &b);
}

#pragma mark Masonry
- (void)testMasonry{
    
    [_greenView mas_updateConstraints:^(MASConstraintMaker *make) {

        make.height.mas_equalTo(40);
    }];
//    [_greenView mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.view).offset(152);
//        make.centerX.equalTo(self.view);
//        make.width.mas_equalTo(240);
//        make.height.mas_equalTo(70);
//        }];
//    [_greenView updateConstraints];
}
- (IBAction)onMasonry:(id)sender {
    
//    [self testMasonry];
//    if ([self.lineChart.chartData isEqualToArray:@[_data01]]) {
//        [self.lineChart updateChartData:@[_data02]];
//    } else {
//        [self.lineChart updateChartData:@[_data01]];
//    }
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    XMYTestTableVC *vc = [sb instantiateViewControllerWithIdentifier:@"XMYTestTableVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 测试鹰眼
//-(void)testYY{
//
//    BTKStartServiceOption *op = [[BTKStartServiceOption alloc] initWithEntityName:@"entityA"];
//    //        // 初始化地图SDK
//    //        BMKMapManager *mapManager = [[BMKMapManager alloc] init];
//    //        [mapManager start:AK generalDelegate:self];
//    // 开启服务
//    // 设置开启轨迹服务时的服务选项，指定本次服务以“entityA”的名义开启
//    
//    
//    //开始采集
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        [[BTKAction sharedInstance] startService:op delegate:self];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            //开始采集
//            [[BTKAction sharedInstance] startGather:self];
//        });
//
//    });
//}
//
////服务开启
//- (void)onStartService:(BTKServiceErrorCode)error{
//
//    // 维护状态标志
//    if (error == BTK_START_SERVICE_SUCCESS || error == BTK_START_SERVICE_SUCCESS_BUT_OFFLINE) {
//        NSLog(@"轨迹服务开启成功");
//    } else {
//        NSLog(@"轨迹服务开启失败");
//    }
//}
//
////采集回调
//- (void)onStartGather:(BTKGatherErrorCode)error{
//    
//    if (error == BTK_START_GATHER_SUCCESS) {
//        NSLog(@"开始采集成功");
//    } else {
//        NSLog(@"开始采集失败");
//    }
//}
//
////自定义字段上传
//-(NSDictionary *)onGetCustomData {
//    NSMutableDictionary *customData = [NSMutableDictionary dictionaryWithCapacity:3];
//    NSArray *intPoll = @[@5000, @7000, @9000];
//    NSArray *doublePoll = @[@3.5, @4.6, @5.7];
//    NSArray *stringPoll = @[@"aaa", @"bbb", @"ccc"];
//    int randomNum = arc4random() % 3;
//    // intTest doubleTest stringTest这3个自定义字段需要在轨迹管理台提前设置才有效
//    customData[@"intTest"] = intPoll[randomNum];
//    customData[@"doubleTest"] = doublePoll[randomNum];
//    customData[@"stringTest"] = stringPoll[randomNum];
//    return [NSDictionary dictionaryWithDictionary:customData];
//}

////消息推送回调
//-(void)onGetPushMessage:(BTKPushMessage *)message {
//    NSLog(@"收到推送消息，消息类型: %@", @(message.type));
//    if (message.type == 0x03) {
//        BTKPushMessageFenceAlarmContent *content = (BTKPushMessageFenceAlarmContent *)message.content;
//        if (content.actionType == BTK_FENCE_MONITORED_OBJECT_ACTION_TYPE_ENTER) {
//            NSLog(@"被监控对象 %@ 进入 服务端地理围栏 %@ ", content.monitoredObject, content.fenceName);
//        } else if (content.actionType == BTK_FENCE_MONITORED_OBJECT_ACTION_TYPE_EXIT) {
//            NSLog(@"被监控对象 %@ 离开 服务端地理围栏 %@ ", content.monitoredObject, content.fenceName);
//        }
//    } else if (message.type == 0x04) {
//        BTKPushMessageFenceAlarmContent *content = (BTKPushMessageFenceAlarmContent *)message.content;
//        if (content.actionType == BTK_FENCE_MONITORED_OBJECT_ACTION_TYPE_ENTER) {
//            NSLog(@"被监控对象 %@ 进入 客户端地理围栏 %@ ", content.monitoredObject, content.fenceName);
//        } else if (content.actionType == BTK_FENCE_MONITORED_OBJECT_ACTION_TYPE_EXIT) {
//            NSLog(@"被监控对象 %@ 离开 客户端地理围栏 %@ ", content.monitoredObject, content.fenceName);
//        }
//    }
//}

#pragma mark 下拉刷新 上拉加载
-(void)MJRefresh{

    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds];
    table.dataSource = self;
    table.delegate = self;
    table.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:table];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        sleep(3);
        [table.mj_header endRefreshing];
    }];
    table.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        sleep(3);
        [table.mj_footer endRefreshing];
    }];
    table.mj_footer = footer;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"标题xxx";
    return cell;
}

#pragma mark 考试题测试
-(void)testSet {

    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"a value" forKey:@"aKey"];
    NSLog(@"%@",[dict objectForKey:@"aKey"]);
}

#pragma mark 密钥请求
- (void)getSessionKey {

    [TYNetWorking gainSessionKeyWithType:@"0" successBlock:^(id result) {
       
        NSLog(@"%@", result);
    } failureBlock:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];
}

#pragma mark 图片选择器 选相册里面的视频
- (void)selectedLocalVedios {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(presentPicker) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}

- (void)presentPicker {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeVideo, nil];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark GCD多异步线程
- (void)aboutGCDGroups {    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"group one start");
    
    //第一个任务
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
       dispatch_async(queue, ^{
          
           sleep(1);
           NSLog(@"queue one finished");
           dispatch_group_leave(group);
       });
    });
    
    //第二个任务
    dispatch_group_enter(group); //每次添加任务之前调用此方法
    dispatch_group_async(group, queue, ^{
       
        dispatch_async(queue, ^{
           
            sleep(2);
            NSLog(@"queue two finished");
            dispatch_group_leave(group);
        });
    });
    
    
    dispatch_group_notify(group, queue, ^{
       
        NSLog(@"group finished");
    });
}

#pragma mark about Seo
- (void)aboutSEO {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.com/apps/菩提佛学院"]];

//    NSString *str = [NSString stringWithFormat:
//                     
//                     @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",
//                     m_myAppID ];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

#pragma mark FMDB学习
- (void)learnFMDB {

//    NSString *path = @"/Users/t_yun/Desktop/Tyun.sqlite";
////    NSString *path = [[NSBundle mainBundle] pathForResource:@"db_fo_dic" ofType:@"sqlite"];
//    //1.通过具体路径创建数据库（如果存在则打开）
//    FMDatabase *db = [FMDatabase databaseWithPath:path];
//    
//    //打开数据库 创建表
//    if ([db open]) {
//        NSLog(@"打开成功");
//        
//        BOOL success = [db executeUpdate:@"create table if not exists t_student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TXTE NOT NULL, age INTEGER DEFAULT 1)"];
//        if (success) {
//            
//            NSLog(@"创建表成功");
//        } else {
//        
//            NSLog(@"创建表失败");
//        }
//    } else {
//    
//        NSLog(@"打开失败");
//    }
    
    /************增删改查*************/
//    //1.插入数据
//    static NSInteger age = 10;
//    while (age < 30) {
//        
//        age++;
//        BOOL InsertSuccess = [db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?,?);",@"JACK",@(age)];
//        if (InsertSuccess) {
//            
//            NSLog(@"插入数据 JACK %ld", age);
//        } else {
//            
//            NSLog(@"插入失败");
//        }
//    }

    
//    //2.删除数据
//    BOOL deleteSuccess = [db executeUpdate:@"DELETE FROM t_student WHERE age > 20 AND age < 25"];
//    if (deleteSuccess) {
//        
//        NSLog(@"删除成功");
//    } else {
//    
//        NSLog(@"增加成功");
//    }
    
//    //3.修改数据
//    BOOL changeSuccess = [db executeUpdate:@"UPDATE t_student SET name = 'Mark' WHERE id > 3 AND id < 10"];
//    if (changeSuccess) {
//        
//        NSLog(@"修改成功");
//    } else {
//    
//        NSLog(@"修改失败");
//    }
    
//    //4.查询数据
//    FMResultSet *result = [db executeQuery:@"SELECT id, name, age FROM t_student WHERE age > 25;"];
//    while ([result next]) {
//        
//        int ID = [result intForColumnIndex:0];
//        NSString *name = [result stringForColumnIndex:1];
//        int age = [result intForColumn:@"age"];
//        
//        NSLog(@"ID:%d, name:%@, age:%d", ID, name, age);
//    }
    
    /*************FMDatabaseQueue数据库队列基本使用******************/
    NSString *path = @"/Users/t_yun/Desktop/TyunQueue.sqlite";

    // 1.创建一个FMDatabaseQueue对象
    // 只要创建数据库队列对象, FMDB内部就会自动给我们加载数据库对象
    FMDatabaseQueue *dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    //2.执行操作
    // 会通过block传递队列中创建好的数据库
    [dbQueue inDatabase:^(FMDatabase *db) {
       
        BOOL success = [db executeUpdate:@"Create table if not exists t_student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER DEFAULT 1);"];
        if (success) {
            
            NSLog(@"创建表成功");
        } else {
        
            NSLog(@"创建表失败");
        }
    }];
    
    //增删改查一样 但是线程安全
//    [dbQueue inDatabase:^(FMDatabase *db) {
//       
//        
//    }];
    
    
}

#pragma mark 自定义动画
- (void)customAnimation {
    
//    CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
//
//    UILabel *laebl = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 80)];
//    laebl.text = [NSString stringWithFormat:@"%ld", self.count];
//    laebl.font = [UIFont systemFontOfSize:60];
//    laebl.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:laebl];
//
//    MYAnimationView *myAnimationView = [[MYAnimationView alloc] initWithOriginY:300 imageWidth:40];
//    [myAnimationView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.1]];
////    myAnimationView.animationDuration = 1;
//    [self.view addSubview:myAnimationView];
//    [myAnimationView drawView];
//
//    myAnimationView.countBlock = ^(BOOL isAdd){
//        if (isAdd) {
//
//            ++self.count;
//        } else {
//
//            --self.count;
//            if (self.count < 0) {
//
//                self.count = 0;
//            }
//        }
//
//        laebl.text = [NSString stringWithFormat:@"%ld", self.count];
//    };
//    //封装到MYAnimationView类中
//    return;
//    CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat imageWidth = 40.;
//    
//    UIView *animationView = [[UIView alloc]initWithFrame:self.view.bounds];
//    CGRect rect = animationView.frame;
//    rect.origin.x -= imageWidth;
////    rect.size.width += imageWidth;
//    animationView.frame = rect;
//    [self.view addSubview:animationView];
//    //算法
//    //贝塞尔公式
////    CGFloat kScale = (kScreenWidth / 320);
//    CGPoint point0 = CGPointMake(0, 300);
//    CGPoint point1 = CGPointMake(kScreenWidth / 2 - 10, 200);
//    CGPoint point2 = CGPointMake(kScreenWidth + imageWidth, 200);
//    //iOS坐标系与平面直角坐标系Y轴相反  取point0为平面直角坐标系原点重新构造
//    CGPoint rcsPoint0 = CGPointMake(0, 0); //Rectangular coordinate system
//    CGPoint rcsPoint1 = CGPointMake(point1.x, point0.y - point1.y);
//    CGPoint rcsPoint2 = CGPointMake(point2.x, point0.y - point2.y);
//    //二次贝塞尔
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    self.bezierPath = path;
//    [path moveToPoint:point0];
//    [path addQuadCurveToPoint:point2 controlPoint:point1];
//    
//    
//    CAShapeLayer *pathLayer = [CAShapeLayer layer];
//    pathLayer.position = CGPointMake(0, 0);
//    pathLayer.lineWidth = 2;
//    pathLayer.strokeColor = [UIColor greenColor].CGColor;
//    pathLayer.fillColor = nil;
//    pathLayer.path = path.CGPath;
//    [animationView.layer addSublayer:pathLayer];
//    
//    //曲线裁剪
////    [path addClip];
//    
//
//    //减去圆角
//    UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, point0.y - imageWidth / 2, imageWidth, imageWidth)];
//    CGFloat offsetY = [self getYWithX:imageWidth / 2 point0:rcsPoint0 point1:rcsPoint1 point2:rcsPoint2];
//    firstImage.center = CGPointMake(imageWidth / 2, point0.y - offsetY);
//
//    
//    //添加前五个圆 一个隐藏在最前面
//    self.imagesArray = @[].mutableCopy;
//    for (CGFloat i = 0; i < 5; i++) {
//        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageWidth * i, point0.y - offsetY, imageWidth, imageWidth)];
//        //x相邻算上高度差 缝隙太大
////        CGFloat centerX = imageWidth * i + imageWidth / 2;
//        CGFloat centerX = (imageWidth ) * i + imageWidth / 2;
//        CGFloat offsetY = [self getYWithX:centerX point0:rcsPoint0 point1:rcsPoint1 point2:rcsPoint2];
//        imageView1.center = CGPointMake(centerX, point0.y - offsetY);
//        imageView1.contentMode = UIViewContentModeScaleAspectFill;
//        imageView1.layer.cornerRadius = 20;
//        imageView1.layer.masksToBounds = YES;
//        imageView1.image = [UIImage imageNamed:@"1"];
//        [animationView addSubview:imageView1];
//        self.frontImageView = imageView1; //将最后一个赋值持有
//        [self.imagesArray addObject:imageView1];
//    }
//    //添加后面四个圆
//    UIImageView *lastView = [[UIImageView alloc] initWithFrame:CGRectMake(point2.x, point2.y - imageWidth / 2, imageWidth, imageWidth)];
//    CGFloat lastOffsetY = [self getYWithX:point2.x + imageWidth / 2 point0:point0 point1:point1 point2:point2];
//    lastView.center = CGPointMake(point2.x - imageWidth / 2,point0.y - lastOffsetY);
//    for (int i = 0; i < 4; i++) {
//        
//        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(point2.x, point2.y - imageWidth / 2, imageWidth, imageWidth)];
//        CGFloat centerX = point2.x + (imageWidth / 2) - i * imageWidth;
//        if (i != 0) {
//            
//            CGFloat offsetY = [self getYWithX:centerX point0:rcsPoint0 point1:rcsPoint1 point2:rcsPoint2];
//            image.center = CGPointMake(centerX, point0.y - offsetY);
//        }
//        image.contentMode = UIViewContentModeScaleAspectFill;
//        image.layer.cornerRadius = 20;
//        image.layer.masksToBounds = YES;
//        image.image = [UIImage imageNamed:@"1"];
//        [animationView addSubview:image];
//        self.backImageView = image;
//        [self.imagesArray insertObject:image atIndex:5];//四只按X大小顺序
//    }
////    //添加最后一只相当于屏幕外面
////    lastView
//    
////    //创建一个串行队列
//    dispatch_queue_t queue = dispatch_queue_create("my.animation.testQueue", DISPATCH_QUEUE_SERIAL);
//    self.myQueue = queue;
//    
//    //添加点击事件
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
//    [self.view addGestureRecognizer:tap];
//    
//    
//    //添加滑动事件
//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeScreen)];
//    swipe.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.view addGestureRecognizer:swipe];
}

//算出曲线上x坐标对应的Y
- (CGFloat)getYWithX:(CGFloat)X point0:(CGPoint)point0 point1:(CGPoint)point1 point2:(CGPoint)point2 {

    //B(t) = (1-t^2)*P0 + 2t(1-t)*P1 + t^2*P2
    //Bx = t^2(P2x - P0x - 2P1x) + 2tP1x + P0x
    //解二元一次方程
    CGFloat a, b, c, delt, x1 , x2, t, resultY;
    a = point2.x - point0.x - 2*point1.x; //二次系数
    b = 2 * point1.x; //一次系数
    c = point0.x - X; //0次系数
    
    //当二次系数为0的时候
    if (a == 0) {
        
        t = (X - point0.x) / (2 * point1.x);
        resultY = 2 * t * point1.y + point0.x;
        
        return resultY;
    } else {
    
        delt = b * b - 4 * a * c;
        x1 = (-b + sqrt(delt)) / (2 * a);
        x2 = (-b - sqrt(delt)) / (2 * a);
        
        t = x1 > 0 && x1 < 1 ? x1 : x2; //根的取值范围应在【0，1】
        resultY = (t * t) * (point2.y - point0.y - 2 * point1.y) + 2 * t * point1.y + point0.y;
    
        return resultY;
    }
    
}


////点击屏幕
//- (void)tapScreen {
//    
//        AnimOperationManager *manager = [AnimOperationManager sharedManager];
//        [manager animWithAnimationView:self finishedBlock:^(BOOL result) {
//    
//    //        NSLog(@"Animation回调");
//        }];
//}
//
//- (void)swipeScreen {
//
//    AnimOperationManager *manager = [AnimOperationManager sharedManager];
//    [manager animWithAnimationView:self finishedBlock:^(BOOL result) {
//        
//    }];
//    
//}
//
//- (void)animateWithCompleteBlock:(completeBlock)completed {
//    
//    [self addAnimations];
//    self.completeBlock = completed;
//    
//}

- (void)addAnimations {

    for (int index = 0; index < self.imagesArray.count - 1; index++) {
        
        UIImageView *frontImage = self.imagesArray[index];
        UIImageView *backImage = self.imagesArray[index + 1];
        CGPoint point0 = frontImage.center;
        CGPoint point2 = backImage.center;
        CGPoint point1 = CGPointMake((point2.x - point0.x) / 2 - 5 + point0.x, point2.y);
//        NSLog(@"从%f到%f", point0.x, point2.x);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:point0];
        [path addQuadCurveToPoint:point2 controlPoint:point1];
        
        //关键帧动画
        CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnim.path = path.CGPath;
        moveAnim.duration = 0.2;
        //    moveAnim.calculationMode = kCAAnimationCubic;
        moveAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        moveAnim.delegate = self;
        moveAnim.fillMode = kCAFillModeForwards;
        moveAnim.removedOnCompletion = YES;
        [frontImage.layer addAnimation:moveAnim forKey:nil];
        moveAnim.delegate = self;
    }

    
}

//CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {

}

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//
//    NSLog(@"%ld", ++self.count);
//    //有8次动画完成回调
//    if (self.count % 8 == 0) {
//        
//        self.count = 0;
//        if (self.completeBlock) {
//            
//            self.completeBlock(YES);
//        }
//    }
//}

void getPointsFromBezier(void *info,const CGPathElement *element){
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPathElementType type = element->type;
    CGPoint *points = element->points;
    
    if (type != kCGPathElementCloseSubpath) {
        [bezierPoints addObject:VALUE(0)];
        if ((type != kCGPathElementAddLineToPoint) && (type != kCGPathElementMoveToPoint)) {
            [bezierPoints addObject:VALUE(1)];
        }
    }
    
    if (type == kCGPathElementAddCurveToPoint) {
        [bezierPoints addObject:VALUE(2)];
    }
    
}

- (NSArray *)points
{
    NSMutableArray *points = [NSMutableArray array];
    CGPathApply(self.bezierPath.CGPath, (__bridge void *)points, getPointsFromBezier);
    
    return points;
    
}

#pragma mark button点击状态改变
- (void)changeButtonBorder {

    NSMutableArray *m_btnEthinic = @[].mutableCopy;
    for (int i = 0; i < 8; i++) {
        
        UIButton *btnEthnicity = [UIButton buttonWithType:UIButtonTypeSystem];
        [btnEthnicity setTitle:[NSString stringWithFormat:@"btn%d", i] forState:UIControlStateNormal];
        btnEthnicity.frame = CGRectMake(50, 50 + 40 * i, 50, 20);
        btnEthnicity.backgroundColor = [UIColor redColor];
        [btnEthnicity addTarget:self action:@selector(btnEthnicityTouchDown:) forControlEvents: UIControlEventTouchDown];
        [btnEthnicity addTarget:self action:@selector(btnEthnicityTouchUp:) forControlEvents: UIControlEventTouchUpInside];
        [self.view addSubview:btnEthnicity];
        [m_btnEthinic addObject:btnEthnicity];
    }
}

- (void)btnEthnicityTouchDown:(UIButton *)sender {

    NSLog(@"down");
    sender.layer.borderWidth = 2;
    sender.layer.borderColor = [UIColor greenColor].CGColor;
}

- (void)btnEthnicityTouchUp:(UIButton *)sender {

    NSLog(@"up");
    sender.layer.borderWidth = 0;
}



#pragma mark 打印系统字体
- (void)logFontFamily {

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 400, 50)];
    label.text = @"菩提佛学词典";
    label.font = [UIFont fontWithName:@"GillSans-SemiBold" size:40];
    [self.view addSubview:label];
    
    int i = 0;
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------%d",i++);
    }
}

#pragma mark 轮播图
- (void)customSDCycleScrollView {

    //网络加载图片
//    SDCycleScrollView *cycleScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) delegate:self placeholderImage:[UIImage imageNamed:@"1"]];
//    cycleScroll.imageURLStringsGroup = @[
//                                         @"http://fojiao2-10042480.file.myqcloud.com/data/upload/20160801/579e9ba566fe0.jpg",
//                                         @"http://fojiao2-10042480.file.myqcloud.com/data/upload/20160801/579e9b8a225b5.jpg",
//                                         @"http://fojiao2-10042480.file.myqcloud.com/data/upload/20160801/579e9b6fb29f0.jpg"];
 
//    cycleScroll.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    SDCycleScrollView *cycleScrollView4 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 750, [UIScreen mainScreen].bounds.size.width, 40) delegate:self placeholderImage:nil];
    cycleScrollView4.scrollDirection = UICollectionViewScrollDirectionVertical;
    cycleScrollView4.onlyDisplayText = YES;
    
    NSMutableArray *titlesArray = [NSMutableArray new];
    [titlesArray addObject:@"纯文字上下滚动轮播"];
    [titlesArray addObject:@"纯文字上下滚动轮播 -- demo轮播图4"];
//    [titlesArray addObjectsFromArray:titles];
    cycleScrollView4.titlesGroup = [titlesArray copy];
    
    [self.view addSubview:cycleScrollView4];
}

- (void)customLineChart {

    //    PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200)];
    //    [self.view addSubview:lineChart];
    //    [lineChart setXLabels:@[@"10月1日",
    //                            @"2日",
    //                            @"3日",
    //                            @"4日",
    //                            @"5日"]];
    //    lineChart.showCoordinateAxis = YES;
    //
    //
    //
    //    //No.1
    //    NSArray *data01Array = @[@0,
    //                             @4,
    //                             @0,
    //                             @2,
    //                             @0];
    //    PNLineChartData *data01 = [[PNLineChartData alloc] init];
    //    data01.color = PNRed;
    //    data01.itemCount = data01Array.count;
    //        data01.alpha = 0.3f;
    //        data01.inflexionPointColor = PNGreen;
    //        data01.inflexionPointStyle = PNLineChartPointStyleCircle;
    //    data01.getData = ^(NSUInteger index) {
    //
    //        CGFloat yValue = [data01Array[index] floatValue];
    //        return [PNLineChartDataItem dataItemWithY:yValue];
    //    };
    //    lineChart.showSmoothLines = YES;
    //    lineChart.chartData = @[data01];
    //    [lineChart strokeChart];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor redColor];
    
    

    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    [self.view addSubview:self.lineChart];
    NSMutableArray *xlbs = @[].mutableCopy;
    for (NSNumber *number in _gameArr) {
        [xlbs addObject:@""];
//        [xlbs addObject:[NSString stringWithFormat:@"%lu",(unsigned long)[_gameArr indexOfObject:number]]];
    }
    [self.lineChart setXLabels:xlbs];
    
    // Line Chart No.1
    NSArray * data01Array = _gameArr;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = self.lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // the color is set to clearColor so that the demo remains the same
    
    
    self.lineChart.chartData = @[data01];
    [self.lineChart strokeChart];
    //    self.lineChart.delegate = self;
    
    //折线图
    //    PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(-20, CGRectGetMaxY(self.line.frame) + 20, self.xmy_width, self.xmy_height - CGRectGetMaxY(self.line.frame) - 20 - 10)];
    //    [self addSubview:lineChart];
    
    
    //    self.lineChart = lineChart;
    //    //    self.lineChart.yLabelFormat = @"%1.5f";
    //    self.lineChart.yLabelFont = [UIFont systemFontOfSize:14];
    //    self.lineChart.yLabelColor = PNRed;
    //    self.lineChart.backgroundColor = [UIColor clearColor];
    //    lineChart.xLabelColor = PNRed;
    //    lineChart.xLabelFont = [UIFont systemFontOfSize:12];
    //    [self.lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5"]];
    //    self.lineChart.showCoordinateAxis = NO;
    //
    //    // the color is set to clearColor so that the demo remains the same
    //    self.lineChart.yGridLinesColor = PNRed;
    //    self.lineChart.showYGridLines = YES;
    //
    //    //    self.lineChart.yFixedValueMax = 300.0;
    //    self.lineChart.yFixedValueMin = 0.0;
    //
    //
    //    // Line Chart #1
    //    NSArray * dataArray = @[@1, @0, @3 ,@4,@0];
    //    PNLineChartData *data = [PNLineChartData new];
    //    //    data01.dataTitle = @"Alpha";
    //    data.color = PNRed;
    //    data.alpha = 0.3f;
    //    data.itemCount = dataArray.count;
    //    data.inflexionPointColor = PNRed;
    //    data.inflexionPointStyle = PNLineChartPointStyleCircle;
    //    data.getData = ^(NSUInteger index) {
    //        CGFloat yValue = [dataArray[index] floatValue];
    //        return [PNLineChartDataItem dataItemWithY:yValue];
    //    };
    //
    //
    //    self.lineChart.chartData = @[data];
    
    //    //修改ylabels的frame
    //    for (int index = 0; index < lineChart.yChartLabels.count; index++) {
    //
    //        UILabel *lb = lineChart.yChartLabels[index];
    //        if (index == lineChart.yChartLabels.count - 1) {
    //
    //            lb.hidden = YES;
    //        }
    //        lb.xmy_x += lineChart.xmy_width - lb.xmy_width;
    //        lb.xmy_y -= 8;
    //    }
    //    
    //    //修改xLabels的frame
    //    for (int index = 0; index < lineChart.xChartLabels.count; index++) {
    //        
    //        UILabel *lb = lineChart.xChartLabels[index];
    //        lb.xmy_x -= 10;
    //    }
//    NSArray * data02Array = @[@4, @5, @3, @10, @0, @3, @2];
//    PNLineChartData *data02 = [PNLineChartData new];
//    data02.dataTitle = @"Alpha";
//    data02.color = PNFreshGreen;
//    data02.alpha = 0.3f;
//    data02.showPointLabel = YES;
//    data02.itemCount = data01Array.count;
//    data02.inflexionPointColor = PNRed;
//    data02.inflexionPointStyle = PNLineChartPointStyleTriangle;
//    data02.getData = ^(NSUInteger index) {
//        CGFloat yValue = [data02Array[index] floatValue];
//        return [PNLineChartDataItem dataItemWithY:yValue];
//    };
//    self.data01 = data01;
//    self.data02 = data02;
    
//    [self.lineChart strokeChart];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
////        self.lineChart.yLabels
//        [self.lineChart updateChartData:@[data02]];
//    });
    //    self.lineChart.delegate = self;
    
}

//按照生日属性排序对象数组
- (void)sortArrayWithBirthday {
    
    NSMutableArray *argumentArray = @[].mutableCopy;
    for (int i = 0; i < 10; i++) {
        
        Person *person = [[Person alloc] init];
        person.birthday = [NSDate dateWithTimeIntervalSinceNow:- i * 10000];
        [argumentArray addObject:person];
    }
    
    
//    //方法一   Compare method 在对象里面实现一个compare:方法 用选择器排序
//    NSArray *results = [argumentArray sortedArrayUsingSelector:@selector(compare:)];
    
    //方法二 NSSortDescriptor(better)
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"birthday" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [argumentArray sortedArrayUsingDescriptors:sortDescriptors];
    
    
    //方法三 Blocks(shiny!)
    NSArray *sortedArrayBlock = [argumentArray sortedArrayUsingComparator:^NSComparisonResult(Person *personA, Person *personB) {
       
        return [personA.birthday compare:personB.birthday];
        
    }];
    
}


#pragma mark watch you know
- (void)watchTVWithUrl:(NSString *)url {

    WKWebView *wkWeb = [[WKWebView alloc] initWithFrame:self.view.bounds];
    wkWeb.backgroundColor = [UIColor redColor];
    [wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:wkWeb];
    wkWeb.navigationDelegate = self;
//    [wkWeb selectAll:<#(nullable id)#>]
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{

    NSString *url = webView.URL.absoluteString;
    NSLog(@"当前网址==== %@", url);
}

//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//
//    NSString *JsStr = @"(document.getElementsByTagName(\"video\")[0]).src";
//    [webView evaluateJavaScript:JsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//        if(![response isEqual:[NSNull null]] && response != nil){
//            //截获到视频地址了
//            NSLog(@"response == %@",response);
//        }else{
//            //没有视频链接
//            NSLog(@"");
//        }
//    }];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
