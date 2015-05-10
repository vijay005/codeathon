//
//  HACNewBillViewController.m
//  Hackathon
//
//  Created by Anil Kothari on 09/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import "HACNewBillViewController.h"
#import "HACList.h"
#import "AppDelegate.h"
#import "HACCoreDataHelper.h"

#import "HACSearchResultDataTableViewController.h"

@interface HACNewBillViewController ()
{
     NSDictionary *dictCategories;
    BOOL UNLOCKED;
    AppDelegate *obj;
    
    NSArray *m_arrSearchList;
}
@end

@implementation HACNewBillViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    obj = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    obj.strSelectedCategory = @"";
    obj.strSelectedSubCategory = @"";
    obj.strComments =@"";
    
    self.title = @"Search Criteria";
    
        
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [_dateOfOrder setInputView:datePicker];
    
    
    
    self.dateOfOrder.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"Date Of Order" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
     self.merchantNameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Merchant name" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.commentTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Tags" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];


    self.btnCategory.layer.borderWidth =1.0f;
    self.btnSubCategory.layer.borderWidth =1.0f;

    self.btnCategory.layer.borderColor =[UIColor whiteColor].CGColor;
    self.btnSubCategory.layer.borderColor =[UIColor whiteColor].CGColor;
    

    
    _m_imgContainer.layer.backgroundColor=[[UIColor clearColor] CGColor];
    _m_imgContainer.layer.cornerRadius=10;
    _m_imgContainer.layer.borderWidth=0.5;
    _m_imgContainer.layer.masksToBounds = YES;
    _m_imgContainer.layer.borderColor=[[UIColor clearColor] CGColor];

    
    UIImage *stetchLeftTrack= [[UIImage imageNamed:@"Nothing.png"]
                               stretchableImageWithLeftCapWidth:25.0 topCapHeight:-10.0];
    
    UIImage *stetchRightTrack= [[UIImage imageNamed:@"Nothing.png"]
                                stretchableImageWithLeftCapWidth:25.0 topCapHeight:-10.0];
    
    [_m_sliderSlideToUnlock setThumbImage: [UIImage imageNamed:@"SlideToStop.png"] forState:UIControlStateNormal];
    
    [_m_sliderSlideToUnlock setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    
    [_m_sliderSlideToUnlock setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    
    
    
}

-(void) dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)_dateOfOrder.inputView;
    [picker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _dateOfOrder.text = [NSString stringWithFormat:@"%@",dateString];
}
- (IBAction)selectedCategory:(id)sender {
    NSString *strFilePath = [[NSBundle mainBundle]pathForResource:@"Categories" ofType:@"plist"];
    dictCategories = [[NSDictionary alloc] initWithContentsOfFile:strFilePath];

    HACList *objHacList =[[HACList alloc] init];
    objHacList.m_bIsCategory = YES;

    objHacList.m_arrList = dictCategories.allKeys;
    [self.navigationController pushViewController:objHacList animated:YES];

}

