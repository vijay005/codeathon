#import "RecognitionViewController.h"
#import "AppDelegate.h"
#import "ResultProcessView.h"
#import "MBProgressHUD.h"

// Name of application you created
static NSString* MyApplicationID = @"Hackathone";
// Password should be sent to your e-mail after application was created
static NSString* MyPassword = @"zghwswqH6oPzQ2jbsLdWMj9K";

@implementation RecognitionViewController
{
    NSString* result;
    MBProgressHUD *mbProcess;
}
@synthesize textView;
@synthesize statusLabel;
@synthesize statusIndicator;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    statusLabel.hidden = YES;
         statusLabel.text = @"Loading image...";
        
        UIImage* image = [(AppDelegate*)[[UIApplication sharedApplication] delegate] imageToProcess];
        
        Client *client = [[Client alloc] initWithApplicationID:MyApplicationID password:MyPassword];
        [client setDelegate:self];
        
        if([[NSUserDefaults standardUserDefaults] stringForKey:@"installationID"] == nil) {
            NSString* deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            
            NSLog(@"First run: obtaining installation ID..");
            NSString* installationID = [client activateNewInstallation:deviceID];
            NSLog(@"Done. Installation ID is \"%@\"", installationID);
            
            [[NSUserDefaults standardUserDefaults] setValue:installationID forKey:@"installationID"];
        }
        
        NSString* installationID = [[NSUserDefaults standardUserDefaults] stringForKey:@"installationID"];
        
        client.applicationID = [client.applicationID stringByAppendingString:installationID];
        
        ProcessingParams* params = [[ProcessingParams alloc] init];
        
        [client processImage:image withParams:params];
        
        statusLabel.text = @"";
    
    
    mbProcess=[[MBProgressHUD alloc] initWithView:self.view];
    mbProcess.labelText=@"Processing Image... ";
    [self.view addSubview:mbProcess];
    [mbProcess show:YES];

        
 }

- (void)viewDidUnload
{
	[self setTextView:nil];
	[self setStatusLabel:nil];
	[self setStatusIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	textView.hidden = YES;
	
	statusLabel.hidden = NO;
    
	statusIndicator. hidden = YES;
	
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}

#pragma mark - ClientDelegate implementation

- (void)clientDidFinishUpload:(Client *)sender
{
	statusLabel.text = @"";
}

- (void)clientDidFinishProcessing:(Client *)sender
{
	statusLabel.text = @"";
}

- (void)client:(Client *)sender didFinishDownloadData:(NSData *)downloadedData
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

	statusLabel.hidden = YES;
	statusIndicator.hidden = YES;
	
	textView.hidden = NO;
	
	 result = [[NSString alloc] initWithData:downloadedData encoding:NSUTF8StringEncoding];
	
    [[NSUserDefaults standardUserDefaults]setValue:result forKey:@"resultString"];
    [[NSUserDefaults standardUserDefaults]synchronize];
	textView.text = result; 
}

- (void)client:(Client *)sender didFailedWithError:(NSError *)error
{
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
													message:[error localizedDescription]
												   delegate:nil 
										  cancelButtonTitle:@"Cancel" 
										  otherButtonTitles:nil, nil];
	
	[alert show];
	
	statusLabel.text = [error localizedDescription];
	statusIndicator.hidden = YES;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
-(IBAction)detail:(id)sender
{
    ResultProcessView *resultImage = [[ResultProcessView alloc]init];
    
    [self performSegueWithIdentifier:@"ResultProcess" sender:nil];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ResultProcess"]) {
        
        ResultProcessView *resultView = segue.destinationViewController;
        resultView.resultString = result;
        
    }
}

@end
