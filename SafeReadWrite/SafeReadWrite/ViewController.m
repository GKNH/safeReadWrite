//
//  ViewController.m
//  SafeReadWrite
//
//  Created by Sun on 2020/1/25.
//  Copyright © 2020 sun. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
#import "RWLock.h"

/**
 让队列中的其他任务停止，先执行barrier栅栏里的任务
 */
@interface ViewController ()
// 读写锁
@property (nonatomic, strong) dispatch_queue_t queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    RWLock *lock = [[RWLock alloc] init];
//    [lock readWriteTest];

    // 创建自己的并发队列，必须是自己创建的
    self.queue = dispatch_queue_create("rw_queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        // 新线程中执行read
        dispatch_async(self.queue, ^{
            [self read];
        });
        // 新线程中执行read
        dispatch_async(self.queue, ^{
            [self read];
        });
        // 新线程中执行read
        dispatch_async(self.queue, ^{
            [self read];
        });
        // 新线程中执行write
        dispatch_barrier_async(self.queue, ^{
            [self write];
        });
    }
}

// 读
- (void)read {
    sleep(1);
    NSLog(@"read -> %@", [NSThread currentThread]);
}

// 写
- (void)write {
    sleep(1);
    NSLog(@"write -> %@", [NSThread currentThread]);
}

@end
