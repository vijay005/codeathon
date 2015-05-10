//
//  HACHomeViewController.m
//  Hackathon
//
//  Created by Anil Kothari on 09/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import "HACHomeViewController.h"
#import "ImageViewController.h"
#import "HACNewBillViewController.h"
#import "AppDelegate.h"
@interface HACHomeViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saveHeightConstraint;

@end

@implementation HACHomeViewController


-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    AppDelegate *obj = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    obj.strSelectedCategory = @"";
    obj.strSelectedSubCategory = @"";
    obj.strComments =@"";
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.searchHeightConstraint.constant = self.saveHeightConstraint.constant = self.view.frame.size.height/2;
    
    self.topConstaintSeachInvoice.constant =  self.view.frame.size.height/2 - 30;

    // Do any additional setup after loading the view.
}
- (IBAction)searchBill:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"searchBill" bundle:[NSBundle mainBundle]];
    
    HACNewBillViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HACNewBillViewController class])];
    [self.navigationController pushViewController:homeVC animated:YES];
    
}
- (IBAction)saveBill:(id)sender {
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"NewBill" bundle:[NSBundle mainBundle]];
    
    ImageViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ImageViewController class])];
    [self.navigationController pushViewController:homeVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
