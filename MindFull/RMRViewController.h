//
//  RMRViewController.h
//  MindFull
//
//  Created by Alan Hsu on 2014-04-26.
//  Copyright (c) 2014 alanhsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMRViewController : UIViewController <UITextFieldDelegate>
- (IBAction)finishRmrInput:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtHeight;
@property (weak, nonatomic) IBOutlet UITextField *txtWeight;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cmbGender;
@end
