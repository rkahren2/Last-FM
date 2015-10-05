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

#import "FindAlbumViewController.h"
#import "album.h"
#import "AlbumTableCellView.h"


@interface FindAlbumViewController ()

@property NSXMLParser *parser;                      //XML parser
@property NSString *element;                        //name of XML element
@property NSString *currentName;                    //name of artist
@property NSString *currentMbid;                    //artist Last FM Website
@property NSString *currentRank;                    //rank of album

@end



@implementation FindAlbumViewController

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
        //string to build title
        NSMutableString *title = [[NSMutableString alloc]init];
        //build title and display
        [title setString:self.searchItem];
        [title appendString:@" Top Albums"];
        self.navigationItem.title = title;
        self.albumList = [[NSMutableArray alloc]init];
        //create URL
        NSString *URL = @"http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=*&api_key=569d15bf053eb69144b2e8bcb3904695";
        URL = [URL stringByReplacingOccurrencesOfString:@"*" withString:self.searchItem];
        URL = [URL stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSURL *xmlURL = [NSURL URLWithString:URL];
        //start XMLParse in background thread
        dispatch_queue_t backgroundQue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(backgroundQue, ^{
            self.parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
            self.parser.delegate = self;
            [self.parser parse];
            //update UI thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.albumTableView reloadData];
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
    return [self.albumList count]; // get the number of rows // from the controller
}
/********************************************************************************
 FUNCTION:		- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 
 ARGUMENTS:		(UITableView *)tableView, the tableview requesting the cell, (NSIndexPath *)indexPath, index path locating a row in tableView
 
 
 RETURNS:		The function returns an UITableViewCell that the tableview can use for the specified row
 
 NOTES:			This function gets a cell and sets it up for use in the tableview
 ************************************************************************************/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumTableCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"album" forIndexPath:indexPath];
    album *album = [self.albumList objectAtIndex:indexPath.row];
    cell.albumNameLabel.text = album.name;
    cell.albumRankLabel.text = album.rank;
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
    //if a tag is an album clear varaibles and get rank
    if ([self.element isEqualToString:@"album"])
    {
        self.currentName = @"";
        self.currentMbid = @"";
        self.currentRank = [attributeDict objectForKey:@"rank"];
        
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
    //if error, display UIAlert
    if ([self.element isEqualToString:@"error"])
    {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    //if element is equal to name and is not a new line character
    if ([self.element isEqualToString:@"name"] && (![string containsString:@"\n"]))
    {
        //if currentName leanght is 0 make currentName equal to string
        if ([self.currentName length] == 0 )
        {
            self.currentName = string;
            self.currentName = [self.currentName stringByAppendingString:@" "];
            
            
        }
        //otherwise test and append sting
        else
        {
            //make string lower case and test
            NSString *testString = [string lowercaseString];
            self.searchItem = [self.searchItem lowercaseString];
            //if not equal append string
            if(![testString containsString:self.searchItem])
            {
                self.currentName = [self.currentName stringByAppendingString:string];
                self.currentName = [self.currentName stringByAppendingString:@" "];
            }
        }
    }
    //if element is mbid and not a newline character
    if ([self.element isEqualToString:@"mbid"] && (![string containsString:@"\n"]))
    {
        //if currentmbid is not 0 then currentmib equals string
        if ([self.currentMbid length] == 0)
        {
            self.currentMbid = string;
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
    if ([self.element isEqualToString:@"album"])
    {
        album *newAlbum = [[album alloc]init];
        newAlbum.name = self.currentName;
        newAlbum.mbid = self.currentMbid;
        newAlbum.rank = self.currentRank;
        
        
        //add client to clientList
        [self.albumList addObject:newAlbum];
        
    }
    //call UI thread and update the tableView
    
    
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
    //if the segue is equal to ShowAttractionDetails, retrive the selected attraction and pass it to the DetailViewController.
    if ([[segue identifier] isEqualToString:@"track"])
    {
        NSIndexPath *indexPath = [self.albumTableView indexPathForSelectedRow];
        album *segueAlbum = [self.albumList objectAtIndex:indexPath.row];
        [[segue destinationViewController] setSearchItem:segueAlbum];
    }
}



@end