- (void)showAlert:(NSString*)message withDelegate:(id)delegate{
    
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Notification" message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [al show];
}
- (IBAction)selectedSubCategory:(id)sender {
    
    if (![obj.strSelectedCategory isEqualToString:@""]) {
        NSString *strFilePath = [[NSBundle mainBundle]pathForResource:@"Categories" ofType:@"plist"];
        dictCategories = [[NSDictionary alloc] initWithContentsOfFile:strFilePath];
        
        HACList *objHacList =[[HACList alloc] init];
        
        objHacList.m_arrList = [dictCategories objectForKey:obj.strSelectedCategory];
        objHacList.m_bIsCategory = NO;
        [self.navigationController pushViewController:objHacList animated:YES];
    }
    else{
        [self showAlert:@"Please select category first" withDelegate:nil];
    }
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:YES];
    
    [self.btnCategory setTitle:obj.strSelectedCategory forState:UIControlStateNormal];
    [self.btnSubCategory setTitle:obj.strSelectedSubCategory forState:UIControlStateNormal];

    _m_sliderSlideToUnlock.value = 0.0;
    UNLOCKED = NO;
    _m_sliderSlideToUnlock.hidden = NO;
    _m_imgContainer.hidden = NO;
    _m_lblSlideToUnlock.hidden = NO;
    _m_lblSlideToUnlock.alpha = 1.0;
    
}
- (IBAction)categoryClear:(id)sender {
    obj.strSelectedCategory = @"";
    obj.strSelectedSubCategory = @"";

    [self.btnCategory setTitle:obj.strSelectedCategory forState:UIControlStateNormal];
    [self.btnSubCategory setTitle:obj.strSelectedSubCategory forState:UIControlStateNormal];
}
- (IBAction)subCategoryClear:(id)sender {
    obj.strSelectedSubCategory = @"";

    [self.btnCategory setTitle:obj.strSelectedCategory forState:UIControlStateNormal];
    [self.btnSubCategory setTitle:obj.strSelectedSubCategory forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark Fade UILable on Slider--

-(IBAction)fadeLabel {
    
    _m_lblSlideToUnlock.alpha = 1.0 - _m_sliderSlideToUnlock.value;
    
}


#pragma mark -
#pragma mark UISlider Unlock--
-(IBAction)UnLockIt {
    
    
    if (!UNLOCKED) {
        
        
        if (_m_sliderSlideToUnlock.value ==1.0) {  // if user slide far enough, stop the operation
            
           
            if (_btnCategory.titleLabel.text.length == 0 && _btnSubCategory.titleLabel.text.length == 0 && _dateOfOrder.text.length == 0 && _merchantNameTxt.text.length == 0 && _commentTxt.text.length == 0)
            {
                UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Notification" message:@"Please enter some value to search" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [al show];
                return;
                
            }
            
            
            
            // Put here what happens when it is unlocked
            
            _m_sliderSlideToUnlock.hidden = YES;
            
            // lockButton.hidden = NO;
            
            _m_imgContainer.hidden = YES;
            
            _m_lblSlideToUnlock.hidden = YES;
            
            UNLOCKED = YES;
            
            
           //Push to Next View
            
        }
        else
        {
            
            // user did not slide far enough, so return back to 0 position
            
            [UIView beginAnimations: @"SlideCanceled" context: nil];
            
            [UIView setAnimationDelegate: self];
            
            [UIView setAnimationDuration: 0.35];
            
            // use CurveEaseOut to create "spring" effect
            
            [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
            
            _m_sliderSlideToUnlock.value = 1.0;
            _m_lblSlideToUnlock.alpha = 1.0;
            
            [UIView commitAnimations];
            
        }
        
    }
    
}

- (IBAction)searchClicked:(id)sender
{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
    
    if (_btnCategory.titleLabel.text.length>0) {
        [dict setObject:_btnCategory.titleLabel.text forKey:@"btnCategory"];

    }
    if (_btnSubCategory.titleLabel.text.length>0) {
        [dict setObject:_btnSubCategory.titleLabel.text forKey:@"subCategory"];

    }
    if (_dateOfOrder.text.length>0) {
        [dict setObject:_dateOfOrder.text forKey:@"dateOfOrder"];

    }
    if (_merchantNameTxt.text.length>0) {
        [dict setObject:_merchantNameTxt.text forKey:@"merchant"];

    }
    
    if (_commentTxt.text.length>0) {
        [dict setObject:_commentTxt.text forKey:@"comment"];

    }


    
    
    m_arrSearchList= [[HACCoreDataHelper sharedInstance]getSearchResultList:dict];
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"searchBill" bundle:[NSBundle mainBundle]];
    HACSearchResultDataTableViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HACSearchResultDataTableViewController class])];
    homeVC.m_arrSearchResult =m_arrSearchList;
    [self.navigationController pushViewController:homeVC animated:YES];
    
    
 }


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
