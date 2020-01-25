//
//  RWLock.h
//  SafeReadWrite
//
//  Created by Sun on 2020/1/25.
//  Copyright © 2020 sun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RWLock : NSObject

- (void)readWriteTest;

@end

NS_ASSUME_NONNULL_END
