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




#import <UIKit/UIKit.h>
#import "SFRestAPI.h"


/**
 This class is a details view implementation of the Mobile SDK workbook Tutorial, Cloud Tunes
 It contains additional examples of using nested queries and looping through the results
 returned from Database.com and Force.com
 To 'enable' this details view, you can uncomment out the initialization steps in RootViewController
 */
@interface TrackDetailsViewController : UIViewController <SFRestDelegate, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    
	NSString *theAlbumId;
    NSString *theAlbumTitle;
	NSMutableArray *tracks;
    NSString *theAlbumDescription;
    NSString *theAlbumPrice;
	
	UILabel *lblPrice;
	UILabel *lblDescription;
	UITableView *tblTracks;
	UIPickerView *tracksSpinner;
}

@property(nonatomic, retain) NSString *theAlbumId;
@property(nonatomic, retain) NSString *theAlbumTitle; 
@property(nonatomic, retain) NSString *theAlbumDescription;
@property(nonatomic, retain) NSString *theAlbumPrice;
@property (nonatomic, retain) NSMutableArray *tracks;


//custom init method that allows us to pass in the album id to be loaded
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil albumId:(NSString *)albumId albumTitle:(NSString *)albumTitle;

@property (nonatomic, retain) IBOutlet UILabel *lblPrice;
@property (nonatomic, retain) IBOutlet UILabel *lblDescription;
@property (nonatomic, retain) IBOutlet UITableView *tblTracks;
@property (nonatomic, retain) IBOutlet UIPickerView *tracksSpinner;

@end
