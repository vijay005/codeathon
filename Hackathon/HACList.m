//
//  HACList.m
//  Hackathon
//
//  Created by Anil Kothari on 09/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import "HACList.h"
#import "AppDelegate.h"

@implementation HACList


#pragma mark - tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.m_arrList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier =@"List";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil) {
        
        // Load the top-level objects from the custom cell XIB.
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
 
    cell.textLabel.text = [self.m_arrList objectAtIndex:indexPath.row];
    
    return  cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_m_bIsCategory) {
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] setStrSelectedCategory: [self.m_arrList objectAtIndex:indexPath.row]];

    }else{
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] setStrSelectedSubCategory: [self.m_arrList objectAtIndex:indexPath.row]];
     }
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
