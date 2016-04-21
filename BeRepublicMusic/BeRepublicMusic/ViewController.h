//
//  ViewController.h
//  BeRepublicMusic
//
//  Created by Juan Miguel Marqués Morilla on 22/1/16.
//  Copyright © 2016 Juan Miguel Marqués Morilla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (weak, nonatomic) IBOutlet UITableView *tableViewLocations;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)segmentedControlAction:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;


@end

