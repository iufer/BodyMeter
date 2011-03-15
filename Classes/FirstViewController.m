//
//  FirstViewController.m
//  BodyMeter
//
//  Created by cgiufer on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController

@synthesize tapHR, bpmLabel, fitness, period, coLabel;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	beats = [[NSMutableArray alloc] init];
	bpm = 0.0;
    p = 1;
}

-(void)beat {
	NSDate *now = [NSDate date];
	[beats insertObject:now atIndex:0];
	
	if ([beats count] > 4) {
		[beats removeLastObject];
	}
	else if ([beats count] < 2) {
		return;
	}
	
	if ([beats count] > 1 && [[beats objectAtIndex:0] timeIntervalSinceDate:[beats objectAtIndex:1]] > 2 ) {
		[beats removeAllObjects];
		[beats insertObject:now atIndex:0];
		return;
	}
	
	
	diff = [self averageBeats];
	
	bpm = 60 / diff;
	//
	[tapHR setTitle:[NSString stringWithFormat:@"Heart Rate: %1.1f", bpm] forState:UIControlStateNormal];
    
    [self setCO];    
}

-(NSTimeInterval)averageBeats {
	//NSLog(@"%d, %d , %d",[beats count], [beats objectAtIndex:0], [beats objectAtIndex:1]);
	
	double a = 0.0;
	for (int i=0; i < [beats count]-1; i++) {
			a = a + [[beats objectAtIndex:i] timeIntervalSinceDate:[beats objectAtIndex:i+1]];
	}
	return a / ([beats count] - 1);
}

-(void)setCO {
    int i = fitness.selectedSegmentIndex;
    double sv = 0.0;
    
    if(i == 0) sv = 60.0;
    if(i == 1) sv = 80.0;
    if(i == 2) sv = 100.0;
    
    // calculate the Cardiac Output
    double q = ((bpm * sv)/1000 ) * p;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:1];
    
    //[bpmLabel setText:[NSString stringWithFormat:@"%1.1f", q]];
    [bpmLabel setText:[formatter stringFromNumber:[NSNumber numberWithDouble:q]]];
    
    [formatter release];
}

-(void)setPeriod{
    // mod the label
    int i = period.selectedSegmentIndex;
    if (i == 0) { [coLabel setText: @"L/min"]; p = 1; }
    if (i == 1) { [coLabel setText: @"L/hr"]; p = 60; }
    if (i == 2) { [coLabel setText: @"L/month"]; p = 60 * 720; }
    if (i == 3) { [coLabel setText: @"L/yr"]; p = 60 * 720 * 12; }
    
    [self setCO];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
