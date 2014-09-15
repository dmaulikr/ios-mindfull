//
//  MFInputViewController.m
//  MindFull
//
//  Created by Alan Hsu on 2014-04-27.
//  Copyright (c) 2014 alanhsu. All rights reserved.
//

#import "MFInputViewController.h"

@interface MFInputViewController ()

@end

@implementation MFInputViewController

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
    
    [[self.navigationController navigationBar] setTintColor:[UIColor whiteColor]];
    
    NSLog(@"passed from previous view controller: %@",self.actSelection);
    
    [self.txtCalValue becomeFirstResponder];
    
    NSLog(@"%d",(int)[[NSUserDefaults standardUserDefaults] doubleForKey:@"calorieCount"]);
    
    if ([self.actSelection isEqualToString:@"exercise"]) { //exercise you add
        [self.actImg setImage: [UIImage imageNamed:@"icon_bolt.png"]];
    }
    else{
        [self.actImg setImage: [UIImage imageNamed:@"icon_bowl.png"]];
    }
    
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

- (IBAction)storeValue:(id)sender {
    
    
    //get previous values
    double currentCalCount =  (int)[[NSUserDefaults standardUserDefaults] doubleForKey:@"calorieCount"];
    double newCalCount;

    if ([self.actSelection isEqualToString:@"exercise"]) { //exercise you add
         newCalCount = currentCalCount + [[self.txtCalValue text] doubleValue];
    }
    else //food you minus
        newCalCount = currentCalCount - [[self.txtCalValue text] doubleValue];
    
    
    NSLog(@"%f",newCalCount);
    
    //store new values
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:newCalCount forKey:@"calorieCount"];
    [userDefaults synchronize];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 4) ? NO : YES;
}
@end










