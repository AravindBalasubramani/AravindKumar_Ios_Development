//
//  Coredata.h
//  calorieRun
//
//  Created by AravindKumar on 12/26/16.
//  Copyright © 2016 gowtham. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface Coredata : NSManagedObject

+ (NSManagedObjectContext *)managedObjectContext;

+ (void)saveDetails:(NSString *)categoryName saveLink:(NSString *)rssLink;

+ (NSMutableArray *)fetchDetails;

+(void)deleteDetail:(NSInteger)index;

+(void)saveToDatabase;



@end
