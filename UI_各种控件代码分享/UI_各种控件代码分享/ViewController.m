//
//  ViewController.m
//  UI_各种控件代码分享
//
//  Created by yangheng on 15/3/29.
//  Copyright (c) 2015年 yangheng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic, strong)NSArray *titles;
@property(nonatomic, strong)NSArray *componts;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.开关控件  控制方法的两种状态，当一个事物只有两种状态的时候使用
    //    [self testSwitch];
    //2.活动指示控件  显示进度
    //    [self testActivity];
    //3.步进器  计数使用
    //    [self testStepper];
    //4.滑块儿
    //    [self testSlider];
    //5.分段控件
    //    [self testUISegmentedControl];
    //6.进度条  专门用来跟踪(描述）进度
    //    [self testUIProgress];
    //7.警告框
    //    [self testUIAlertView];
    //8.文本输入视图
    [self testUITextView];
    //9.动作列表 作用：在弹出的选项里进行选择
    //    [self testUIActionSheet];
    //10.选择控件
    //    [self testUIPickerView];
    //11.日期选择控件
    //    [self testUIDatePicker];
    
    //12.UIControl  按钮的父类，继承自UIView，可以直接响应交互。
    //    [self testUIControl];
    // Do any additional setup after loading the view.
}
-(void)testUIControl{
    UIControl *control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    [control addTarget:self action:@selector(myControlMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:control];
}

-(void)myControlMethod:(UIControl *)control{
    NSLog(@"来了");
}

-(void)testUIDatePicker{
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(10, 30, 200, 200)];
    //选择控件的模式
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.view addSubview:datePicker];
    //显示的是当前的日期
    datePicker.date = [NSDate date];
}

-(void)testUIPickerView{
    self.titles = @[@"北京",@"上海",@"长春",@"天津",@"大理"];
    NSArray *provs = @[@"河北",@"河南",@"辽宁",@"黑龙江",@"吉林"];
    
    self.componts = @[self.titles,provs];
    
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(10, 30, 200, 200)];
    //负责处理外观与逻辑
    picker.delegate = self;
    //处理数据
    picker.dataSource = self;
    
    [self.view addSubview:picker];
}

#pragma mark picker的代理
//每一部分有多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.titles.count;
    }else{
        return [self.componts[1] count];
    }
}

//每一行的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.titles[row];
    }else{
        return self.componts[1][row];
    }
}

//显示一共的分区
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.componts.count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 1) {
        if (row == 2) {
            NSString *string = self.componts[component][row];
            NSLog(@"%@",string);
        }
    }
    NSString *string = self.componts[component][row];
    NSLog(@"%@",string);
    
}


-(void)testUIActionSheet{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button setTitle:@"分享" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(sheetShared:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

-(void)sheetShared:(UIButton *)button{
    //创建表单
    //destructiveButtonTitle:设置成nil即可
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微博",@"QQ空间",@"微信", nil];
    
    //                表单要显示的视图
    [action showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%i",buttonIndex);
}

-(void)testUITextView{
    //创建
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 30, 300, 300)];
    textView.backgroundColor = [UIColor grayColor];
    textView.delegate = self;
    
    //    textView.text = @"sjfvpowjspfjwsg哦哦给对方sjfvpowjspfjwsg哦哦给对方sjfvpowjspfjwsg哦哦给对方sjfvpowjspfjwsg哦哦给对方sjfvpowjspfjwsg哦哦给对方sjfvpowjspfjwsg哦哦给对方sjfvpowjspfjwsg哦哦给对方sjfvpowjspfjwsg哦哦给对方sjfvpowjspfjwsg哦哦给对方sjfvpowjspfjwsg哦哦给对方sjfvpowjspfjwsg哦哦给对方sjfvpowjspfjwsg哦哦给对方";
    //    [textView sizeToFit];
    
    //工具栏
    UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishClicked:)];
    
    UIBarButtonItem *clean = [[UIBarButtonItem alloc]initWithTitle:@"清空" style:UIBarButtonItemStyleDone target:self action:@selector(cleanClicked:)];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    toolBar.items = @[finish,clean];
    
    textView.inputAccessoryView = toolBar;
    
    textView.tag = 100;
    [self.view addSubview:textView];
    
}

//完成按钮方法
-(void)finishClicked:(UIBarButtonItem *)item{
    UITextView *textView = (UITextView *)[self.view viewWithTag:100];
    
    [textView resignFirstResponder];
}
//清空按钮方法
-(void)cleanClicked:(UIBarButtonItem *)item{
    UITextView *textView = (UITextView *)[self.view viewWithTag:100];
    
    textView.text = @"";
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    
    return YES;
}

-(void)testUIAlertView{
    //功能：在框里面输入账号，密码
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示：" message:@"请输入账号，密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *user = [alertView textFieldAtIndex:0];
    UITextField *pass = [alertView textFieldAtIndex:1];
    
    NSLog(@"user:%@,pass:%@",user.text,pass.text);
}

