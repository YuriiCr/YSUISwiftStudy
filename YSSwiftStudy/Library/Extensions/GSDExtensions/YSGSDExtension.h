//
//  GSDExtension.h
//  YSCarWash
//
//  Created by Yurii Sushko on 03.07.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  BOOL(^YSDispatchConditionBlock)(void);

dispatch_queue_t YSMainQueue(void);

dispatch_queue_t YSUserInteractive(void);
dispatch_queue_t YSUserInitiatedQueue(void);
dispatch_queue_t YSDefaultQueue(void);
dispatch_queue_t YSUtilityQueue(void);
dispatch_queue_t YSBackgroundQueue(void);

void YSDispatchAsyncInBackground (dispatch_block_t block);

void YSDispatchSyncInBackground (dispatch_block_t block);

void YSDispatchAsyncOnMainQueue (dispatch_block_t block);

void YSDispatchSyncOnMainQueue (dispatch_block_t block);

void YSDispatchAfter(NSTimeInterval delay, dispatch_block_t block);

void YSDispatchAfterDelayWithCondition(NSTimeInterval delay, dispatch_block_t block, YSDispatchConditionBlock conditionBlock);
