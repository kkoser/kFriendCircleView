//
//  KFriendCircleView.m
//  KFriendCircle
//
//  Created by Kyle Koser on 2/8/14.
//  Copyright (c) 2014 Kyle Koser. All rights reserved.
//

#import "KFriendCircleView.h"

@implementation KFriendCircleView

- (id)initWithFrame:(CGRect)frame pictures:(NSArray *)pics usernames:(NSArray *)users {
    if (self = [self initWithFrame:frame]) {
        
        self.imageViews = [NSMutableArray array];
        self.userLabels = [NSMutableArray array];
        //add the imageViews here, then layout in layoutSubviews
        for (UIImage *img in pics) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/10, frame.size.height/10)];
            imgView.image = img;
            [imgView setContentMode:UIViewContentModeScaleToFill];
            [self addSubview:imgView];
            [self.imageViews addObject:imgView];
            
            
        }
        
        for (NSString *name in users) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
            label.text = name;
            label.adjustsFontSizeToFitWidth = YES;
            [self.userLabels addObject:label];
        }
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageViews = [NSMutableArray array];
        self.userLabels = [NSMutableArray array];
        // Initialization code
        
        self.selector = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selector.png"]];
        [self addSubview:self.selector];

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        self.imageViews = [NSMutableArray array];
        self.userLabels = [NSMutableArray array];
        self.selector = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selector.png"]];
        [self addSubview:self.selector];
        //self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

- (void)addUser:(NSString *)user withImage:(UIImage *)img {
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [imgView setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:imgView];
    [self.imageViews addObject:imgView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    label.text = user;
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    [self.userLabels addObject:label];
    
    
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

//from http://stackoverflow.com/questions/12825356/rotate-a-uiview-clockwise-for-an-angle-greater-than-180-degrees
//thanks Martin R!
- (void) rotateViewAnimated:(UIView*)view
               withDuration:(CFTimeInterval)duration
                    byAngle:(CGFloat)angle
{
    [CATransaction begin];
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.byValue = [NSNumber numberWithFloat:angle];
    rotationAnimation.duration = duration;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    [CATransaction setCompletionBlock:^{
        view.transform = CGAffineTransformRotate(view.transform, angle);
        // added by me
        [view.layer removeAllAnimations]; // this is important
    }];
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [CATransaction commit];
}

- (void)setSelected:(int)selected animated:(BOOL)animated {
    //do this before the new selected is set to the property so that we can compare
    if (animated) {
        //animate the selected bar to the new pos
        [self animateSelectorToPos:selected];
    }
    
    _selected = selected;
    
}

- (void)animateSelectorToPos:(int)pos {
    
    float bigR = self.frame.size.height/2;
    
    float oldT = (2*M_PI/(float)[self.imageViews count]);
    oldT *= self.selected;
    oldT -= M_PI/2;
    
    float newT = (2*M_PI/(float)[self.imageViews count]);
    newT *= pos;
    newT -= M_PI/2;
    
    //make moving further along the circle take longer
    //float dur = 2.0/(float)([self.imageViews count]);
    float dur = 1.0f;
    //dur*= 4;
    
    CGMutablePathRef path = CGPathCreateMutable();
    //CGPathMoveToPoint(path, NULL, self.selector.center.x, self.selector.center.y);
    
    //create animation arc for selector to follow
    CGPathAddArc(path, NULL, bigR, bigR, .45*bigR, oldT, newT, NO);
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [anim setPath:path];
    [anim setDuration:dur];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    anim.repeatCount = 1;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = YES;
    [self.selector.layer addAnimation:anim forKey:@"rotateArc"];
    
    //now rotate the actual selector
    float rot = (2*M_PI/(float)[self.imageViews count]);
    rot*=pos;
    
    rot = rot == 0.0 ? 2*M_PI : rot;
    
    CGFloat radians = (2*M_PI/(float)[self.imageViews count]);
    radians *= self.selected;
    
    [self rotateViewAnimated:self.selector withDuration:.8*dur byAngle:rot-radians];
    
    
    //now set the final position
    float cx = bigR + .45*bigR*sin(rot);
    float cy = bigR - .45*bigR*cos(rot);

    self.selector.center = CGPointMake(cx, cy);

}



- (void)animate {
    
    for (UIView *pic in self.imageViews) {
        pic.alpha = 0.0;
    }
    for (UIView *lab in self.userLabels) {
        lab.alpha = 0.0;
    }
    
    self.selector.alpha = 0.0;
    
    for(int i = 0; i < [self.imageViews count]; i++) {
        [self performSelector:@selector(fadeInView:) withObject:[self.imageViews objectAtIndex:i] afterDelay:.2*i];
        [self performSelector:@selector(fadeInView:) withObject:[self.userLabels objectAtIndex:i] afterDelay:.2*i];
    }
    
    [self performSelector:@selector(fadeInView:) withObject:self.selector afterDelay:.2*[self.imageViews count]];
}

- (void)fadeInView:(UIView *)v {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 0.2;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.autoreverses = NO;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.4];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    [v.layer addAnimation:scaleAnimation forKey:@"scale"];
    [UIView animateWithDuration:0.2 animations:^{
        v.alpha = 1.0;
    }];
}

- (void)selectNextPosition:(BOOL)animated {
    int newSel = self.selected + 1;
    newSel = newSel > [self.imageViews count]-1 ? 0 : newSel;
    [self setSelected:newSel animated:animated];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float degOffset = 2.0*M_PI/(float)[self.imageViews count];
    float r = self.frame.size.height/4.0;
    float bigR = self.frame.size.height/2;
    for (int i = 0; i < [self.imageViews count]; i++) {
        float t = -degOffset*i - M_PI;
        float cx =(bigR-r/2.0) + bigR*sin(t);
        float cy = (bigR-r/2.0) + bigR*cos(t);
        UIImageView *imgView = [self.imageViews objectAtIndex:i];
        imgView.frame = CGRectMake(cx, cy, r, r);
        imgView.layer.cornerRadius = r/2;
        imgView.layer.borderColor = [[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:.5] CGColor];
        imgView.layer.borderWidth = 1.0f;
        imgView.backgroundColor = [UIColor whiteColor];
        imgView.layer.masksToBounds = YES;
        imgView.clipsToBounds = YES;
        
        //now do the labels
        UILabel *lab = [self.userLabels objectAtIndex:i];
        lab.frame = CGRectMake(cx-.25*r, cy-.5*r, 1.5*r, r/2.0);
        lab.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:.5];
    }
    
    if(self.showSelector) {
        float rot = (2*M_PI/(float)[self.imageViews count]);
        rot*=self.selected;
        CGAffineTransform rotate = CGAffineTransformMakeRotation(rot);
        float cx = bigR + .45*bigR*sin(rot);
        float cy = bigR - .45*bigR*cos(rot);
        self.selector.center = CGPointMake(cx, cy);
        self.selector.transform = rotate;
        
    }
    else {
        self.selector.hidden = YES;
    }
}

//overriden to draw the main circle in code -- more efficient/flexible
- (void)drawRect:(CGRect)rect
{
    
    //draw the main circle first
    CGRect borderRect = CGRectMake(2, 2, self.frame.size.width-3, self.frame.size.height-3);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,105.0/255.0, 105.0/255.0, 102.0/255.0, .5);
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.0);
    CGContextSetLineWidth(context, 3.0);
    CGContextStrokeEllipseInRect(context, borderRect);
    
}


@end
