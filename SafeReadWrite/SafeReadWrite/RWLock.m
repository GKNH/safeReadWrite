//
//  RWLock.m
//  SafeReadWrite
//
//  Created by Sun on 2020/1/25.
//  Copyright © 2020 sun. All rights reserved.
//

#import "RWLock.h"
#import <pthread.h>

/**
 读写锁
 */
@interface RWLock ()
// 读写锁
@property (nonatomic, assign) pthread_rwlock_t lock;
@end

@implementation RWLock

- (void)readWriteTest {
    // 读写锁的初始化
    pthread_rwlock_init(&_lock, NULL);
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 10; i++) {
        // 新线程中执行read代码
        dispatch_async(queue, ^{
            [self read];
        });
        // 新线程中执行write代码
        dispatch_async(queue, ^{
            [self write];
        });
    }
    
}

- (void)read {
    // 上锁，只读锁
    pthread_rwlock_rdlock(&_lock);
    sleep(1);
    NSLog(@"%s", __func__);
    // 解锁
    pthread_rwlock_unlock(&_lock);
}

- (void)write {
    // 上锁，读写锁
    pthread_rwlock_wrlock(&_lock);
    sleep(1);
    NSLog(@"%s", __func__);
    // 解锁
    pthread_rwlock_unlock(&_lock);
}

- (void)dealloc {
    // 销毁锁
    pthread_rwlock_destroy(&_lock);
}

@end
