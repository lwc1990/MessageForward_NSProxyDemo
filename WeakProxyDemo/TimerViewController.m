//
//  TimerViewController.m
//  WeakProxyDemo
//
//  Created by syl on 2017/5/8.
//  Copyright © 2017年 personCompany. All rights reserved.
//

#import "TimerViewController.h"
#import "WeakProxy.h"
@interface TimerViewController ()
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"timer";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
    [self addTimer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addTimer
{
    //timer 的target直接传入self，发现pop后并未被销毁
//    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    //经过weakProxy处理后即可正常释放
    self.timer = [NSTimer timerWithTimeInterval:1 target:[WeakProxy proxyWithTarget:self] selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)timerEvent
{
    NSLog(@"time event");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)dealloc
{
    [self.timer invalidate];
    NSLog(@"销毁 timer");
    NSLog(@"%s",__func__);
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
