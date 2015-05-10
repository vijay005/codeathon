//
//  ResultCell.m
//  OcrSdkDemo
//
//  Created by Nitin Chauhan on 09/05/15.
//  Copyright (c) 2015 ABBYY. All rights reserved.
//

#import "ResultCell.h"

@implementation ResultCell
{
    UIPickerView *picker;
    
    NSDictionary *dictCategories;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
   
    // Initialization code
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
-(void)ShowPickerView
{
    picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    picker.dataSource = self;
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [dictCategories.allKeys count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    [_textValue_ setText:[dictCategories.allKeys objectAtIndex:row]];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component
{
    return [dictCategories.allKeys objectAtIndex:row];
}
*/
@end
