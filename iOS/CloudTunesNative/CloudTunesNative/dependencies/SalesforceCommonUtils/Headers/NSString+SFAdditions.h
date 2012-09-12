//
//  NSString+SFAdditions.h
//  SalesforceCommonUtils
//
//  Created by Amol Prabhu on 1/9/12.
//  Copyright (c) 2012 salesforce.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**Extension to NSString object
 */
@interface NSString (SFAdditions)

/** Returns a string representation of the supplied hex data
 
 @param data NSData to convert to string
 Returns nil if data is nil.
 */
+ (NSString *)stringWithHexData:(NSData *)data;

/** Returns an SHA 256 hash of the current string
 */
- (NSData *)sha256;

/**Escape XML entities
 */
- (NSString *)escapeXMLEntities;

/**Trim string by taking out beginning and ending space*/
- (NSString *)trim;

/*Return YES of string is nil or length is 0 or with white space only
 
 @param string String to check
 */
+ (BOOL)isEmpty:(NSString *)string;

@end
