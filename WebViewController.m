/***********************************************************************
 PROGRAM: 		Kahren TopTen LosAngeles (Visit Los Angeles)
 AUTHOR: 		Robert Kahren II
 LOGON ID		Z1691801
 DUE DATE:		May 5, 2014 at 6pm
 
 FUNCTION:		This program Runs on iphone and displays information about the city of Los
                Angeles, CA for those who are looking to or are visiting the city including a lists of
                attraction, hotels, and restaurants.  The use can select an attraction/hotel/restaurant and get a
                description of the attraction, where it is located, its hours and a picture.  The app
                will also allow the use to call the attraction, vist its website and get a map of the location.  The user can buy city
                passes for Los Angeles thru the app and review thier past orders.
                The app also provides the user a chance to complete a survey about thier trip afterwards.
 
 INPUT: 		The program revieces input from the user vis the deceive's touch screen.
 
 OUTPUT: 		The program displys information to the user via the deceive's touch screen
 **************************************************************************/

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

/********************************************************************************
 FUNCTION:		-(id) initWithURL:(NSURL *)url
 
 ARGUMENTS:		(NSURL *)url, the url to be displayed
 
 RETURNS:		this function returns it's self
 
 NOTES:			This function intitalizes the WebViewControler with the url recieved from the caller
 ************************************************************************************/

-(id) initWithURL:(NSURL *)url
{
    //call super's init
    self = [super init];
    //if no proplems with super, intializer properties
    if(self)
    {
        theURL = url;
        theTitle = nil;
    }
    return self;
}
/********************************************************************************
 FUNCTION:		-(id) initWithURL:(NSURL *)url andTitle:(NSString *)string
 
 ARGUMENTS:		(NSURL *)url, the url to be displayed, (NSString *)string, title of web page
 
 RETURNS:		this function returns it's self
 
 NOTES:			This function intitalizes the WebViewControler with the url and title recieved from the caller
 ************************************************************************************/
-(id) initWithURL:(NSURL *)url andTitle:(NSString *)string
{
    //call super's init
    self = [super init];
    //if no proplems with super, intializer properties
    if(self)
    {
        theURL = url;
        theTitle = string;
    }
    return self;

    
}
/********************************************************************************
 FUNCTION:		- (void)viewDidLoad
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			the function is called after the controller’s view is loaded into memory. and populates the view's elements
 ************************************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //populate the title and load the webView
    webTitle.title = theTitle;
    NSURLRequest *requestObjest = [NSURLRequest requestWithURL:theURL];
    [webView loadRequest:requestObjest];
    
}
/********************************************************************************
 FUNCTION:		-(void) viewWillDisappear:(BOOL)animated
 
 ARGUMENTS:		(BOOL)animated, states whether the disappearing of the view should be animated
 
 RETURNS:		The function has no return value
 
 NOTES:			the function is called when the view will disappear. it can animated that process and stops the webview from contining to load
 ************************************************************************************/
-(void) viewWillDisappear:(BOOL)animated
{
    //call super viewWillDisappear
    [super viewWillDisappear:YES];
    //stop webView from loading
    webView.delegate = nil;
    [webView stopLoading];
}
#pragma -UIWebView Delegate Methods
/********************************************************************************
 FUNCTION:		-(void) webViewDidStartLoad:(UIWebView *)webView
 
 ARGUMENTS:		((UIWebView *)webView, the webView that was started to load
 
 RETURNS:		The function has no return value
 
 NOTES:			The function is called when a webView has started to load a frame.  It turns on the network activty indicator
 ************************************************************************************/

-(void) webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}
/********************************************************************************
 FUNCTION:		-(void) webViewDidfinishLoad:(UIWebView *)webView
 
 ARGUMENTS:		((UIWebView *)webView, the webView that was finished to loading
 
 RETURNS:		The function has no return value
 
 NOTES:			The function is called when a webView has finished loading a frame.  It turns off the network activty indicator
 ************************************************************************************/
-(void) webViewDidFinishLoad:(UIWebView *)webView
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}
/********************************************************************************
 FUNCTION:		-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
 
 ARGUMENTS:		(UIWebView *)webView, the webView that encountered the error, (NSError *)error, the error recived
 
 RETURNS:		The function has no return value
 
 NOTES:			The function is called when the webView encounters an error.  The error is retirved, ingored if possible, if not is presented to the user.
 ************************************************************************************/
-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //get error and if error equals NSURLErrorCancelled, return
    NSLog(@"ERROR : %@",error); //Get informed of the error FIRST
    if([error code] == NSURLErrorCancelled)
        return;
    //otherwise get error description and present to user thru UIAlertView
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    NSString *errorString = [error localizedDescription];
    NSString *errorTitile = [NSString stringWithFormat:@"Error (%ld", (long)error.code];
    UIAlertView *errorView = [[UIAlertView alloc]initWithTitle:errorTitile message:errorString delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [errorView show];
    
}
#pragma UIAlertView Delegate Methods
/********************************************************************************
 FUNCTION:		-(void) didPresentAlertView:(UIAlertView *)alertView
 
 ARGUMENTS:		(UIAlertView *)alertView, alertView that was displayed
 
 RETURNS:		The function has no return value
 
 NOTES:			The function is called when an alertView is displayed.  It gives the user the option to dismiss the view
 ************************************************************************************/
-(void) didPresentAlertView:(UIAlertView *)alertView
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
 FUNCTION:		- (IBAction)doneButton:(id)sender
 
 ARGUMENTS:		(id)sender, the oject that called the function
 
 RETURNS:		The function has returns an IBaction.
 
 NOTES:			This function is called when the doneButton is pressed and it dismisses the current view
 ************************************************************************************/
- (IBAction)doneButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
