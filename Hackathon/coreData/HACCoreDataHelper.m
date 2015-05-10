//
//  HACCoreDataHelper.m
//  Hackathon
//
//  Created by Anil Kothari on 09/05/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

#import "BillInfo.h"
#import "BillInfoModal.h"
#import "HACCoreDataHelper.h"

@implementation HACCoreDataHelper



+ (instancetype) sharedInstance{
    static dispatch_once_t onceToken ;
    static id sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HACCoreDataHelper alloc] init];
    });
    
    return sharedInstance;
}


#pragma mark - Methods for coredata
-(void) addValuesInProductCoreDataStack :(NSDictionary *) entity withCompletionHandler:(completionHandler)onTaskComplete{
    
    NSManagedObject *newEntity = nil;
    
    newEntity = [NSEntityDescription insertNewObjectForEntityForName:@"BillInfo" inManagedObjectContext:[self managedObjectContext]];
    
    
    [newEntity  setValue:entity[@"Category"] forKey:@"category"];
    [newEntity  setValue:entity[@"Tags"] forKey:@"comment"];
    [newEntity  setValue:entity[@"Date Of Purchase"] forKey:@"dateOfOrder"];
    [newEntity  setValue:entity[@"Merchant name"] forKey:@"merchantName"];
    [newEntity  setValue:entity[@"Order number"] forKey:@"orderId"];
    [newEntity  setValue:entity[@"Sub-category"] forKey:@"subCategory"];
    [newEntity  setValue:entity[@"Total price"] forKey:@"amount"];
    [newEntity  setValue:entity[@"user"] forKey:@"strEmailId"];
    [newEntity  setValue:entity[@"imageData"] forKey:@"imageData"];

    NSError *error= nil;
    
    [self.managedObjectContext save:&error];
    
    if (error) {
        onTaskComplete(nil,error);
        NSLog(@"could not save to coredata due to error: %@",error.description);
    }else{
        onTaskComplete(nil,nil);
    }
}

-(void) addValuesInCoreDataStack :(NSDictionary *) entity withCompletionHandler:(completionHandler)onTaskComplete{
    
    NSManagedObject *newEntity = nil;
    
    newEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Login" inManagedObjectContext:[self managedObjectContext]];
    
    [newEntity  setValue:entity[@"Email Id"] forKey:@"strEmailId"];
    [newEntity  setValue:entity[@"First Name"] forKey:@"strFirstName"];
    [newEntity  setValue:entity[@"Last Name"] forKey:@"strLastName"];
    [newEntity  setValue:entity[@"Password"] forKey:@"strPassword"];
    
    NSError *error= nil;
    
    [self.managedObjectContext save:&error];
    
    if (error) {
        onTaskComplete(nil,error);
     }else{
        onTaskComplete(nil,nil);
    }
}

-(void) fetchValuesCoreDataStackWithCompletionHandler:(completionHandler)onTaskComplete{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BillInfo" inManagedObjectContext:[self managedObjectContext]];
    
    NSFetchRequest *request =[[NSFetchRequest alloc] init];
    request.entity = entity;
    NSError *error= nil;
        
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
        
    if (!error) {
        onTaskComplete(results,nil);
        
    }else{
        onTaskComplete(nil,error);
        
    }
    
    
}

- (NSArray *)getSearchResultList:(NSDictionary *)searchDic{
    NSMutableArray *userList = [[NSMutableArray alloc] init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityRequest = [NSEntityDescription entityForName:@"BillInfo" inManagedObjectContext:context];
    
    
    NSMutableArray *parr = [NSMutableArray array];

    if ([[searchDic objectForKey:@"btnCategory"] length] > 0) {
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"category == %@",[searchDic objectForKey:@"btnCategory"]];
        [parr addObject:predicate];
    }
       if ([[searchDic objectForKey:@"subCategory"] length] > 0) {
     NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"subCategory == %@",[searchDic objectForKey:@"subCategory"]];
         [parr addObject:predicate1];

    }
         if ([[searchDic objectForKey:@"dateOfOrder"] length] > 0) {
     NSPredicate * predicate2 = [NSPredicate predicateWithFormat:@"dateOfOrder == %@",[searchDic objectForKey:@"dateOfOrder"]];
         [parr addObject:predicate2];

        }
             if ([[searchDic objectForKey:@"merchant"] length] > 0) {
     NSPredicate * predicate3 = [NSPredicate predicateWithFormat:@"merchantName == %@",[searchDic objectForKey:@"merchant"]];
              [parr addObject:predicate3];

            }
                 if ([[searchDic objectForKey:@"comment"] length] > 0) {
     NSPredicate * predicate4 = [NSPredicate predicateWithFormat:@"comment == %@",[searchDic objectForKey:@"comment"]];
                 [parr addObject:predicate4];

                }
                 

    if (parr.count>0) {
        NSPredicate *compoundpred = [NSCompoundPredicate andPredicateWithSubpredicates:parr];
        [fetchRequest setPredicate:compoundpred];

    }
    
    [fetchRequest  setEntity:entityRequest];
    
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    if (error != nil) {
        return nil;
    }
    else {
        for (BillInfo *billInfoObj in results) {
            BillInfoModal *model = [[BillInfoModal alloc] init];
            model.m_category  = billInfoObj.category;
            model.m_subCategory = billInfoObj.subCategory;
            model.m_dateOfOrder = billInfoObj.dateOfOrder;
            model.m_merchantName = billInfoObj.merchantName;
            model.m_orderId = billInfoObj.orderId;
            model.m_comment = billInfoObj.comment;
            model.m_price = billInfoObj.amount;
            model.m_strEmailId = billInfoObj.strEmailId;
            NSData * dataBytes = [billInfoObj imageData];
            
            model.m_billImage=  [UIImage imageWithData:dataBytes];
            [userList addObject:model];
        }
        return userList;
    }
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.warisoft.Hackathon.Hackathon" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Hackathon" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Hackathon.sqlite"];
    NSLog(@"------->>>>%@",storeURL);
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}



@end
