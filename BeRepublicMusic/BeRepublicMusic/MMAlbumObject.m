//
//  MMAlbumObject.m
//  BeRepublicMusic
//
//  Created by Juan Miguel Marqués Morilla on 22/1/16.
//  Copyright © 2016 Juan Miguel Marqués Morilla. All rights reserved.
//

#import "MMAlbumObject.h"

@implementation MMAlbumObject

-(instancetype)initWithDictionary:(NSDictionary*)dictionary{
    
    
    if (self = [super init]) {
        
        [self setValuesWithDictionary:dictionary];
        
    }
    
    return self;
}

-(void)setValuesWithDictionary:(NSDictionary*)dictionary{
    
    self.title = [dictionary objectForKey:@"trackCensoredName"];
    self.artist = [dictionary objectForKey:@"artistName"];
    self.gender = [dictionary objectForKey:@"primaryGenreName"];
    self.prize = [[dictionary objectForKey:@"trackPrice"]floatValue];
    self.imageAlbum = [dictionary objectForKey:@"artworkUrl100"];
    self.songURL = [dictionary objectForKey:@"previewUrl"];

    
}

@end
