//
//  SharedVariables.m
//  RssReader
//
//  Created by AravindKumar on 12/26/16.
//  Copyright © 2016 DCI. All rights reserved.
//

#import "SharedVariables.h"

@implementation SharedVariables

#define screenSize [[UIScreen mainScreen] bounds]

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static SharedVariables * sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SharedVariables alloc] init];
        sharedInstance.categoryMutableArray = [[NSMutableArray alloc] init];
        sharedInstance.rssLinkMutableArray = [[NSMutableArray alloc] init];
        
    });
    return sharedInstance;
}

@end
