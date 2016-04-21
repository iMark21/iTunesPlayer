//
//  MMSearchManager.m
//  BeRepublicMusic
//
//  Created by Juan Miguel Marques Morilla on 20/4/16.
//  Copyright © 2016 Juan Miguel Marqués Morilla. All rights reserved.
//

#import "MMSearchManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@implementation MMSearchManager

+(instancetype)sharedInstance{
    
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
    
}

-(BOOL)checkCorrectTextFieldSignal:(NSString*)string{
    
    return string.length > 2 ? TRUE : FALSE;
    
}


@end
