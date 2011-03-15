//
//  FirstViewController.h
//  BodyMeter
//
//  Created by cgiufer on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {
	NSMutableArray *beats;
	double bpm;
	NSTimeInterval diff;
    int p;
	
	IBOutlet UIButton *tapHR;
	IBOutlet UILabel *bpmLabel;
    IBOutlet UISegmentedControl *fitness;
    IBOutlet UISegmentedControl *period;
    IBOutlet UILabel *coLabel;
	
}

@property (nonatomic, retain) IBOutlet UIButton *tapHR;
@property (nonatomic, retain) IBOutlet UILabel *bpmLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl *fitness;
@property (nonatomic, retain) IBOutlet UISegmentedControl *period;
@property (nonatomic, retain) IBOutlet UILabel *coLabel;

-(IBAction)beat;
-(IBAction)setCO;
-(IBAction)setPeriod;

-(NSTimeInterval)averageBeats;

//-(void)show;

@end
