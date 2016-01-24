//
//  MMDetailViewController.h
//  BeRepublicMusic
//
//  Created by Juan Miguel Marqués Morilla on 23/1/16.
//  Copyright © 2016 Juan Miguel Marqués Morilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMAlbumObject.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface MMDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageSong;

@property (retain) NSNumber *songNumber;

@property (weak,nonatomic) NSArray *songsArray;

@property (nonatomic,strong) AVPlayer *audioPlayer;

@property (nonatomic, assign) BOOL isPlaying;

@property (weak, nonatomic) IBOutlet UILabel *artistTitle;

@property (weak, nonatomic) IBOutlet UILabel *songTitle;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

- (IBAction)actionPlay:(id)sender;
- (IBAction)actionNext:(id)sender;
- (IBAction)actionPrevious:(id)sender;
- (IBAction)shareAction:(id)sender;

@end
