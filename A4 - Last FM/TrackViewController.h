/****************************************************************
 FILE:      TrackViewController.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  March 20, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
 the TrackViewController class
 ****************************************************************/
#import <UIKit/UIKit.h>

@class album;

@interface TrackViewController : UIViewController <NSXMLParserDelegate>

@property (strong, nonatomic)album *searchItem;
@property (nonatomic)NSMutableArray*  trackList;

@property (weak, nonatomic) IBOutlet UITableView *trackTableView;


@end
