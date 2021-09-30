//
//  ShowColorController.m
//  TyunStackDemos
//
//  Created by zwzh_14 on 2021/9/3.
//  Copyright © 2021 优谱德. All rights reserved.
//

#import "ShowColorController.h"
#import <objc/runtime.h>

@interface ShowColorController ()

@end

@implementation ShowColorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIViewController *vc = [[NSClassFromString(NSStringFromClass(self.class)) alloc] init];
    UITableView *table = [[UITableView alloc] init];
    table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    vc.ty_value
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


static char * UIViewControllerTYValueKey = "UIViewControllerTYValueKey";

@implementation UIViewController(TYProperty)

- (void)setTy_value:(NSString *)ty_value {
    objc_setAssociatedObject(self, UIViewControllerTYValueKey, ty_value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)ty_value {
    return objc_getAssociatedObject(self, UIViewControllerTYValueKey);
}

@end
