//
//  RMRViewController.m
//  MindFull
//
//  Created by Alan Hsu on 2014-04-26.
//  Copyright (c) 2014 alanhsu. All rights reserved.
//

#import "RMRViewController.h"

@interface RMRViewController ()

@end

@implementation RMRViewController

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
    
    
    //set delegates
    self.txtHeight.delegate = self;
    self.txtWeight.delegate = self;
    self.txtAge.delegate = self;

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

- (IBAction)finishRmrInput:(id)sender {
    
    double height = [self.txtHeight.text doubleValue];
    double weight = [self.txtWeight.text doubleValue] * 0.453592;
    int age = [self.txtAge.text intValue];
    
    if(height == 0 || weight == 0 || age == 0){
        NSLog(@"all values must be entered");
    }
    else{
        NSString *selectedGender = [self.cmbGender titleForSegmentAtIndex:self.cmbGender.selectedSegmentIndex];
        
        double myRMR = 0.0;
        
        if ([selectedGender isEqualToString:@"Male"]) {
            myRMR =  ((10 * weight) + (6.25 * height) - (5 * age) + 5);
        }
        else if([selectedGender isEqualToString:@"Female"]){
            myRMR =  ((10 * weight) + (6.25 * height) - (5 * age) - 161);
        }
        else{
            NSLog(@"invalid selection");
        }
        
        
        NSLog(@"%f",myRMR);
        
        //store new values
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setDouble:myRMR forKey:@"myRMR"];
        [userDefaults synchronize];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtHeight) {
        [self.txtWeight becomeFirstResponder];
    }
    else if(textField == self.txtWeight){
        [self.txtAge becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
    
    
    return YES;
}
@end
