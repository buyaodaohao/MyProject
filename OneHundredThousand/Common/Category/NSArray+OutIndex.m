//
//  NSArray+OutIndex.m
//  RunLoopTest
//
//  Created by FaTuZhiNengZhuKK on 17/4/20.
//  Copyright © 2017年 FangTuZhiNengZhuKK. All rights reserved.
//

#import "NSArray+OutIndex.h"

@implementation NSArray (OutIndex)


- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

@end
