//
//  RegistrationViewController.m
//  Hackathon
//
//  Created by Anil Kothari on 09/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import "RegistrationViewController.h"
#import "HACRegistrationTableViewCell.h"
#import "HACCoreDataHelper.h"
#import <Parse/Parse.h>
#import "HACUtility.h"
#import "MBProgressHUD.h"

@interface RegistrationViewController ()<UIAlertViewDelegate>{
    NSArray *m_arrLabelPlaceHolder;
    NSArray *m_arrTextFieldPlaceHolder;
    MBProgressHUD *mbProcess;
}
@property (weak, nonatomic) IBOutlet UIButton *m_btnRegister;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    m_arrLabelPlaceHolder = [[NSArray alloc] initWithObjects:@"First Name",@"Last Name",@"Email Id",@"Password",@"Confirm Password", nil];
    
    m_arrTextFieldPlaceHolder= [[NSArray alloc] initWithObjects:@"* Enter first name",@"* Enter last name",@"* Enter email id",@"* Enter password",@"* Enter confirm password", nil];
    
    _m_btnRegister.layer.cornerRadius = 5.0f;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismissed");
    }];
}

- (IBAction)register:(id)sender {
    
    NSString *str = @"";

    for (int i=0 ; i<m_arrLabelPlaceHolder.count ; i++){
        
        HACRegistrationTableViewCell *cell = (HACRegistrationTableViewCell *)[self.m_tblRegistrationDetails cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        
        if (cell.m_txtDataField.text.length == 0)
        {
            switch (i){
                case 0:
                    str = [str stringByAppendingString:@"- First name empty"];
                    [self showAlert:str  withDelegate:nil];
                    return;
                    break;
                case 1:
                    str = [str stringByAppendingString:@"- Last name empty"];
                    [self showAlert:str  withDelegate:nil];
                    return;
                    break;
                case 2:
                    str = [str stringByAppendingString:@"- Email id empty"];
                    [self showAlert:str  withDelegate:nil];
                    return;
                    break;
                case 3:
                    str = [str stringByAppendingString:@"- Password empty"];
                    [self showAlert:str  withDelegate:nil];
                    return;
                    break;
            }
        }
      
    }
    
    if (![str isEqualToString:@""]){
        [self showAlert:str  withDelegate:nil];
         return;
    }
    

     
 
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (int i=0 ; i<m_arrLabelPlaceHolder.count ; i++){
        HACRegistrationTableViewCell *cell = (HACRegistrationTableViewCell *)[self.m_tblRegistrationDetails cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [dict setObject:cell.m_txtDataField.text forKey:m_arrLabelPlaceHolder[i]];
    }
    
    if (![HACUtility isValidEmail:dict[@"Email Id"]]){
        [self showAlert:@"Please enter valid email" withDelegate:nil];
        return;
    }
    
    
    //checking password mismatch
    HACRegistrationTableViewCell *cellPwd = (HACRegistrationTableViewCell *)[self.m_tblRegistrationDetails cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    HACRegistrationTableViewCell *cellConfirmPwd = (HACRegistrationTableViewCell *)[self.m_tblRegistrationDetails cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    if (![cellPwd.m_txtDataField.text isEqualToString:cellConfirmPwd.m_txtDataField.text]){
        [self showAlert:@"Password Mismatch" withDelegate:nil];
        return;
    }
    
    mbProcess=[[MBProgressHUD alloc] initWithView:self.view];
    mbProcess.labelText=@"Authenticating User ";
    [self.view addSubview:mbProcess];
    [mbProcess show:YES];

    
    
    [[HACCoreDataHelper sharedInstance] addValuesInCoreDataStack:dict withCompletionHandler:^(id results, NSError *err) {
        // upload the data on webservice
        [self uploadRegisteredUserData:dict];

        
    }];
}

- (void)showAlert:(NSString*)message withDelegate:(id)delegate{

    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Notification" message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [al show];
 }

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismiss:nil];
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
  
}


-(void) uploadRegisteredUserData:(NSDictionary *)entity{
    
    PFObject *anotherPlayer = [PFObject objectWithClassName:@"Login"];
    
    
    [anotherPlayer  setObject:entity[@"Email Id"] forKey:@"emailid"];
    [anotherPlayer  setObject:entity[@"First Name"] forKey:@"firstName"];
    [anotherPlayer  setObject:entity[@"Last Name"] forKey:@"lastName"];
    [anotherPlayer  setObject:entity[@"Password"] forKey:@"password"];
    
    
    [anotherPlayer saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            [self showAlert:@"User Registered Successfully"  withDelegate:self];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
        else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            [self showAlert:errorString  withDelegate:nil];
        }
        
    }];
    
}

#pragma mark - tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return m_arrLabelPlaceHolder.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier =@"Registration";
    
    HACRegistrationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil) {
        
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HACRegistrationTableViewCell class]) owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.m_lblPlaceHolder.text = [m_arrLabelPlaceHolder objectAtIndex:indexPath.row];
    cell.m_txtDataField.placeholder = [m_arrTextFieldPlaceHolder objectAtIndex:indexPath.row];

    cell.m_txtDataField.clearButtonMode = UITextFieldViewModeWhileEditing;

    if ([cell.m_txtDataField.placeholder isEqualToString:@"* Enter password"] ||  [cell.m_txtDataField.placeholder isEqualToString:@"* Enter confirm password"]) {
        cell.m_txtDataField.secureTextEntry = YES;
    }
    
    
    return  cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
