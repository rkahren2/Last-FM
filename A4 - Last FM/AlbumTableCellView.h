/****************************************************************
 FILE:      AlbumTableCellView.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  March 20, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
 the AlbumTableCellView class
 ****************************************************************/
#import <UIKit/UIKit.h>

@interface AlbumTableCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;       //album name
@property (weak, nonatomic) IBOutlet UILabel *albumRankLabel;       //album rank


@end
