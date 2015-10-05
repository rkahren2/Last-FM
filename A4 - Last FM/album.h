/****************************************************************
 FILE:      album.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  March 20, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
 the album class
 ****************************************************************/
#import <Foundation/Foundation.h>

@interface album : NSObject

@property (nonatomic, copy)NSString* name;          //name of album
@property (nonatomic, copy)NSString* mbid;          //Last FM id
@property (nonatomic, copy)NSString* rank;          //rank of album


@end
