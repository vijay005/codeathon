//
//  Login.h
//  Hackathon
//
//  Created by Anil Kothari on 09/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Login : NSManagedObject

@property (nonatomic, retain) NSString * strEmailId;
@property (nonatomic, retain) NSString * strFirstName;
@property (nonatomic, retain) NSString * strLastName;
@property (nonatomic, retain) NSString * strPassword;

@end
