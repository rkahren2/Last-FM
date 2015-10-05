/****************************************************************
 FILE:      TrackTableCellView.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  March 20, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
 the TrackTableCellView class
 ****************************************************************/#import <UIKit/UIKit.h>

@interface TrackTableCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;           //track name
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;            //track duration


@end
