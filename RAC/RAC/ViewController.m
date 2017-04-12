//
//  ViewController.m
//  RAC
//
//  Created by zhangzhifu on 2017/4/12.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

/** 
    RAC: 函数式响应编程
    函数式: 高聚合
    响应式: KVO
 */

/** 
    万物皆信号: RACSignal
 */

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@2];
        [subscriber sendError:nil];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    // 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        
    }];
    
    // 订阅完成
    [signal subscribeCompleted:^{
        
    }];
    
    // 订阅错误信息
    [signal subscribeError:^(NSError * _Nullable error) {
        
    }];
     */
    
    
    // 订阅文本框内容的改变.
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    
    // 订阅手势点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        NSLog(@"tap");
    }];
    
    [self.label addGestureRecognizer:tap];
    
    
    // 监听alertView的代理方法.
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC TEST" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
    
//    // 用RAC写代理是有局限的，它只能实现返回值为void的代理方法
//    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
//        NSLog(@"%@",tuple.first);
//        NSLog(@"%@",tuple.second);
//        NSLog(@"%@",tuple.third);
    
    //    }];
    
    // 简化版
    [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [alertView show];
    
    
    // 监听通知.(RAC中的通知不需要remove observer)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"UIKeyboardWillShowNotification" object:nil] subscribeNext:^(NSNotification * _Nullable notification) {
        NSLog(@"%@", notification.name);
        NSLog(@"%@", notification.object);
    }];
    
    // 监听KVO
    self.scrollView.contentSize = CGSizeMake(200, 800);
    [RACObserve(self.scrollView, contentOffset) subscribeNext:^(id  _Nullable x) {
        NSLog(@"开始滚动");
    }];
}


@end
