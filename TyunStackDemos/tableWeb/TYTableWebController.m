//
//  TYTableWebController.m
//  TyunStackDemos
//
//  Created by zwzh_14 on 2021/12/3.
//  Copyright © 2021 优谱德. All rights reserved.
//

#import "TYTableWebController.h"
#import "TYWapCell.h"

#define TableCellId @"TableCellId"

@interface TYTableWebController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, strong)TYWapCell *wapCell;
@property (nonatomic, assign)CGFloat wapHeight;
@end

@implementation TYTableWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.wapHeight = 1;
    self.table.tableFooterView = [UIView new];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:TableCellId];
//    [self.table registerNib:[UINib nibWithNibName:TYWapCellID bundle:nil] forCellReuseIdentifier:TYWapCellID];
    self.wapCell = [[[NSBundle mainBundle] loadNibNamed:TYWapCellID owner:self options:nil]  lastObject];
    self.wapCell.webHeightBlock = ^(CGFloat height) {
        self.wapHeight = height;
        [self.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    };

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return self.wapHeight;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        TYWapCell *cell = self.wapCell;
//        [cell updateCell:@"https://rmt.analytics.cditv.cn/rmt/jinniu/top?openNewWeb=1" isForceUpdate:NO];
        [cell updateCell:@"https://rmt.analytics.cditv.cn/rmt/jinniu/top?openNewWeb=1" isForceUpdate:NO];

        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableCellId forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"这是一个标题%ld",indexPath.row];
        return cell;
    }
}

@end
