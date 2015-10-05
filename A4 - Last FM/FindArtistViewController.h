/****************************************************************
 FILE:      FindArtistViewController.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  March 20, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
 the FindArtistViewController class
 ****************************************************************/

#import <UIKit/UIKit.h>

@interface FindArtistViewController : UIViewController <NSXMLParserDelegate>

@property (strong, nonatomic)NSString *searchItem;                          //artist user entered
@property (nonatomic)NSMutableArray*  artistList;                           //list of simular artist

@property (weak, nonatomic) IBOutlet UITableView *artistTableView;          //table to display artist


@end
