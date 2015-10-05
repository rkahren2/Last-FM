/****************************************************************
 FILE:      ArtistTableCellView.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  March 20, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
 the ArtistTableCellView class
 ****************************************************************/

#import <UIKit/UIKit.h>

@interface FindAlbumViewController : UIViewController <NSXMLParserDelegate>

@property (strong, nonatomic)NSString *searchItem;                          //artist to get albums for
@property (nonatomic)NSMutableArray*  albumList;                            //list of albums

@property (weak, nonatomic) IBOutlet UITableView *albumTableView;           //table  of albums

@end
