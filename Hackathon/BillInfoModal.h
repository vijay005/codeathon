//
//  BillInfoModal.h
//  Hackathon
//
//  Created by Nitin Chauhan on 10/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BillInfoModal : NSObject

@property (nonatomic, copy) NSString * m_category;
@property (nonatomic, copy) NSString * m_subCategory;
@property (nonatomic, copy) NSString * m_dateOfOrder;
@property (nonatomic, copy) NSString * m_merchantName;
@property (nonatomic, copy) NSString * m_comment;
@property (nonatomic, copy) NSString * m_orderId;
@property (nonatomic, copy) NSString * m_price;

@property (nonatomic, copy)  UIImage * m_billImage;
@property (nonatomic, copy) NSString * m_strEmailId;

@end
