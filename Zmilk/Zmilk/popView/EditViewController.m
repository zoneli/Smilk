//
//  EditViewController.m
//  Zmilk
//
//  Created by lyz on 2020/8/16.
//  Copyright © 2020 zll. All rights reserved.
//

#import "EditViewController.h"
#import "RingsDataCache.h"

@interface EditViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)UITableView *mainTableView;

@property (nonatomic,assign)CGFloat statubarHeight;

@property (nonatomic,strong)UIButton *rightBtn;

@property (nonatomic,copy)NSString *nameStr;

@property (nonatomic,copy)NSString *infoStr;

@property (nonatomic,copy)NSString *timeStr;

@property (nonatomic,strong)UIDatePicker *datePicker;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.statubarHeight = 0;
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.rightBtn.frame = CGRectMake(0, 0, 30, 30);
    self.rightBtn.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 25, self.navigationController.navigationBar.center.y-20);
  
    [self.rightBtn addTarget:self action:@selector(rightBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.rightBtn];
    [self createTableView];
    [self addBackView];
    [self setupDateKeyPan];
    
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
    if (self.timeStr.length>0 && self.nameStr.length>0 && self.infoStr.length>0  && self.datePicker.date) {
        //保存数据
           NSDictionary *dic = @{
               @"time":self.timeStr,
               @"name":self.nameStr,
               @"des":self.infoStr,
               @"timeFormat":self.datePicker.date,
           };
           RingsDataCache *cachedata = [[RingsDataCache alloc] init];
           [cachedata saveCacheData:dic];
           UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction *sexMan = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               [self.navigationController popViewControllerAnimated:YES];
            }];
           [alert addAction:sexMan];
           [self presentViewController:alert animated:YES completion:nil];
    }

}

- (void)tapCancel {
    [self.view endEditing:YES];    
}

- (void)addBackView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainTableView.frame.size.height+self.mainTableView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - (self.mainTableView.frame.size.height+self.mainTableView.frame.origin.y))];
    backView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCancel)];
    [backView addGestureRecognizer:tap];
    [self.view addSubview:backView];

}

- (void)createTableView {
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.statubarHeight+44, [UIScreen mainScreen].bounds.size.width,200) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.mainTableView];
    
}

- (void)setupDateKeyPan {
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width, 200);
    //设置地区: zh-中国
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //设置日期模式(Displays month, day, and year depending on the locale setting)
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    // 设置当前显示时间
    [datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [datePicker setMaximumDate: [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60]];
    //设置时间格式
    //监听DataPicker的滚动
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    self.datePicker = datePicker;
    self.datePicker.hidden = YES;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.datePicker];
    //设置时间输入框的键盘框样式为时间选择器
//    self.timeTextField.inputView = datePicker;
}

- (void)dateChange:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"MM月dd日hh时mm分";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:path];
    UILabel *label = [cell.contentView viewWithTag:1003];
    label.text = dateStr;
    self.timeStr = dateStr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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
        
        UITextField *nameT = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 200,10 ,180, 25)];
        nameT.delegate = self;
        nameT.borderStyle = UITextBorderStyleRoundedRect;
        nameT.tag = 1002;
        nameT.backgroundColor = [UIColor clearColor];
        nameT.hidden = YES;
        [cell.contentView addSubview:nameT];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 200, 10, 180, 25)];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.tag = 1003;
        timeLabel.hidden = YES;
        [cell.contentView addSubview:timeLabel];
        
    }
    
    UILabel *infoLabel = [cell.contentView viewWithTag:1001];
    UITextField *nameT = [cell.contentView viewWithTag:1002];
    UILabel *timelabel = [cell.contentView viewWithTag:1003];
    nameT.hidden = YES;
    if (indexPath.row == 0) {
        infoLabel.text = @"名称";
        nameT.hidden = NO;
    }else if (indexPath.row == 1){
        infoLabel.text = @"时间";
        timelabel.hidden = NO;
    }else if (indexPath.row == 2){
        infoLabel.text = @"提醒方式";
    }else if (indexPath.row == 3){
        infoLabel.text = @"备注";
        nameT.hidden = NO;
    }else {
        infoLabel.text = @"";
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    if (indexPath.row == 1) {
        self.datePicker.hidden = !self.datePicker.hidden;
    }else {
        self.datePicker.hidden = YES;
    }
}

#pragma mark textfielddelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    UITableViewCell *cell = (UITableViewCell *)[[textField superview] superview];
    NSIndexPath *indexP = [self.mainTableView indexPathForCell:cell];
    if (indexP.row == 0) {
        self.nameStr = textField.text;
    }else {
        self.infoStr = textField.text;
    }
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
