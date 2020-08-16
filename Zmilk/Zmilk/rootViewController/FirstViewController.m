//
//  FirstViewController.m
//  Zmilk
//
//  Created by lyz on 2020/8/16.
//  Copyright © 2020 zll. All rights reserved.
//

#import "FirstViewController.h"
#import "EditViewController.h"
#import "RingsDataCache.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mainTableView;

@property (nonatomic,strong)NSMutableArray *cacheDataArray;
@property (nonatomic,strong)UIButton *rightBtn;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.rightBtn.frame = CGRectMake(0, 0, 30, 30);
    self.rightBtn.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 25, self.navigationController.navigationBar.center.y);
    [self.rightBtn addTarget:self action:@selector(rightBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.rightBtn];
    
    [self createTableView];
    [self getCacheData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.rightBtn.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.rightBtn.hidden = NO;
}

- (void)rightBtnPress {
    EditViewController *vc = [[EditViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//获取缓存列表
- (void)getCacheData {
    RingsDataCache *cache = [[RingsDataCache alloc] init];
    self.cacheDataArray = [cache getCacheArray];
    
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

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [headerView addSubview:lineView];
    if (section == 0) {
        lineView.hidden = YES;
    }else{
        lineView.hidden = NO;
    }
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 150, 55)];
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:18.0];
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.text = @"⏰喝水提醒";
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
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 25)];
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.textColor = [UIColor blackColor];
        infoLabel.tag = 1001;
        [cell.contentView addSubview:infoLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 200, 10, 180, 25)];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.tag = 1003;
        [cell.contentView addSubview:timeLabel];


    }
    NSDictionary *dic = [self.cacheDataArray objectAtIndex:indexPath.row];
    UILabel *infoLabel = [cell.contentView viewWithTag:1001];
    UILabel *timeLabel = [cell.contentView viewWithTag:1003];
    infoLabel.text = dic[@"name"];
    timeLabel.text = dic[@"time"];
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
