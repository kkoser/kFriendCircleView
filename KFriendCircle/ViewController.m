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
	// Do any additional setup after loading the view, typically from a nib.
    NSString *requestString = @"http://graph.facebook.com/1187428299/picture?type=large";
    NSURL *url = [NSURL URLWithString:requestString];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];

    self.circle.showSelector = YES;
    [self.circle addUser:@"kkoser" withImage:[UIImage imageNamed:@"Checkmark.png"]];
    [self.circle addUser:@"kkoser" withImage:[UIImage imageNamed:@"Checkmark.png"]];
    //[self.circle addUser:@"Test" withImage:[UIImage imageNamed:@"Checkmark.png"]];
    //[self.circle addUser:@"Test" withImage:[UIImage imageNamed:@"Checkmark.png"]];
    //[self.circle addUser:@"trackstar192" withImage:[UIImage imageNamed:@"Checkmark.png"]];
    
    [self.circle animate];
    //[self.circle setSelected:0 animated:YES];
    self.circle.selected = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_circle release];
    [super dealloc];
}
- (IBAction)play:(id)sender {
    //int newPos = self.circle.selected >= 2 ? 0 : self.circle.selected+1;
    //[self.circle setSelected:newPos animated:YES];
    [self.circle selectNextPosition:YES];
}
@end
