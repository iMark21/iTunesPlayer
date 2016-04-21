//
//  ViewController.m
//  BeRepublicMusic
//
//  Created by Juan Miguel Marqués Morilla on 22/1/16.
//  Copyright © 2016 Juan Miguel Marqués Morilla. All rights reserved.
//

#import "ViewController.h"
#import "MMAlbumObject.h"
#import "SVProgressHUD.h"
#import "MMAPI.h"
#import "MMQueryTableViewCell.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "MMDetailViewController.h"
#import "BeamMusicPlayerViewController.h"
#import "LMDropdownView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "MMSearchManager.h"
#import "NSArray+LinqExtensions.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *parsedItems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.segmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
    
    [self reactiveSignals];
    
}

-(void)reactiveSignals{
    
    @weakify(self)

    [[self.textField.rac_textSignal filter:^BOOL(NSString *text) {
        return [[MMSearchManager sharedInstance]checkCorrectTextFieldSignal:text];
    }]subscribeNext:^(id x) {
        @strongify(self)
        [[self.textField.rac_textSignal flattenMap:^id(NSString *text) {
            return [[MMAPI sharedInstance]signalForSearchWithText:self.textField.text];
        }]subscribeNext:^(NSArray *results) {
            @strongify(self)
            NSArray *statuses = [results valueForKey:@"results"];
            NSArray *places = [statuses linq_select:^id(id place) {
                return [[MMAlbumObject alloc] initWithDictionary:place];
            }];
            [self displaySongs:places];
    
        }];
        
    }];

  
}

- (void)displaySongs:(NSArray *)places {
    
    self.parsedItems = [NSMutableArray new];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.parsedItems = [NSMutableArray arrayWithArray:places];
        [self.tableView reloadData];
    });

}


#pragma mark UITableView methods



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
    
    return [self.parsedItems count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    MMQueryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MMQueryTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (self.parsedItems.count>0) {
        MMAlbumObject *album = [self.parsedItems objectAtIndex:indexPath.row];
        cell.title.text =  album.title;
        cell.artist.text = album.artist;
        cell.gender.text = album.gender;
        cell.prize.text = [NSString stringWithFormat:@"%.02f",album.prize];
        
        [cell.imageAlbum sd_setImageWithURL:[NSURL URLWithString:album.imageAlbum] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([[segue identifier] isEqualToString:@"detail"])
    {

        MMDetailViewController *vc = [segue destinationViewController];
        
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        NSNumber *selSong = [[NSNumber alloc] initWithInteger:path.row];

        vc.songNumber = selSong;
        
        vc.songsArray = self.parsedItems;
        
    }
}

-(void)segmentedControlAction:(id)sender{
    

        
        switch (self.segmentedControl.selectedSegmentIndex)
        {
            case 0:{
                
                NSLog(@"First selected");
                
                NSSortDescriptor *sortDescriptor;
                sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"prize"
                                                             ascending:YES];
                NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
                
                NSArray *sortedArray = [self.parsedItems sortedArrayUsingDescriptors:sortDescriptors];
                
                self.parsedItems = [NSMutableArray arrayWithArray:sortedArray];
                
                [self.tableView reloadData];
                
                break;
            }
            case 1:{
                
                NSLog(@"Second selected");
                
                NSSortDescriptor *sortDescriptor;
                sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"gender"
                                                             ascending:YES];
                NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
                
                NSArray *sortedArray = [self.parsedItems sortedArrayUsingDescriptors:sortDescriptors];
                
                self.parsedItems = [NSMutableArray arrayWithArray:sortedArray];
                
                [self.tableView reloadData];
                
                break;
 
            }
        }
    
    
}


@end
