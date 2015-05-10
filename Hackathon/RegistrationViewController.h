//
//  RegistrationViewController.h
//  Hackathon
//
//  Created by Anil Kothari on 09/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *m_tblRegistrationDetails;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_constraintTopTable;

@end
