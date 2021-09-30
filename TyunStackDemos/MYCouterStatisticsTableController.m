//
//  MYCouterStatisticsTableController.m
//  Sedafojiao
//
//  Created by T_yun on 2016/11/17.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "MYCouterStatisticsTableController.h"
#import "MYCouterStatisHeaderCell.h"
#import "MYCouterStatisticsView.h"

@interface MYCouterStatisticsTableController ()

@end

@implementation MYCouterStatisticsTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //让tableview上移 64
    UIEdgeInsets contenInset = self.tableView.contentInset;
    contenInset.top = -22;
    [self.tableView setContentInset:contenInset];
    self.tableView.sectionHeaderHeight = 0;
    
//    self.tableView.backgroundColor = [UIColor redColor];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
        return 245;
    } else {
    
        if (kScreen_Height - 245 < 325) {
            
            return 325;
        } else {
        
            return kScreen_Height - 245;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
        MYCouterStatisHeaderCell *cell = [[MYCouterStatisHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backBlock = ^{
        
            [self.navigationController popViewControllerAnimated:YES];
        };
        cell.sengmentBlock = ^(NSInteger index) {
        
            //点击选择器回调
        };
        
        cell.title = @"标题";
        cell.totalNumber = 99999999;
        return cell;
    } else {
    
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //此处加入统计图
        
        CGFloat viewHeight = 0;
        if (kScreen_Height - 245 < 325) {
            
            viewHeight = 325;
        } else {
            
            viewHeight = kScreen_Height - 245;
        }
        MYCouterStatisticsView *view = [[MYCouterStatisticsView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, viewHeight)];
        [cell addSubview:view];
        
        return cell;
    }
}

#pragma

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
