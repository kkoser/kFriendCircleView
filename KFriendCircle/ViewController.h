//
//  ViewController.h
//  KFriendCircle
//
//  Created by Kyle Koser on 2/8/14.
//  Copyright (c) 2014 Kyle Koser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFriendCircleView.h"

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet KFriendCircleView *circle;
- (IBAction)play:(id)sender;

@end
