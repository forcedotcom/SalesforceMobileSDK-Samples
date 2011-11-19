/*
 Copyright (c) 2011, salesforce.com, inc. All rights reserved.
 
 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY 
 */



#import "TrackDetailsViewController.h"


@implementation TrackDetailsViewController
@synthesize lblPrice;
@synthesize lblDescription;
@synthesize tblTracks;
@synthesize tracksSpinner;

@synthesize theAlbumId;
@synthesize theAlbumPrice;
@synthesize theAlbumDescription;
@synthesize theAlbumTitle; 
@synthesize tracks;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil albumId:(NSString *)albumId albumTitle:(NSString *)albumTitle;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		theAlbumId = albumId;
        theAlbumTitle = albumTitle;
		self.title = theAlbumTitle;
		
        NSString *queryString =  [NSString stringWithFormat:@"%@%@%@", 
                                  @"select Name, Released_On__c, Description__c, Price__c, (select name, price__c from Tracks__r) from Album__c where id = '", theAlbumId,@"'"];
        
        SFRestRequest *request;
        request = [[SFRestAPI sharedInstance] requestForQuery:queryString];
        
        [[SFRestAPI sharedInstance] send:request delegate:self];
    }
    return self;
}

- (void)dealloc
{
	[lblPrice release];
	[lblDescription release];
	[tblTracks release];
	[tracksSpinner release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	[self setLblPrice:nil];
	[self setLblDescription:nil];
	[self setTblTracks:nil];
	[self setTracksSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)response {
    
	NSMutableArray *allDetails = [response objectForKey:@"records"];
	
    //database.com returns additional information such as attributes and number of results
    //we want the actual response...
    NSDictionary *results = [allDetails objectAtIndex:0];
	
    
	//payload is returned as JSON. If the value of a textfield is null, Objective-C will represent this as a NSNull object.
	//Printing it to the console will show as "<null>". 
	//This is different from nil,so let's check for NSNull
    
	theAlbumDescription = [results objectForKey:@"Description__c"];
    if ([theAlbumDescription isEqual:[NSNull null]]) {
		[lblDescription setText:@"No description available"];
	}
	else {
		[lblDescription setText:theAlbumDescription];
    }
	
    theAlbumPrice = [results objectForKey:@"Price__c"];
	
	//if (theAlbumPrice == 0) {
	//	[lblPrice setText:@"Free!"];
	//}
	[lblPrice setText:[NSString stringWithFormat:@"$%@", theAlbumPrice]];
	
    
   NSDictionary *allTracks =[results objectForKey:@"Tracks__r"];
    
	if (![allTracks isEqual:[NSNull null]]) {
		self.tracks = [allTracks objectForKey:@"records"];
		[self.tracksSpinner reloadAllComponents];
	}
}

- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    
    //here is a sample of handling errors neatly.
    NSLog(@"RootViewController:didFailWithError: %@", error);
    
    // show alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Database.com Error" 
                                                    message:[NSString stringWithFormat:@"Problem retrieving data %@", error]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}


#pragma mark pickerview delegate events

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return [self.tracks count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	NSDictionary *obj = [tracks objectAtIndex:row];
    return [obj objectForKey:@"Name"];

}

@end
