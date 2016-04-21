//
//  MMAPI.m
//  BeRepublicMusic
//
//  Created by Juan Miguel Marqués Morilla on 22/1/16.
//  Copyright © 2016 Juan Miguel Marqués Morilla. All rights reserved.
//

#import "MMAPI.h"


@implementation MMAPI

+(instancetype)sharedInstance{
    
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
    
}

- (RACSignal *)signalForSearchWithText:(NSString *)text {

    @weakify(text)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(text);
        NSURLSession *session = [NSURLSession sharedSession];
        
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        
        NSURL *queryURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@",text]];
        
        NSLog(@"URL: %@",queryURL);
        
        [[session dataTaskWithURL:queryURL
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    
                    NSArray *jsonArray = [NSArray array];
                    
                    if (data !=nil) {
                        jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    }
                    
                    
                    NSLog(@"Result: %@",jsonArray);
                    if(jsonArray) {
                        //block(jsonArray, nil);
                        [subscriber sendNext:jsonArray];
                        
                    } else {
                        NSError *error = [NSError errorWithDomain:@"plist_download_error" code:1
                                                         userInfo:[NSDictionary dictionaryWithObject:@"Can't fetch data" forKey:NSLocalizedDescriptionKey]];
                        //block(nil, error);
                        [subscriber sendError:error];
                    }
                    
                }] resume];
        
        
        return nil;
    }];



}
//-(void)queryWithString:(NSString *)searchString completionBlock:(void (^)(NSArray *, NSError *))block{
//    
//    @weakify(self)
//    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        @strongify(self);
//        NSURLSession *session = [NSURLSession sharedSession];
//        
//        searchString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
//        
//        NSURL *queryURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@",searchString]];
//        
//        NSLog(@"URL: %@",queryURL);
//        
//        [[session dataTaskWithURL:queryURL
//                completionHandler:^(NSData *data,
//                                    NSURLResponse *response,
//                                    NSError *error) {
//                    
//                    NSArray *jsonArray = [NSArray array];
//                    
//                    if (data !=nil) {
//                        jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                    }
//                    
//                    
//                    NSLog(@"Result: %@",jsonArray);
//                    if(jsonArray) {
//                        block(jsonArray, nil);
//                        
//                    } else {
//                        NSError *error = [NSError errorWithDomain:@"plist_download_error" code:1
//                                                         userInfo:[NSDictionary dictionaryWithObject:@"Can't fetch data" forKey:NSLocalizedDescriptionKey]];
//                        block(nil, error);
//                    }
//                    
//                }] resume];
//        
//        
//        return nil;
//    }];
//    
//}

@end
