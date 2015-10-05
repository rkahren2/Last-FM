/***********************************************************************
 PROGRAM: 		A4-Last FM
 AUTHOR: 		Robert Kahren II
 LOGON ID		Z1691801
 DUE DATE:		March 20, 2015 at 11:59pm
 
 FUNCTION:		This program Runs on iphone and allows the user to search for artist simular to another artist or the top albums by an artist.
 It also allows the user to webthe website for the simular artits and the tracks on the albums.
 
 INPUT: 		The program revieces input from the user via the deceive's touch screen and downloads it's
 XML data from Last.FM
 
 OUTPUT: 		The program displys information to the user via the deceive's touch screen
 **************************************************************************/
#import "ArtistDetailViewController.h"
#import "artist.h"
#import "WebViewController.h"

//private interface for ArtistDetailViewController for nonpublic elements
@interface ArtistDetailViewController ()
- (void)configureView;
@end

@implementation ArtistDetailViewController
/********************************************************************************
 FUNCTION:		- (void)setDetailItem:(id)newDetailItem
 
 ARGUMENTS:		(id)newDetailItem, object the contains the book to be displayed
 
 RETURNS:		The function has no return value
 
 NOTES:			This function updates the detailItem to be the curretnly selected client if it is not already.
 ************************************************************************************/
- (void)setDetailItem:(id)newDetailItem
{
    //if detailItem is not equal to newDetailItem, update it
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}
/********************************************************************************
 FUNCTION:		- (void)configureView
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			This function sets the text on the detailview to be the details for the selected client
 ************************************************************************************/
- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem)
    {
        self.navigationItem.title = self.detailItem.name;
        NSURL *imageURL = [NSURL URLWithString:self.detailItem.image];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        self.artistImageView.image = image;
        NSString *buttonTitle = self.detailItem.name;
        buttonTitle = [buttonTitle stringByAppendingString:@"'s Last FM Website"];
        [self.websiteButton setTitle:buttonTitle forState:UIControlStateNormal];
        
    }
    
}
/********************************************************************************
 FUNCTION:		- (void)viewDidLoad
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			The function is called after the controller’s view is loaded into memory.
 ************************************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}
/********************************************************************************
 FUNCTION:		- (void)didReceiveMemoryWarning
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			This function is called by the system when the app receives a memory warning.
 ************************************************************************************/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/********************************************************************************
 FUNCTION:		- (IBAction)artistButton:(id)sender
 
 ARGUMENTS:		(id)sender, the oject that called the function
 
 RETURNS:		The function has returns an IBaction.
 
 NOTES:			This function is called when the artistButton is pressed and displays a WebViewController that displays
 the attraction's webpage
 ************************************************************************************/

- (IBAction)artistButton:(id)sender
{
    //create a url for the webpage
    NSURL *url = [NSURL URLWithString:self.detailItem.webSite];
    //create an instance of the WebViewController with the url and title of the attraction and present it to the user
    WebViewController *webvc = [[WebViewController alloc]initWithURL:url andTitle:self.detailItem.name];
    [self presentViewController:webvc animated:YES completion:nil];
    
}
@end
