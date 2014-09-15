//
//  MFInputViewController.h
//  MindFull
//
//  Created by Alan Hsu on 2014-04-27.
//  Copyright (c) 2014 alanhsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFInputViewController : UIViewController <UITextFieldDelegate>
- (IBAction)storeValue:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtCalValue;

@property NSString *actSelection;
@property (weak, nonatomic) IBOutlet UIImageView *actImg;

@end
