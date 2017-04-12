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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@2];
        [subscriber sendError:nil];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    // 订阅数字的改变.
    [signal subscribeNext:^(id  _Nullable x) {
        
    }];
    
    // 订阅完成
    [signal subscribeCompleted:^{
        
    }];
    
    // 订阅错误信息
    [signal subscribeError:^(NSError * _Nullable error) {
        
    }];
     */
    
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}


@end
