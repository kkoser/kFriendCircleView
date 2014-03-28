//
//  KFriendCircleView.h
//  KFriendCircle
//
//  Created by Kyle Koser on 2/8/14.
//  Copyright (c) 2014 Kyle Koser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface KFriendCircleView : UIView


@property(nonatomic, strong) NSArray *usernames;

@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSMutableArray *userLabels;

@property(nonatomic) BOOL showSelector;
@property(nonatomic) int selected;

@property (nonatomic, strong) UIImageView *selector;

- (id)initWithFrame:(CGRect)frame pictures:(NSArray *)pics usernames:(NSArray *)users;

- (void)addUser:(NSString *)user withImage:(UIImage *)img;
- (void)setSelected:(int)selected animated:(BOOL)animated;

- (void)animate;
- (void)selectNextPosition:(BOOL)animated;


@end
