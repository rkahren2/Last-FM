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
#import "TrackViewController.h"
#import "track.h"
#import "album.h"
#import "TrackTableCellVeiw.h"
#import "WebViewController.h"

@interface TrackViewController ()

@property NSXMLParser *parser;                      //XML parser
@property NSString *element;                        //name of XML element
@property NSString *attribute;                      //xml attribute
@property NSString *currentName;                    //name of artist
@property NSString* currentURL;                     //artist Last FM Website
@property NSString* currentDuration;                //artist's image

@end



@implementation TrackViewController
/********************************************************************************
 FUNCTION:		- (void)setDetailItem:(id)newDetailItem
 
 ARGUMENTS:		(id)newDetailItem, object the contains the book to be displayed
 
 RETURNS:		The function has no return value
 
 NOTES:			This function updates the detailItem to be the curretnly selected client if it is not already.
 ************************************************************************************/
- (void)setSearchItem:(id)newSearchItem
{
    //if detailItem is not equal to newDetailItem, update it
    if (_searchItem != newSearchItem) {
        _searchItem = newSearchItem;
        
        // Update the view.
        // [self configureView];
    }
}
/********************************************************************************
 FUNCTION:		- (void)viewDidLoad
 
 ARGUMENTS:		This function recieves no arguments
 
 RETURNS:		The function has no return value
 
 NOTES:			the function is called after the controller’s view is loaded into memory. It poplates the UI elements of the view
 ************************************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.searchItem)
    {
        
        self.navigationItem.title = self.searchItem.name;
        self.trackList = [[NSMutableArray alloc]init];
        //create URL
        NSString *URL = @"http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=569d15bf053eb69144b2e8bcb3904695&mbid=*";
        URL = [URL stringByReplacingOccurrencesOfString:@"*" withString:self.searchItem.mbid];
        NSURL *xmlURL = [NSURL URLWithString:URL];
        //start XMLParse in background thread
        dispatch_queue_t backgroundQue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(backgroundQue, ^{
            self.parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
            self.parser.delegate = self;
            [self.parser parse];
            //update UI thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.trackTableView reloadData];
            });
            
            
            
        });
        
    }
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
 FUNCTION:		- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 
 ARGUMENTS:		(UITableView *)tableView, a table view requesting this information.
 
 RETURNS:		The function returns a NSInteger reperseting the number of sections in the table
 
 NOTES:			This function returns the number of sections in the table, in this case 1
 ************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
/********************************************************************************
 FUNCTION:		- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 
 ARGUMENTS:		(UITableView *)tableView, The table view requesting this information, (NSInteger)section, index number identifying a section in tableView.
 
 RETURNS:		The function returns a NSInteger repersenting the number of rows in the section
 
 NOTES:			This function gets the number of clients in the clientList and returns it as the number of rows for the tableview
 ************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.trackList count]; // get the number of rows // from the controller
}
/********************************************************************************
 FUNCTION:		- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 
 ARGUMENTS:		(UITableView *)tableView, the tableview requesting the cell, (NSIndexPath *)indexPath, index path locating a row in tableView
 
 
 RETURNS:		The function returns an UITableViewCell that the tableview can use for the specified row
 
 NOTES:			This function gets a cell and sets it up for use in the tableview
 ************************************************************************************/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrackTableCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"track" forIndexPath:indexPath];
    track *track = [self.trackList objectAtIndex:indexPath.row];
    cell.trackNameLabel.text = track.name;
    //convert seconds into minutes and seconds
    int minutes = [track.duration intValue] / 60;
    int seconds = [track.duration intValue] - (minutes *60);
    NSString *duration = [NSString stringWithFormat:@"%d" ,minutes];
    duration = [duration stringByAppendingString:@":"];
    duration = [duration stringByAppendingFormat:@"%d", seconds];
    //add trailing zero if needed
    if ([duration length] < 4)
        duration = [duration stringByAppendingString:@"0"];
    cell.durationLabel.text = duration;
    return cell;
}
/********************************************************************************
 FUNCTION:		- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath: (NSIndexPath *)indexPath
 
 ARGUMENTS:		(UITableView *)tableView, the tableview requesting this information,  (NSIndexPath *)indexPath, index path locating a row in tableView.
 
 RETURNS:		The function returns a bool indicationg if the row in the index path is editable
 
 NOTES:			This function returns a bool telling if the row indicated by the indexpath in the tableview is editable.
 ************************************************************************************/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath: (NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}
