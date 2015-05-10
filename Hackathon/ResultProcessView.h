//
//  ResultProcessView.h
//  OcrSdkDemo
//
//  Created by Nitin Chauhan on 09/05/15.
//  Copyright (c) 2015 ABBYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultProcessView : UIViewController
{
    NSArray * infoArray_;
    NSMutableArray *resultArray_;
    NSArray *fetchingValueArray;

}
@property(nonatomic, strong) NSString *resultString;

@property(nonatomic, strong) NSString *strComments;

@end
