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
    self.prize = [dictionary objectForKey:@"trackPrice"];
    self.imageAlbum = [dictionary objectForKey:@"artworkUrl100"];
    
    
//    self.south = [dictionary valueForKeyPath:@"bbox.south"];
//    self.north = [dictionary valueForKeyPath:@"bbox.north"];
//    self.east = [dictionary valueForKeyPath:@"bbox.east"];
//    self.west = [dictionary valueForKeyPath:@"bbox.west"];
//    self.name = [dictionary valueForKey:@"name"];
//    self.lat = [dictionary valueForKey:@"lat"];
//    self.lng = [dictionary valueForKey:@"lng"];
    
}

@end
