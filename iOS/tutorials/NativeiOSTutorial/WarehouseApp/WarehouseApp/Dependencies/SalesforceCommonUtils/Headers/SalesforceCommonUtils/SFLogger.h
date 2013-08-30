//
//  SFLogger.h
//  SalesforceCommonUtils
//
//  Copyright (c) 2012 salesforce.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum SFLogLevel {
	SFLogLevelDebug,
	SFLogLevelInfo,
	SFLogLevelWarning,
	SFLogLevelError,
} SFLogLevel;

typedef void (^SFLogBlock) (NSString *msg);

#define SFLogAssert(_cond, _desc, ...) \
do { \
if (!(_cond)) { \
[SFLogger logAssertionFailureInMethod:_cmd object:(self) file:[NSString stringWithUTF8String:__FILE__] lineNumber:__LINE__ description:(_desc), ##__VA_ARGS__]; \
} \
} while (0) \


/*!
 Allows your class to log messages specific to that class.
 You should be able to use this 99% of the time.
 */
@interface NSObject (SFLogging)
/**
 * Logs a message with the given level.
 * @param level The minimum log level to log at.
 * @param msg The message to log.
 */
-(void)log:(SFLogLevel)level msg:(NSString *)msg;

/**
 * Logs a formatted message with the given log level and format parameters.
 * @param level The minimum log level to log at.
 * @param msg The format message, and optional arguments to expand in the format.
 * @param ... The arguments to the message format string.
 */
-(void)log:(SFLogLevel)level format:(NSString *)msg, ...;

@end


/*!
 Generic logging utility: logs to both console and persistent file.
 */
@interface SFLogger : NSObject {
	SFLogLevel		logLevel;
}

/**
 * The current log level of the app.
 */
+ (SFLogLevel)logLevel;

/** Turn on and off for logging to a file
 @param logToFile Yes to log to file. Set to NO will turn off logging to file and also remove existing logging file
 */
+ (void)logToFile:(BOOL)logToFile;

/**
 * Sets the log level of the app.
 * @param newLevel The new log level to configure.
 */
+ (void)setLogLevel:(SFLogLevel)newLevel;


/** Get access to the content of the application log file.
 */
+ (NSString *)logFileContents;

/**
 * Logs at the Class level.  Should only be used if you don't have an NSObject instance to
 * log from.
 * @param cls The class associated with the log event.
 * @param level The level to log at.
 * @param msg The message to log.
 */
+ (void)log:(Class)cls level:(SFLogLevel)level msg:(NSString *)msg;

/**
 * Logs an assertion failure to a file.
 * @param method The method where the assertion failure occurred.
 * @param obj The object where the assertion failure occurred.
 * @param file The file to log to.
 * @param line The line number of the failure.
 * @param desc The formatted description to log.
 * @param ... The format arguments of the description.
 */
+ (void)logAssertionFailureInMethod:(SEL)method object:(id)obj file:(NSString *)file lineNumber:(NSUInteger)line description:(NSString *)desc, ...;

/**
 * Logs a formatted message with the given log level and format parameters.
 * @param cls The class associated with the log event.
 * @param level The minimum log level to log at.
 * @param msg The format message, and optional arguments to expand in the format.
 * @param ... The arguments to the message format string.
 */
+ (void)log:(Class)cls level:(SFLogLevel)level format:(NSString *)msg, ...;

/*!
 Sets the log level based on the user preferences.
 */
+ (void)applyLogLevelFromPreferences;


/**
 Use this method to enable the recording of the assertion instead of aborting the
 program when an assertion is triggered. This is usually used by the
 unit tests.
 @param enabled Whether or not to enable assertion recording.
 */
+ (void)setRecordAssertionEnabled:(BOOL)enabled;

/**
 Returns YES if an assertion was recorded and clear the flag.
 @return YES if an assertion was recorded, NO otherwise.
 */
+ (BOOL)assertionRecordedAndClear;

@end
