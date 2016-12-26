//
//  Coredata.m
//  calorieRun
//
//  Created by AravindKumar on 12/26/16.
//  Copyright © 2016 gowtham. All rights reserved.
//

#import "Coredata.h"
#import "FeedDetails.h"


#pragma mark - DB Detail

#define k_Link @"rssLink"
#define k_Name @"categoryName"

@implementation Coredata



+ (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

+(void)saveToDatabase
{
    // Save the object to persistent store
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}
+ (void)saveDetails:(NSString *)categoryName saveLink:(NSString *)rssLink
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDetail = [NSEntityDescription insertNewObjectForEntityForName:@"RssFeeds" inManagedObjectContext:context];
    
    [newDetail setValue:categoryName forKey:k_Name];
    [newDetail setValue:rssLink forKey:k_Link];
    
    [self saveToDatabase];
}

+ (NSMutableArray *)fetchDetails
{
    NSMutableArray * detailArray = [[NSMutableArray alloc]init];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"RssFeeds"];
    detailArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
     NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    for (NSManagedObject *object in detailArray)
    {
        FeedDetails *item = [[FeedDetails alloc] init];
        item.feedCategoryName = [object valueForKey:k_Name];
        item.feedRssLink = [object valueForKey:k_Link];
        
        [modelArray addObject:item];
    }

    return modelArray;
}

+(void)deleteDetail:(NSInteger)index
{
    NSMutableArray * userDetailArray = [[NSMutableArray alloc]init];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"RssFeeds"];
    userDetailArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];

   [managedObjectContext deleteObject:[userDetailArray objectAtIndex:index]];
         [self saveToDatabase];
}


@end
