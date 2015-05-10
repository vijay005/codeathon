//
//  HACNewBillViewController.h
//  Hackathon
//
//  Created by Anil Kothari on 09/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HACNewBillViewController : UIViewController{


}


@property (weak, nonatomic) IBOutlet UIButton *btnCategory;
@property (weak, nonatomic) IBOutlet UIButton *btnSubCategory;

@property (weak, nonatomic) IBOutlet UITextField *dateOfOrder;
@property (weak, nonatomic) IBOutlet UITextField *merchantNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *commentTxt;


@property (weak, nonatomic) IBOutlet UISlider *m_sliderSlideToUnlock;
@property (weak, nonatomic) IBOutlet UILabel *m_lblSlideToUnlock;
@property (weak, nonatomic) IBOutlet UIImageView *m_imgContainer;


-(IBAction)fadeLabel;
-(IBAction)UnLockIt;

- (IBAction)searchClicked:(id)sender;



@end
