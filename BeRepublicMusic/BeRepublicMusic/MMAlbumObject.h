//
//  MMAlbumObject.h
//  BeRepublicMusic
//
//  Created by Juan Miguel Marqués Morilla on 22/1/16.
//  Copyright © 2016 Juan Miguel Marqués Morilla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMAlbumObject : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *artist;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *prize;
@property (nonatomic,strong) NSString *imageAlbum;
@property (nonatomic,strong) NSString *songURL;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

-(void)setValuesWithDictionary:(NSDictionary*)dictionary;


@end