-(void)testUIProgress{
    //创建对象
    UIProgressView *progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    //不手动设置，以默认值为准
    progressView.frame = CGRectMake(30, 200, 200, 20);
    
    [self.view addSubview:progressView];
    
    progressView.backgroundColor = [UIColor redColor];
    
    progressView.progressImage = [UIImage imageNamed:@"tab_0"];
    //
    //    progressView.trackImage = [UIImage imageNamed:@"tab_1"];
    progressView.progressTintColor = [UIColor greenColor];
    
    //起始值，范围[0.0,1.0],如果给出范围的值，回失效（发生错乱）
    progressView.progress = 0.1;
    
    //终止值，这个值可以大于1.进度条的整体默认最小值是1.0，当这个值大于1时，系统会用进度条的整体表示这个值
    [progressView setProgress:10.0 animated:YES];
}

-(void)testUISegmentedControl{
    //创建对象 注意：默认会将分段控件的宽度平均分配
    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems:@[@"first",@"second",@"third",@"fourth"]];
    //注意：如果不设置大小，以默认的为准。
    control.frame = CGRectMake(100, 100, 200, 40);
    
    [self.view addSubview:control];
    
    //插入元素
    [control insertSegmentWithTitle:@"sixth" atIndex:1 animated:YES];
    
    //标记选中元素
    control.selectedSegmentIndex = 3;
    
    //设置宽度
    [control setWidth:100 forSegmentAtIndex:0];
    
    NSLog(@"%.lf",[control widthForSegmentAtIndex:0]);
    
    //删除元素
    [control removeSegmentAtIndex:4 animated:YES];
    
    //触发方法
    [control addTarget:self action:@selector(controlMethod:) forControlEvents:UIControlEventValueChanged];
}

-(void)controlMethod:(UISegmentedControl *)seg{
    NSLog(@"%i",seg.selectedSegmentIndex);
}

-(void)testSlider{
    //创建对象
    UISlider *slider = [[UISlider alloc]init];
    //高度是默认值，但是要想滑动必须给高度
    slider.frame = CGRectMake(100, 100, 200, 10);
    
    [self.view addSubview:slider];
    
    //属性
    //最小值
    slider.minimumValue = 0;
    //划过的滑条颜色
    slider.minimumTrackTintColor = [UIColor redColor];
    //最小方的图片
    slider.minimumValueImage = [UIImage imageNamed:@"tab_0"];
    //最大值
    slider.maximumValue = 100;
    slider.maximumTrackTintColor = [UIColor greenColor];
    //当前的值 默认是零
    slider.value = 40;
    
    //单独设置滑块儿的颜色不显示，要让滑块的图片与颜色同时设置时，颜色才会显示
    slider.thumbTintColor = [UIColor yellowColor];
    
    [slider setThumbImage:[UIImage imageNamed:@"tab_3"] forState:UIControlStateNormal];
    
    //触发的事件
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
}

-(void)sliderMethod:(UISlider *)slider{
    NSLog(@"%.lf",slider.value);
}

-(void)testStepper{
    //创建对象  大小默认
    UIStepper *stepper = [[UIStepper alloc]initWithFrame:CGRectMake(100, 100, 0, 0)];
    //显示
    [self.view addSubview:stepper];
    
    //可以达到的最小值
    stepper.minimumValue = 1;
    //最大值
    stepper.maximumValue = 10;
    //单位增量
    stepper.stepValue = 2;
    
    //触发的方法
    [stepper addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventValueChanged];
    
    //实例：买票
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, 100, 40)];
    label.tag = 10;
    label.text = @"20";
    //    [label sizeToFit];
    [self.view addSubview:label];
}

-(void)changeNumber:(UIStepper *)step{
    //step.value：代表的当前值
    NSLog(@"%lf,%lf",step.stepValue,step.value);
    
    UILabel *label = (UILabel *)[self.view viewWithTag:10];
    
    label.text = [NSString stringWithFormat:@"%.lf元",20*step.value];
}

-(void)testActivity{
    //创建并设置样式  大小默认
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    activity.frame = CGRectMake(100, 100, 0, 0);
    
    [self.view addSubview:activity];
    
    //开始动画
    [activity startAnimating];
    
    //userInfo：附加信息
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(testTimer:) userInfo:activity repeats:NO];
}

-(void)testTimer:(NSTimer *)timer{
    UIActivityIndicatorView *acti = timer.userInfo;
    
    //结束动画
    [acti stopAnimating];
    
    //使NSTimer对象失效
    //    [timer invalidate];
}

-(void)testSwitch{
    //创建开关对象
    //开关的大小可以设置成零，使用的默认值
    UISwitch *mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(100, 100, 0, 0)];
    
    //显示
    [self.view addSubview:mySwitch];
    
    //开状态下的背景色
    mySwitch.onTintColor = [UIColor redColor];
    //关状态下的背景色
    mySwitch.tintColor = [UIColor greenColor];
    //开状态下的背景图
    //    mySwitch.onImage;
    //开关把手的背景色
    mySwitch.thumbTintColor = [UIColor yellowColor];
    
    //触发的方法 UIControlEventValueChanged:状态改变时
    [mySwitch addTarget:self action:@selector(testSwitch:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)testSwitch:(UISwitch *)swi{
    //判断开关的状态
    NSLog(@"%i",swi.on);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
