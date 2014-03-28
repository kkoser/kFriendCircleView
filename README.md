kFriendCircleView
=================

An iOS View to help cleanly display a group of friends in a flat style. Note that this currently does NOT use ARC

How to Use:

1. Create a KFRiendCircleView, either in IB or in code using initWithFrame:Pictures:Usernames:
2. (Mainly for use in IB) add more users using addUser: withImage:
3. Set the selected user
4. DONE!

Ex:

in ViewController.h:

    @property (retain, nonatomic) IBOutlet KFriendCircleView *circle;

in viewController.m:

    //set to show the triangular selector below the selected user
    self.circle.showSelector = YES;
    
    //add users
    [self.circle addUser:@"kkoser" withImage:[UIImage imageNamed:@"Test.png"]];
    [self.circle addUser:@"kkoser" withImage:[UIImage imageNamed:@"Test.png"]];
    
    [self.circle animate]; //this animates in all of the images from a blank view
    self.circle.selected = 0; //set the selected
