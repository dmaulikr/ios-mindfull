//
//  MFSelectActivityViewController.h
//  MindFull
//
//  Created by Alan Hsu on 2014-05-24.
//  Copyright (c) 2014 alanhsu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MFSelectActivityViewController : UIViewController
- (IBAction)didSelectFood:(id)sender;
- (IBAction)didSelectExercise:(id)sender;

@property NSString *ActSelection;


@end
