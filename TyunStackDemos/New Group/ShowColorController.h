//
//  ShowColorController.h
//  TyunStackDemos
//
//  Created by zwzh_14 on 2021/9/3.
//  Copyright © 2021 优谱德. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowColorController : UIViewController

@end

NS_ASSUME_NONNULL_END



///给UIViewController绑定属性
@interface UIViewController(TYProperty)

@property (nonatomic, copy) NSString *ty_value;

@end
