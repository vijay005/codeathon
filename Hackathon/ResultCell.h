//
//  ResultCell.h
//  OcrSdkDemo
//
//  Created by Nitin Chauhan on 09/05/15.
//  Copyright (c) 2015 ABBYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultCell : UITableViewCell<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLbl_;
@property (weak, nonatomic) IBOutlet UITextView *textValue_;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

-(void)ShowPickerView;


@end
