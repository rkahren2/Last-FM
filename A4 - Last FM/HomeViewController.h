/****************************************************************
 FILE:      HomeViewController.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  March 20, 2015 at 11:59pm
 
 PURPOSE:   This file contains the properties and method declarations for
 the HomeViewController class
 ****************************************************************/#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *artistTextField;

@property (weak, nonatomic) IBOutlet UIButton *findAlbumsButton;
@property (weak, nonatomic) IBOutlet UIButton *findSimilarButton;

- (IBAction)artistTextField:(id)sender;
@end

