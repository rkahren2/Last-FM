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
#import "HomeViewController.h"
#import "FindArtistViewController.h"

@implementation HomeViewController

/********************************************************************************
 FUNCTION:		- (void)viewDidLoad
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			the function is called after the controller’s view is loaded into memory. It poplates the UI elements of the view
 ************************************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    //set artistTextField delegate to self
    self.artistTextField.delegate = self;
    //disable all button
    [self.findAlbumsButton setEnabled:NO];
    [self.findSimilarButton setEnabled:NO];
    
    
}
/********************************************************************************
 FUNCTION:		- (void)didReceiveMemoryWarning
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			This function is called by the system when the app receives a memory warning.
 ************************************************************************************/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/********************************************************************************
 FUNCTION:		- (IBAction)artistTextField:(id)sender
 
 ARGUMENTS:		(id)sender, the oject that called the function
 
 RETURNS:		The function has returns an IBaction.
 
 NOTES:			This function is called when the artistTextField is edited and enables or
 disables the buttons on the view.
 ************************************************************************************/
- (IBAction)artistTextField:(id)sender
{
    //if artistTextField is not null enable buttons
    if ([self.artistTextField.text length] != 0)
    {
        [self.findSimilarButton setEnabled:YES];
        [self.findAlbumsButton setEnabled:YES];
    }
    //otherwise disable buttons
    else
    {
        [self.findAlbumsButton setEnabled:NO];
        [self.findSimilarButton setEnabled:NO];
    }
}
/********************************************************************************
 FUNCTION:		- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 
 ARGUMENTS:		(UIStoryboardSegue *)segue, the segue containing information about the view controllers involved in the segue,
 sender:(id)sender, the object that initiated the segue.
 
 RETURNS:		The function has no return value
 
 NOTES:			This function notifies the view controller that a segue is about to be performed and can be used to pass relevant data to the new view controller.
 ************************************************************************************/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if the segue is equal to similar, pass the artist to FindArtistViewController.
    
    if ([[segue identifier] isEqualToString:@"similar"])
    {
        NSString *segueArtist = self.artistTextField.text;
        [[segue destinationViewController] setSearchItem:segueArtist];
    }
    //if the segue is equal to album, pass the artist to AlbumViewController.
    if ([[segue identifier] isEqualToString:@"album"])
    {
        NSString *segueArtist = self.artistTextField.text;
        [[segue destinationViewController] setSearchItem:segueArtist];
    }

    
}

@end
