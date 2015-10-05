/****************************************************************
 FILE:      WebViewController.h
 AUTHOR:    Robert Kahren II
 LOGON ID:  Z1691801
 DUE DATE:  May 5, 2014 at 6pm
 
 PURPOSE:   This file contains the properties and method declarations for
            WebViewController class
 ****************************************************************/
#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
<UIWebViewDelegate, UIAlertViewDelegate>
{
    
    IBOutlet UINavigationItem *webTitle;            //title of web page
    IBOutlet UIWebView *webView;                    //web view used to dispage web page
    NSString *theTitle;                             //title recieved from caller
    NSURL *theURL;                                  //url recieved from caller
    
}
//used to dismiss view when done
- (IBAction)doneButton:(id)sender;

//initialize view with url
-(id) initWithURL: (NSURL *) url;

//initialize view with url and title
-(id) initWithURL: (NSURL *) url andTitle:(NSString *) string;

@end
