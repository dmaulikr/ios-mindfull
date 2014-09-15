//
//  MFViewController.m
//  MindFull
//
//  Created by Alan Hsu on 2014-04-25.
//  Copyright (c) 2014 alanhsu. All rights reserved.
//

#import "MFViewController.h"

@interface MFViewController ()

@end

@implementation MFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [[PBPebbleCentral defaultCentral] setDelegate:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    //load calorie data
    self.currentCalCount = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"calorieCount"];
    double currentRMR =  [[NSUserDefaults standardUserDefaults] doubleForKey:@"myRMR"];
    
    self.netCal = (int)(currentRMR + self.currentCalCount);
    
    [self.lblCalCount setText: [NSString stringWithFormat:@"%d",self.netCal]];
    
    //set font colour
    /*
    if (self.netCal < 0) {
        self.lblCalCount.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    }
    else{
        self.lblCalCount.textColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:1];
    }
    */
    
    //recognize double tap gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    self.lblCalCount.userInteractionEnabled = YES;
    [self.lblCalCount addGestureRecognizer:tapGesture];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)isPebbleConnected:(id)sender {
    
    [self.lblWatchConnection setHidden:false];
    
   /* NSString *pebbleConnection;
    
    NSArray *connectedWatches = [[PBPebbleCentral defaultCentral] connectedWatches];
    
    if ([connectedWatches count] > 0) {
        self.connectedWatch = [connectedWatches objectAtIndex:0];
        
        if ([self.connectedWatch isConnected] == 1) {
            pebbleConnection = [NSString stringWithFormat:@" %@ is connected.", [self.connectedWatch name]];
        }
        else{
            pebbleConnection = [NSString stringWithFormat:@" No Pebble watch is connected."];
        }
    }
    else{
        pebbleConnection = [NSString stringWithFormat:@" No Pebble watch is connected."];
    }
    
    //print results
    [self.lblWatchConnection setText:pebbleConnection];*/
}
- (void)pebbleCentral:(PBPebbleCentral*)central watchDidConnect:(PBWatch*)watch isNew:(BOOL)isNew {
    self.connectedWatch = watch;
}

- (void)pebbleCentral:(PBPebbleCentral*)central watchDidDisconnect:(PBWatch*)watch {
    
    if (self.connectedWatch == watch || [watch isEqual:self.connectedWatch]) {
        self.connectedWatch = nil;
    }
}
- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateRecognized) {
        
        //setup pebble app to communicate with
        uuid_t myAppUUIDbytes;
        NSUUID *myAppUUID = [[NSUUID alloc] initWithUUIDString:@"1f4b57b4-87bf-4cb1-885f-301739d48d9b"];
        [myAppUUID getUUIDBytes:myAppUUIDbytes];
        [[PBPebbleCentral defaultCentral] setAppUUID:[NSData dataWithBytes:myAppUUIDbytes length:16]];
        
        NSArray *connectedWatches =[[PBPebbleCentral defaultCentral] connectedWatches];
        
        if ([connectedWatches count] > 0) {
            self.connectedWatch = [[[PBPebbleCentral defaultCentral] connectedWatches] objectAtIndex:0];
            NSString *myWatch = [self.connectedWatch name];
            NSLog(@"Connected watch: %@",myWatch);
            NSLog(@"is watch connected: %d",[self.connectedWatch isConnected]);
            
            
            //launch app
            [self.connectedWatch appMessagesLaunch:^(PBWatch *watch, NSError *error) {
                if (!error) {
                    NSLog(@"Successfully launched app.");
                }
                else {
                    NSLog(@"Error launching app - Error: %@", error);
                }
            }
             ];
            
        }
        else{
            NSLog(@"no connected watches");
        }
        
        //send message
        NSString *calString = [NSString stringWithFormat:@"%d",self.netCal];
        NSDictionary *update = @{ @(0):calString};
        [self.connectedWatch appMessagesPushUpdate:update onSent:^(PBWatch *watch, NSDictionary *update, NSError *error) {
            if (!error) {
                self.lblWatchConnection.text = @"Sent to Pebble!";
                NSLog(@"Successfully sent message.");
            }
            else {
                self.lblWatchConnection.text = @"Error sending to Pebble.";
                NSLog(@"Error sending message: %@", error);
            }
        }];
    }
}
- (IBAction)resetRmrButtonClick:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to reset your RMR? This cannot be undone." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"Cancel", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [self resetRMR];
    }
}
- (void) resetRMR{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    double RMRvalue  = [[NSUserDefaults standardUserDefaults] doubleForKey:@"myRMR"];
    [userDefaults setDouble:RMRvalue forKey:@"myRMR"];
    [userDefaults setDouble:0.0 forKey:@"calorieCount"];
    self.netCal = RMRvalue;
    [userDefaults synchronize];

    self.lblCalCount.text = [NSString stringWithFormat:@"%d",(int)RMRvalue];
}
@end
