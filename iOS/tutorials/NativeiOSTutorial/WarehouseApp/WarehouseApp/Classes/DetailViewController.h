//
//  DetailViewController.h
//  WarehouseApp
//
//  Created by Kevin Hawkins on 8/30/13.
//  Copyright (c) 2013 Sample Apps from Salesforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"

@interface DetailViewController : UIViewController <SFRestDelegate>
{
    __weak IBOutlet UITextField *_priceField;
    __weak IBOutlet UITextField *_quantityField;
    __weak IBOutlet UILabel *_nameLabel;
    
}

@property (nonatomic, strong) NSNumber *quantityData;
@property (nonatomic, strong) NSNumber *priceData;
@property (nonatomic, strong) NSString *nameData;
@property (nonatomic, strong) NSString *idData;

- (id)initWithName:(NSString *)recordName
         sobjectId:(NSString *)salesforceId
          quantity:(NSNumber *)recordQuantity
             price:(NSNumber *)recordPrice;

- (void)updateWithObjectType:(NSString *)objectType
                    objectId:(NSString *)objectId
                    quantity:(NSString *)quantity
                       price:(NSString *)price;

- (IBAction)updateTouchUpInside:(id)sender;

- (void)hideKeyboard;

@end
