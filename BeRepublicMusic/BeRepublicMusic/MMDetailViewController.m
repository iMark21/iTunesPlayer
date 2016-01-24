//
//  MMDetailViewController.m
//  BeRepublicMusic
//
//  Created by Juan Miguel Marqués Morilla on 23/1/16.
//  Copyright © 2016 Juan Miguel Marqués Morilla. All rights reserved.
//

#import "MMDetailViewController.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "UIImage+Blur.h"


@interface MMDetailViewController ()

@property int newPositionSong;

@end

@implementation MMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureControllerForSong:[self.songNumber intValue]];
    
    // Do any additional setup after loading the view.
}


-(void)configureControllerForSong:(int)songPosition{
    
    self.newPositionSong = songPosition;
    
    NSLog(@"%ld",(long)self.newPositionSong);
    
    MMAlbumObject *selectedObject = [self.songsArray objectAtIndex:self.newPositionSong];
    
    [self.imageSong sd_setImageWithURL:[NSURL URLWithString:selectedObject.imageAlbum] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    
    self.artistTitle.text = selectedObject.artist;
    
    self.songTitle.text = selectedObject.title;
    
    NSURL *urlStream = [NSURL URLWithString:selectedObject.songURL];
    
    self.audioPlayer = [[AVPlayer alloc] initWithURL:urlStream];

    
    
}


- (IBAction)actionPlay:(id)sender {
    
    if (self.audioPlayer.rate == 0.0f){
        [self.audioPlayer play];
        [self.playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        self.isPlaying = YES;
    }
    else {
        [self.audioPlayer pause];
        [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        self.isPlaying = NO;
    }
    
    
}

- (IBAction)actionNext:(id)sender {
    
    if (self.newPositionSong + 1 > self.songsArray.count) {
        return;
    }

    [self configureControllerForSong:self.newPositionSong +1];
    
    if (self.isPlaying) {
        
        [self.audioPlayer pause];
        
        [self.audioPlayer play];

    }
    
}
- (IBAction)actionPrevious:(id)sender {
    
    if (self.newPositionSong - 1 < 0) {
        return;
    }
    
    [self configureControllerForSong:self.newPositionSong -1];

    
    if (self.isPlaying) {
        
        [self.audioPlayer pause];
        
        [self.audioPlayer play];
        
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.imageSong removeFromSuperview];
    
    self.audioPlayer = nil;

    
}

@end
