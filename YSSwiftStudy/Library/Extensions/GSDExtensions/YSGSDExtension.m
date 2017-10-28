//
//  GSDExtension.m
//  YSCarWash
//
//  Created by Yurii Sushko on 03.07.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSGSDExtension.h"

void YSDispatchAsyncOrSyncQueue(dispatch_queue_t queue, dispatch_block_t block, BOOL asynchronous);

static char * const cYSDispatchConcurrentQueue  =   "cYSDispatchConcurrentQueue";
static char * const cYSDispatchSerialQueue      =   "cYSDispatchSerialQueue";

dispatch_queue_t YSQueueWithQOSClass(long identifer);

#pragma mark -
#pragma mark C function for QOS class , concurrent queues

dispatch_queue_t YSQueueWithQOSClass(long identifier) {
    return dispatch_get_global_queue(identifier, 0);
}

//create c function that return global queue for concurrent queues with QOSclass
// params: indtifer - QOSClass, 0 flag for future extensions

//UserIneractive queue has the highest priority

dispatch_queue_t YSUserInteractiveQueue() {
    return YSQueueWithQOSClass(QOS_CLASS_USER_INTERACTIVE);
}

//UserInitiated QOS class which indicates work performed by this thread was initiated by the user, has higest priority except QOS_CLASS_USER_INTERACTIVE

dispatch_queue_t YSUserInitiatedQueue() {
    return YSQueueWithQOSClass(QOS_CLASS_USER_INITIATED);
}

//A default QOS class used by the system in cases where more specific QOS class information is not available, priority lower than QOS_CLASS_USER_INTERACTIVE,QOS_CLASS_USER_INTERACTIVE

dispatch_queue_t YSDefaultQueue() {
    return YSQueueWithQOSClass(QOS_CLASS_DEFAULT);
}

//QOS class which indicates work performed by this thread may or may not be initiated by the user and that the user is unlikely to be immediately waiting for the results. Priority lower than privious classes

dispatch_queue_t YSUtiltityQueue() {
    return YSQueueWithQOSClass(QOS_CLASS_UTILITY);
}

//A QOS class which indicates work performed by this thread was not initiated by the user and that the user may be unaware of the results.Priority lower than privious classes.

dispatch_queue_t YSBackgroundQueue() {
    return YSQueueWithQOSClass(QOS_CLASS_BACKGROUND);
}

#pragma mark -
#pragma mark C function for main,concurrent,serial queues

//Returns the default queue that is bound to the main thread
dispatch_queue_t YSMainQueue() {
    return dispatch_get_main_queue();
}

//A concurrent dispatch queue is useful when you have multiple tasks that can run in parallel

dispatch_queue_t YSCreateConcurrentQueue() {
    return dispatch_queue_create(cYSDispatchConcurrentQueue, DISPATCH_QUEUE_CONCURRENT);
}

//Serial queues are useful when you want your tasks to execute in a specific order.
dispatch_queue_t YSCreateSerialQueue() {
    return dispatch_queue_create(cYSDispatchSerialQueue, DISPATCH_QUEUE_SERIAL);
}

#pragma mark -
#pragma mark C function for ececution queue in Background

//Submits a block for asynchronous execution on a dispatch queue and returns immediately
void YSDispatchAsyncInBackground (dispatch_block_t block) {
    YSDispatchAsyncOrSyncQueue(YSBackgroundQueue(), block, YES);
}

//Submits a block object for execution on a dispatch queue and waits until that block completes.Never call the dispatch_sync function from a task that is executing in the same queue that you are planning to pass to the function

void YSDispatchSyncInBackground (dispatch_block_t block) {
        YSDispatchAsyncOrSyncQueue(YSBackgroundQueue(), block, NO);
}

#pragma mark -
#pragma mark C function for ececution queue on MainThred

void YSDispatchAsyncOnMainQueue (dispatch_block_t block) {
    if (block) {
        dispatch_async(YSMainQueue(),block);
    }
}

void YSDispatchSyncOnMainQueue (dispatch_block_t block) {
    if (block) {
        if ([[NSThread currentThread] isMainThread]) {
            block();
        } else {
            dispatch_sync(YSMainQueue(), block);
        }
    }
}

#pragma mark -
#pragma mark C function for ececution on queue

void YSDispatchAsyncOnQueue(dispatch_queue_t queue, dispatch_block_t block) {
    YSDispatchAsyncOrSyncQueue(queue, block, YES);
}

void YSDispatchSyncOnQueue(dispatch_queue_t queue, dispatch_block_t block) {
    YSDispatchAsyncOrSyncQueue(queue, block, NO);
}

void YSDispatchAsyncOrSyncQueue(dispatch_queue_t queue, dispatch_block_t block, BOOL asynchronous) {
    if (block) {
        asynchronous ? dispatch_async(queue, block) : dispatch_sync(queue, block);
    }
}

#pragma mark -
#pragma mark C function for dispatche after

void YSDispatchAfter(NSTimeInterval delay, dispatch_block_t block) {
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(when,YSBackgroundQueue(),block);
}

void YSDispatchAfterDelayWithCondition(NSTimeInterval delay, dispatch_block_t block, YSDispatchConditionBlock conditionBlock) {
    YSDispatchAfter(delay, ^{
        if (conditionBlock()) {
            block();
            YSDispatchAfterDelayWithCondition(delay, block, conditionBlock);
        }
    });
}
