//
//  MFSelectActivityViewController.m
//  MindFull
//
//  Created by Alan Hsu on 2014-05-24.
//  Copyright (c) 2014 alanhsu. All rights reserved.
//

#import "MFSelectActivityViewController.h"
#import "MFInputViewController.h"


@interface MFSelectActivityViewController ()

@end

@implementation MFSelectActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didSelectFood:(id)sender {
    self.ActSelection = @"food";
}

- (IBAction)didSelectExercise:(id)sender {
    self.ActSelection = @"exercise";
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"segueFoodSelection"] || [[segue identifier] isEqualToString:@"segueExerciseSelection"])
    {
        // Get reference to the destination view controller
        MFInputViewController *vc = [segue destinationViewController];
        
        // Pass object to next view
        [vc setActSelection:self.ActSelection];
    }
}
@end
