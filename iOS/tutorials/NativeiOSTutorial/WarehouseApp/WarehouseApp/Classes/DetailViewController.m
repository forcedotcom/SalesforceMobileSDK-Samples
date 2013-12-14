//
//  DetailViewController.m
//  WarehouseApp
//
//  Created by Kevin Hawkins on 8/30/13.
//  Copyright (c) 2013 Sample Apps from Salesforce. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize nameData;
@synthesize quantityData;
@synthesize priceData;
@synthesize idData;

- (id)initWithName:(NSString *)recordName
         sobjectId:(NSString *)salesforceId
          quantity:(NSNumber *)recordQuantity
             price:(NSNumber *)recordPrice
{
    self = [super init];
    if (self) {
        self.nameData = recordName;
        self.idData = salesforceId;
        self.quantityData = recordQuantity;
        self.priceData = recordPrice;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_nameLabel setText:self.nameData];
    [_quantityField setText:[self.quantityData stringValue]];
    [_priceField setText:[self.priceData stringValue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateTouchUpInside:(id)sender
{
    [self updateWithObjectType:@"Merchandise__c"
                      objectId:self.idData
                      quantity:[_quantityField text]
                         price:[_priceField text]];
}

- (void)updateWithObjectType:(NSString *)objectType
                    objectId:(NSString *)objectId
                    quantity:(NSString *)quantity
                       price:(NSString *)price
{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            quantity, @"Quantity__c",
                            price, @"Price__c",
                            nil];
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForUpdateWithObjectType:objectType
                                                                               objectId:objectId
                                                                                 fields:fields];
    [[SFRestAPI sharedInstance] send:request delegate:self];
}

#pragma mark - Hide keyboard methods

- (void)hideKeyboard
{
    [_quantityField resignFirstResponder];
    [_priceField resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideKeyboard];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - SFRestDelegate methods

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"1 record updated");
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    NSLog(@"request:didFailLoadWithError: %@", error);
    //add your failed error handling here
}

- (void)requestDidCancelLoad:(SFRestRequest *)request {
    NSLog(@"requestDidCancelLoad: %@", request);
    //add your failed error handling here
}

- (void)requestDidTimeout:(SFRestRequest *)request {
    NSLog(@"requestDidTimeout: %@", request);
    //add your failed error handling here
}

@end
