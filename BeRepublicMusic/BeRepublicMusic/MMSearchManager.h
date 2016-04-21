//
//  MMSearchManager.h
//  BeRepublicMusic
//
//  Created by Juan Miguel Marques Morilla on 20/4/16.
//  Copyright © 2016 Juan Miguel Marqués Morilla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MMSearchManager : NSObject


+(instancetype)sharedInstance;

-(BOOL)checkCorrectTextFieldSignal:(NSString*)string;



@end
