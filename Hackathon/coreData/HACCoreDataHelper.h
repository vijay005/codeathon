//
//  HACCoreDataHelper.h
//  Hackathon
//
//  Created by Anil Kothari on 09/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
typedef void (^completionHandler) (id results, NSError *err);

@interface HACCoreDataHelper : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype) sharedInstance;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;


# pragma mark coredata helper methods
-(void) addValuesInCoreDataStack :(NSDictionary *) entity withCompletionHandler:(completionHandler)onTaskComplete;
-(void) fetchValuesCoreDataStackWithCompletionHandler:(completionHandler)onTaskComplete;
-(void) addValuesInProductCoreDataStack :(NSDictionary *) entity withCompletionHandler:(completionHandler)onTaskComplete
    ;

- (NSArray *)getSearchResultList:(NSDictionary *)searchDic;
@end
