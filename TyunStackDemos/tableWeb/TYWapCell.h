//
//  NewToutiaoWapCell.h
//  UniversalProject
//
//  Created by zwzh_14 on 2021/11/22.
//  Copyright © 2021 OMT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController3.h"

NS_ASSUME_NONNULL_BEGIN
static NSString *TYWapCellID = @"TYWapCell";
@interface TYWapCell : UITableViewCell


@property(nonatomic, strong) ViewController3 * web;

@property (nonatomic, assign) CGFloat webHeight;


// weview加载成功后高度回调
@property (copy,nonatomic) void(^webHeightBlock)(CGFloat height);

- (void)updateCell:(NSString *)urlString isForceUpdate:(BOOL)isForceUpdate;


@end

NS_ASSUME_NONNULL_END
