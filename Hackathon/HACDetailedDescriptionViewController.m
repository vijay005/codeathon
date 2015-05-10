//
//  HACDetailedDescriptionViewController.m
//  Hackathon
//
//  Created by Anil Kothari on 10/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import "HACDetailedDescriptionViewController.h"

@interface HACDetailedDescriptionViewController ()

@end

@implementation HACDetailedDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Invoice";

     UIImageView *image=[[UIImageView alloc] initWithFrame:self.view.frame];
    
    image.image= self.image;
    
    [self.view addSubview:image];
    
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
