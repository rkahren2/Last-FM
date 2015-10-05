/****************************************************************
 FILE:      artist.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  March 20, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
 the artist class
 ****************************************************************/
#import <Foundation/Foundation.h>

@interface artist : NSObject

@property (nonatomic, copy)NSString* name;          //name of artist
@property (nonatomic, copy)NSString* webSite;       //artist's Last FM website
@property (nonatomic, copy)NSString* image;         //artist image

@end
