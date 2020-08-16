//
//  FourthViewController.m
//  Zmilk
//
//  Created by lyz on 2020/8/16.
//  Copyright © 2020 zll. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *mainTableView;

@property (nonatomic,strong)NSMutableArray *cacheDataArray;
@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];    
}
- (void)createTableView {
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.mainTableView];
    
}

#pragma mark uitableviewdelegate
//自定义section的头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,59.5,self.view.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [headerView addSubview:lineView];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 150, 54)];
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:18.0];
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.text = @"我的信息";
    [headerView addSubview:headerLabel];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,44.5,self.view.frame.size.width, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [cell.contentView addSubview:lineView];

        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 25)];
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.textColor = [UIColor blackColor];
        infoLabel.tag = 1001;
        [cell.contentView addSubview:infoLabel];

    }
    UILabel *infoLabel = [cell.contentView viewWithTag:1001];
    if (indexPath.row == 0) {
        infoLabel.text = @"关于";
    }else {
        infoLabel.text = @"关于";
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"关于";
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath{

    return NO;

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
