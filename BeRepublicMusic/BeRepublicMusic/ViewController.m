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

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *parsedItems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.segmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)searchButtonAction:(id)sender {
    
    [self.segmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
    
    if ([self.textField.text length]==0) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Ooops!"                                                  message:NSLocalizedString(@"You have to enter some word", @"")
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelButton = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                           
                                       }];
        
        [alert addAction:cancelButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    [self loadDataWithString:self.textField.text];
    
    
}



-(void)loadDataWithString: (NSString*)queryText{

    
    
    [SVProgressHUD showWithStatus:@"Cargando" maskType:SVProgressHUDMaskTypeGradient];
    
    self.parsedItems = [NSMutableArray array];
    
    [[MMAPI sharedInstance]queryWithString:queryText completionBlock:^(NSArray *JSONArray, NSError *error) {
        
        
        if (!error) {
            
            if ([[JSONArray valueForKey:@"results"] count]==0 || JSONArray == nil) {
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Ooops!"                                                  message:NSLocalizedString(@"Something goes wrong. Please search another", @"")
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelButton = [UIAlertAction
                                               actionWithTitle:@"Ok"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                                               {
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                   
                                               }];
                
                [alert addAction:cancelButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
            }else{
                
                for (id item in [JSONArray valueForKey:@"results"]) {
                    
                    if ([item isKindOfClass:[NSDictionary class]]) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            MMAlbumObject *place = [[MMAlbumObject alloc] initWithDictionary:item];
                            
                            [self.parsedItems addObject:place];
                            
                            [self.tableView reloadData];
                            
                            
                        });
                        
                    }
                }
                
            }
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
        });
        
    }];
    
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
    
    
    MMAlbumObject *album = [self.parsedItems objectAtIndex:indexPath.row];
    cell.title.text =  album.title;
    cell.artist.text = album.artist;
    cell.gender.text = album.gender;
    cell.prize.text = [NSString stringWithFormat:@"%.02f",album.prize];
    
    [cell.imageAlbum sd_setImageWithURL:[NSURL URLWithString:album.imageAlbum] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
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
