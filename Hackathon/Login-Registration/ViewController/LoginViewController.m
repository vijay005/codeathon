//
//  LoginViewController.m
//  Hackathon
//
//  Created by Anil Kothari on 09/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import <Parse/Parse.h>
#import "HACHomeViewController.h"
#import "ResultProcessView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "HACUtility.h"

@interface LoginViewController (){
    MBProgressHUD *mbProcess;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureView];
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate *obj = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    obj.strEmailIdUser=@"";
    obj.strSelectedCategory=@"";
    obj.strSelectedSubCategory=@"";

}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [UIView animateWithDuration:1.0 animations:^{
        self.loginTopConstraint.constant = self.view.frame.size.height/4;
        [self.view setNeedsLayout];
    }];


}

-(void) configureView{
    
      self.m_imgEmail.image =[UIImage imageNamed:@"Email"] ;
      self.m_imgPassword.image = [UIImage imageNamed:@"Password"];
    
    self.m_txtEmail.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"Email Id" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
      self.m_txtPassword.secureTextEntry = YES;
    self.m_txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"************" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.m_txtPassword.delegate=self;
    self.m_txtEmail.delegate=self;
    
    self.m_txtEmail.text=@"a@b.com";
    self.m_txtPassword.text=@"123654";
    
    self.m_txtEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.m_txtEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
    
      self.loginTopConstraint.constant  = self.view.frame.size.height/4;
    [self.view setNeedsLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"%@",launchOptions);
    return YES;
}


#pragma mark Textfield Delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:1.0 animations:^{
        self.loginTopConstraint.constant = self.view.frame.size.height/5;
        [self.view setNeedsLayout];
    }];

}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [UIView animateWithDuration:1.0 animations:^{
        self.loginTopConstraint.constant = self.view.frame.size.height/4;
        [self.view setNeedsLayout];
    }];

    
    [textField resignFirstResponder];

    return YES;
}

#pragma mark - Button actions
- (void)showAlert:(NSString*)message withDelegate:(id)delegate{
    
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Notification" message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [al show];
}


-(BOOL) isPassedNormalValidations{
    if (![HACUtility isValidEmail:self.m_txtEmail.text]){
        [self showAlert:@"Please enter valid email" withDelegate:nil];
        return NO;
    }
    
    if (self.m_txtEmail.text.length ==0 ) {
        [self showAlert:@"Email Address  is empty" withDelegate:nil];
        return NO;
    }
    
    if (self.m_txtPassword.text.length ==0 ) {
        [self showAlert:@"Password is empty" withDelegate:nil];
        return NO;
    }
    
    return YES;
    
}

- (IBAction)login:(id)sender {
    if ([self isPassedNormalValidations]) {
        mbProcess=[[MBProgressHUD alloc] initWithView:self.view];
        mbProcess.labelText=@"Authenticating User ";
        [self.view addSubview:mbProcess];
        [mbProcess show:YES];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Login"]; //1
        [query whereKey:@"emailid" equalTo:self.m_txtEmail.text];//2
        [query whereKey:@"password" equalTo:self.m_txtPassword.text];//2
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4
            if (!error && objects.count>0) {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    //Add some method process in global queue - normal for data processing
                    
                    dispatch_async(dispatch_get_main_queue(), ^(){
                        
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                        HACHomeViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HACHomeViewController class])];
                        [self.navigationController pushViewController:homeVC animated:YES];
                        
                        
                        AppDelegate *obj = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                        obj.strEmailIdUser=self.m_txtEmail.text;
                        
                        self.m_txtEmail.text =@"";
                        self.m_txtPassword.text =@"";
                        
                        
                    });
                    
                    
                });
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^(){

                NSString *errorString = @"Due to some technical issues server is down. Please retry again later.";
                [self showAlert:errorString withDelegate:nil];
                });
            }
        }];
        
    }
    
    
    
}

- (IBAction)pushRegistration:(id)sender {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
    RegistrationViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RegistrationViewController class])];
    [self.navigationController pushViewController:homeVC animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 }

@end
