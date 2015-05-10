//
//  LoginViewController.h
//  Hackathon
//
//  Created by Anil Kothari on 09/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *m_imgEmail;
@property (weak, nonatomic) IBOutlet UIImageView *m_imgPassword;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginTopConstraint;
@property (weak, nonatomic) IBOutlet UITextField *m_txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *m_txtPassword;


@end
