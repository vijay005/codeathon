//
//  ResultProcessView.m
//  OcrSdkDemo
//
//  Created by Nitin Chauhan on 09/05/15.
//  Copyright (c) 2015 ABBYY. All rights reserved.
//

#import "ResultProcessView.h"
#import "ResultCell.h"
#import "NSString+KeyWordFinder.h"
#import "HACList.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "HACCoreDataHelper.h"
#import "MBProgressHUD.h"


@interface ResultProcessView ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>
{
    UIPickerView *picker;
    
    NSDictionary *dictCategories;
    NSString *strCategory;
    NSString *strSubCategory;
    
    NSInteger tagValue;
    MBProgressHUD *mbProcess;
    
}

@end

@implementation ResultProcessView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate *obj = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    strCategory = obj.strSelectedCategory;
    strSubCategory = obj.strSelectedSubCategory;
    
    _strComments = obj.strComments;
    
    UITableView *tbl =(UITableView*) [self.view viewWithTag:123654];
    
    UIView *vw =[[UIView alloc] init];
    tbl.tableFooterView =vw;
    tbl.tableFooterView.backgroundColor=[UIColor clearColor];
    
    tbl.backgroundColor= [UIColor clearColor];
    [tbl reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Add Invoice";
    
    AppDelegate *obj = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    obj.strSelectedCategory = @"";
    obj.strSelectedSubCategory = @"";
    obj.strComments =@"";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(saveDetails:)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
    
    
    
    
    NSString *strFilePath = [[NSBundle mainBundle]pathForResource:@"Categories" ofType:@"plist"];
    dictCategories = [[NSDictionary alloc] initWithContentsOfFile:strFilePath];
    
    
    infoArray_ = [[NSArray alloc]initWithObjects:@"Category", @"Sub-category", @"Merchant name",@"Order number",@"Date Of Purchase",@"Total price",@"Tags", nil];
   
    NSLog(@"result %@", _resultString);
  //    _resultString =    [[NSUserDefaults standardUserDefaults]valueForKey:@"resultString"];
    
    resultArray_ = [[NSMutableArray alloc]init];
    
    [resultArray_ addObject:@""];
    [resultArray_ addObject:@""];
    BOOL isExist = [_resultString isStringcontainKeyword:@"Amazon.in"];
    if (isExist) {
        fetchingValueArray = [[NSArray alloc]initWithObjects:@"order number:",@"Order Placed:",@"Order Total: ?", nil];
        [resultArray_ addObject:@"Amazon.in"];
        
    }else{
        fetchingValueArray = [[NSArray alloc]initWithObjects:@"Order ID",@"Order Date:",@"Grand Total ?", nil];
        [resultArray_ addObject:@"Flipkart.com"];
        
    }
    NSLog(@"result %@", _resultString);
    
    
    NSString *foundString;
    for (NSString *stringValue in fetchingValueArray) {
        BOOL isExist = [_resultString isStringcontainKeyword:stringValue];
         NSLog(@"%d  ", isExist);
        if (isExist) {
          foundString =  [self seprateStringByString:stringValue];
         [resultArray_ addObject:foundString];
        }
    }
    
    [resultArray_ addObject:@""];
    // Do any additional setup after loading the view.
}

-(NSString *)seprateStringByString:(NSString *)string
{
    NSRange range = [_resultString rangeOfString:string];
    NSString *stringFound = [_resultString substringFromIndex:range.location + range.length];
    NSArray *tempArray = [stringFound componentsSeparatedByString:@"  "];
    
    NSLog(@"Temp Array %@", [tempArray objectAtIndex:0]);
    return [tempArray objectAtIndex:0];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return infoArray_.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier =@"MyCell";
    
    ResultCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell =[[ResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectBtn.hidden = YES;
    cell.textValue_.hidden = YES;
    
    
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new];
    cell.selectedBackgroundView = [UIView new];
    cell.titleLbl_.text = [infoArray_ objectAtIndex:indexPath.row];
    if (resultArray_.count > indexPath.row) {
        NSString * tempString = [resultArray_ objectAtIndex:indexPath.row];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"*"
                                                           withString:@"Rs"];
        cell.textValue_.text = tempString;
    }

    
    
    if (indexPath.row == 0 || indexPath.row ==1) {
        cell.selectBtn.hidden = NO;
        cell.selectBtn.tag = indexPath.row;
        [cell.selectBtn addTarget:self action:@selector(showPickerView:) forControlEvents:UIControlEventTouchUpInside];
        cell.textValue_.hidden = YES;
        if (indexPath.row ==0) {
            [cell.selectBtn setTitle:strCategory forState:UIControlStateNormal];
        }else{
            [cell.selectBtn setTitle:strSubCategory forState:UIControlStateNormal];
         }
        
    }
    else if (indexPath.row == (infoArray_.count -1)){
        AppDelegate *obj = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        cell.textValue_.text = obj.strComments ;
        cell.selectBtn.hidden = YES;
        cell.textValue_.hidden = NO;
    }
    
     else{
        cell.selectBtn.hidden = YES;
        cell.textValue_.hidden = NO;

    }
    
  
    
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}



- (void)showAlert:(NSString*)message withDelegate:(id)delegate{
    
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Notification" message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [al show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSArray *array = [self.navigationController viewControllers];

    [self.navigationController popToViewController:array[1] animated:YES];
}

