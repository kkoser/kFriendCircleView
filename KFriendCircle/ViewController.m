//
//  ViewController.m
//  KFriendCircle
//
//  Created by Kyle Koser on 2/8/14.
//  Copyright (c) 2014 Kyle Koser. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.circle.showSelector = YES;
    [self.circle addUser:@"kkoser" withImage:[UIImage imageNamed:@"Checkmark.png"]];
    [self.circle addUser:@"kkoser" withImage:[UIImage imageNamed:@"Checkmark.png"]];
    [self.circle addUser:@"kkoser" withImage:[UIImage imageNamed:@"Checkmark.png"]];
    [self.circle addUser:@"kkoser" withImage:[UIImage imageNamed:@"Checkmark.png"]];
    [self.circle addUser:@"kkoser" withImage:[UIImage imageNamed:@"Checkmark.png"]];
    
    [self.circle animate];
    self.circle.selected = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
    [self.circle selectNextPosition:YES];
}
@end
