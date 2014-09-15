//
//  MFViewController.h
//  MindFull
//
//  Created by Alan Hsu on 2014-04-25.
//  Copyright (c) 2014 alanhsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PebbleKit/PebbleKit.h>
#import "MFInputViewController.h"

@interface MFViewController : UIViewController <PBPebbleCentralDelegate>
- (IBAction)isPebbleConnected:(id)sender;
- (IBAction)resetRmrButtonClick:(id)sender;
@property PBWatch *connectedWatch;
@property (weak, nonatomic) IBOutlet UILabel *lblWatchConnection;
@property (weak, nonatomic) IBOutlet UILabel *lblCalCount;
@property int currentCalCount;
@property int netCal;

@end
