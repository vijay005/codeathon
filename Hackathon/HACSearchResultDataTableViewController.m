//
//  HACSearchResultDataTableViewController.m
//  Hackathon
//
//  Created by Anil Kothari on 10/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import "HACSearchResultDataTableViewController.h"
#import "BillInfoModal.h"
#import "HACDetailedDescriptionViewController.h"

@interface HACSearchResultDataTableViewController ()

@end

@implementation HACSearchResultDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Search Results";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     // Return the number of rows in the section.
    return _m_arrSearchResult.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *objCell = [tableView dequeueReusableCellWithIdentifier:@"ResultData" forIndexPath:indexPath];
    
    // Configure the cell...
    if (objCell == nil) {
        objCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ResultData"];
    }
    
    
    BillInfoModal *model=[self.m_arrSearchResult objectAtIndex:indexPath.row];
    
    id lblAddressTitle= (id)[objCell.contentView viewWithTag:100];
    
    if ([lblAddressTitle isKindOfClass:[UIImageView class]]) {
        ((UIImageView *)lblAddressTitle).image=model.m_billImage;
    }
    
    
    lblAddressTitle= (id)[objCell.contentView viewWithTag:101];
    
    if ([lblAddressTitle isKindOfClass:[UITextView class]]) {
        ((UITextView *)lblAddressTitle).text=[NSString stringWithFormat:@"Purchased Item: %@ with Category %@  and Order ID %@ on price %@ from Merchant Name %@",model.m_subCategory, model.m_category, model.m_orderId ,model.m_dateOfOrder,  model.m_merchantName];;
    }
    
    
    
    return objCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HACDetailedDescriptionViewController *obj =[[HACDetailedDescriptionViewController alloc] init];
    BillInfoModal *model=[self.m_arrSearchResult objectAtIndex:indexPath.row];

    obj.image = model.m_billImage;
    [self.navigationController pushViewController:obj animated:YES];
    
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
