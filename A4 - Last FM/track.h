/****************************************************************
 FILE:      track.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  March 20, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
 the track class
 ****************************************************************/

#import <Foundation/Foundation.h>

@interface track : NSObject

@property (nonatomic, copy)NSString* name;          //name of artist
@property (nonatomic, copy)NSString* webSite;       //cartist's Last FM website
@property (nonatomic, copy)NSString* duration;         //artist image

@end
