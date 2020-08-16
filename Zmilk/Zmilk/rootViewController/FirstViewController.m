//
//  FirstViewController.m
//  Zmilk
//
//  Created by lyz on 2020/8/16.
//  Copyright © 2020 zll. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mainTableView;

@property (nonatomic,strong)NSMutableArray *cacheDataArray;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self getCacheData];
}

//获取缓存列表
- (void)getCacheData {
    
    
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
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [headerView addSubview:lineView];
    if (section == 0) {
        lineView.hidden = YES;
    }else{
        lineView.hidden = NO;
    }
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 150, 60)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:18.0];
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.text = @"1111";
    [headerView addSubview:headerLabel];
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cacheDataArray.count>0?self.cacheDataArray.count:10;
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
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [cell.contentView addSubview:lineView];
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"111";
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath{

    return YES;

}

//执行删除操作

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath{

    NSLog(@"删除删除删除删除删除删除删除删除删除");

}

//侧滑出现的文字

- (NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath{

    return@"删除";

}

@end