/********************************************************************************
 FUNCTION:		- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
 attributes:(NSDictionary *)attributeDict
 
 ARGUMENTS:		(NSXMLParser *)parser, a parser object, (NSString *)elementName, A string that is the name of an element (in its start tag), (NSString *)namespaceURI,contains the URI for the
 current namespace as a string object, (NSString *)qualifiedName, contains the qualified name for the current namespace as a string object, (NSDictionary *)attributeDict, A
 dictionary that contains any attributes associated with the element
 
 RETURNS:		The function has no return value
 
 NOTES:			This function is called when the parser encounteers a tag.  It then extracts the data from the tags attributes
 ************************************************************************************/
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    self.element = elementName;
    //if tag is a track clear varaibles
    if ([self.element isEqualToString:@"track"])
    {
        self.currentName = @"";
        self.currentURL = @"";
        self.currentDuration = @"";
        
    }
    
}
/********************************************************************************
FUNCTION:		-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string

ARGUMENTS:		(NSXMLParser *)parser, a parser object, (NSString *)string, A string that the characters from in the

RETURNS:		The function has no return value

NOTES:			This function is called when the parser encounteers characters in  tag.  It then extracts the data from the tags.
************************************************************************************/

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //if element is equal to name and is not a new line character
    if ([self.element isEqualToString:@"name"] && (![string containsString:@"\n"]))
    {
        //if currentName leanght is 0 make currentName equal to string
        if ([self.currentName length] == 0 )
        {
            self.currentName = string;
        }
    }
    //if element is equal to URL and is not a new line character
    if ([self.element isEqualToString:@"url"] && (![string containsString:@"\n"]))
    {
        //if currentURL ilenght is 0 make current URL equal to string
        if ([self.currentURL length] == 0)
        {
            self.currentURL = string;
            
        }
        //otherwise append string to currentURL
        else
        {
            self.currentURL = [self.currentURL stringByAppendingString:string];
        }
        
    }
    //if element is duration and is not a new line character
    if ([self.element isEqualToString:@"duration"] && (![string containsString:@"\n"]))
    {
        //if lenght is 0 the currentduration is string
        if ([self.currentDuration length] == 0)
        {
            self.currentDuration = string;
            
        }
        //else append string
        else
        {
            self.currentDuration = [self.currentDuration stringByAppendingString:string];
        }

    }
    
    
}
/********************************************************************************
 FUNCTION:		- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
 
 ARGUMENTS:		(NSXMLParser *)parser, a parser object, (NSString *)elementName, A string that is the name of an element (in its end tag), (NSString *)namespaceURI,
 contains the URI for the current namespace as a string object, (NSString *)qName, contains the qualified name for the current namespace as a string object
 
 RETURNS:		The function has no return value
 
 NOTES:			This function is called when the parser encounteers the end of tag.  It then adds the client to the client list and updates the ui thread
 ************************************************************************************/
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    //get name of element
    self.element = elementName;
    //if it is a person element, create new client and add it to the client list
    if ([self.element isEqualToString:@"track"])
    {
        track *newTrack = [[track alloc]init];
        newTrack.name = self.currentName;
        newTrack.webSite = self.currentURL;
        newTrack.duration = self.currentDuration;
        
        //add client to clientList
        [self.trackList addObject:newTrack];
        
    }
    //call UI thread and update the tableView
    
    
}



@end
