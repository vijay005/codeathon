//
//  BillInfo.h
//  Hackathon
//
//  Created by Anil Kothari on 10/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BillInfo : NSManagedObject

@property (nonatomic, retain) NSString * merchantName;
@property (nonatomic, retain) NSString * orderId;
@property (nonatomic, retain) NSString * dateOfOrder;
@property (nonatomic, retain) NSString * amount;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * subCategory;
@property (nonatomic, retain) NSString * strEmailId;
@property (nonatomic, retain) NSData * imageData;

@end
