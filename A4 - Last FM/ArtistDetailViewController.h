/****************************************************************
 FILE:      ArtistTableCellView.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  March 20, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
 the ArtistTableCellView class
 ****************************************************************/

#import <UIKit/UIKit.h>
@class artist;

@interface ArtistDetailViewController : UIViewController

@property (strong, nonatomic)artist *detailItem;                        //item passed from ViewController
@property (weak, nonatomic) IBOutlet UIImageView *artistImageView;      //artist image
@property (weak, nonatomic) IBOutlet UIButton *websiteButton;           //website button

- (IBAction)artistButton:(id)sender;                                    //website button
@end