-(void)showPickerView:(UIButton *)sender
 {
     tagValue = sender.tag +1000;
     AppDelegate *objAppdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

     HACList *obj =[[HACList alloc] init];
     if (sender.tag==0) {
         obj.m_bIsCategory= YES;
         objAppdelegate.strSelectedSubCategory =@"";
         
        UITableView *tbl =( UITableView *)[self.view viewWithTag:123654];
         ResultCell *cell = (ResultCell *)[tbl cellForRowAtIndexPath:[NSIndexPath indexPathForRow:infoArray_.count-1 inSection:0]];
         
        objAppdelegate.strComments=cell.textValue_.text;
         _strComments = objAppdelegate.strComments;

         obj.m_arrList = dictCategories.allKeys;
         [self.navigationController pushViewController:obj animated:YES];

     }else{
         obj.m_bIsCategory= NO;
         if (strCategory) {
             if (![strCategory isEqualToString:@""]) {
                 obj.m_arrList = [dictCategories objectForKey:strCategory];
                 
                 UITableView *tbl =( UITableView *)[self.view viewWithTag:123654];
                 ResultCell *cell = (ResultCell *)[tbl cellForRowAtIndexPath:[NSIndexPath indexPathForRow:infoArray_.count-1 inSection:0]];
                 
                 objAppdelegate.strComments=cell.textValue_.text;
                 _strComments = objAppdelegate.strComments;
                 
                 [self.navigationController pushViewController:obj animated:YES];
             }else{
                 [self showAlert:@"Please select category first" withDelegate:nil];
             }
         }else{
             [self showAlert:@"Please select category first" withDelegate:nil];
         }
         
     }
     
 }



-(void) saveDetails:(id) sender{
    
    AppDelegate *obj = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    NSData *dataImage = UIImageJPEGRepresentation(obj.imageToProcess, 0.3f);

    
    NSMutableDictionary *dictBill = [[NSMutableDictionary alloc] init];
     [dictBill setObject:obj.strEmailIdUser forKey:@"user"];
    
    [dictBill setObject:dataImage forKey:@"imageData"];

    int i = 0;
    for (NSString *str in infoArray_) {
        NSLog(@"%@",str);
        NSString *strValue=@"";
        UITableView *tbl =(UITableView*) [self.view viewWithTag:123654];
        ResultCell *cell = (ResultCell *)[tbl cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (i<2) {
            if (cell.selectBtn.titleLabel.text.length>0){
              strValue = cell.selectBtn.titleLabel.text;
            }else{
                strValue = @"";
            }
        }
        else if (i == infoArray_.count -1){
            AppDelegate *obj = (AppDelegate*)[[UIApplication sharedApplication] delegate];

            if (obj.strComments) {
                strValue = obj.strComments;
            }else{
                strValue = @"";

            }
            
        }
        else{
            if (cell.textValue_.text.length>0) {
                strValue = cell.textValue_.text;
             }else{
                strValue = @"";
             }
        }
        [dictBill setObject:strValue forKey:[infoArray_ objectAtIndex:i]];

        i++;
 }
    
    mbProcess=[[MBProgressHUD alloc] initWithView:self.view];
    mbProcess.labelText=@"Saving invoice Details... ";
    [self.view addSubview:mbProcess];
    [mbProcess show:YES];
    
    
    [[HACCoreDataHelper sharedInstance] addValuesInProductCoreDataStack:dictBill withCompletionHandler:^(id results, NSError *err) {
        if (err) {
            dispatch_async(dispatch_get_main_queue(), ^(){
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self showAlert:err.description withDelegate:nil];

            });
        }else{
              [self uploadImagesDetails:dataImage withBillInfo:dictBill];

        }
        
       
    }];
    
    
}


- (void)uploadImagesDetails:(NSData*)pictureData withBillInfo:(NSDictionary *)dict{
    
    //Upload a new picture
    //1
    PFFile *file = [PFFile fileWithName:@"img" data:pictureData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            //2
            //Add the image to the object, and add the comment and the user
            PFObject *imageObject = [PFObject objectWithClassName:@"BillDetails"];
            [imageObject setObject:file forKey:@"image"];
            [imageObject setObject:dict[@"user"] forKey:@"emailId"];
            [imageObject setObject:dict[@"Category"] forKey:@"category"];
            [imageObject setObject:dict[@"Sub-category"] forKey:@"subCategory"];
            [imageObject setObject:dict[@"Merchant name"] forKey:@"merchantName"];
            [imageObject setObject:dict[@"Order number"] forKey:@"orderId"];
            [imageObject setObject:dict[@"Date Of Purchase"] forKey:@"dateOfOrder"];
            [imageObject setObject:dict[@"Total price"] forKey:@"amount"];
            [imageObject setObject:dict[@"Tags"] forKey:@"comments"];

            
            //            [imageObject setObject:self.commentTextField.text forKey:@"Comments"];
            //3
            [imageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                //4
                
                 if (succeeded){
                     dispatch_async(dispatch_get_main_queue(), ^(){
                         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                         [self showAlert:@"Data saved Successfully" withDelegate:self];
                         
                     });
                }
                else{
                     dispatch_async(dispatch_get_main_queue(), ^(){
                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                        NSString *errorString = [[error userInfo] objectForKey:@"error"];
                        [self showAlert:errorString withDelegate:nil];
                    });

                }
            }];
        }
        else{
            //5
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    } progressBlock:^(int percentDone) {
        NSLog(@"Uploaded: %d %%", percentDone);
    }];
}


@end
