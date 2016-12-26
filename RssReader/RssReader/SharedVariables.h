//
//  SharedVariables.h
//  RssReader
//
//  Created by AravindKumar on 12/26/16.
//  Copyright © 2016 DCI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedVariables : NSObject

@property (nonatomic, retain) NSMutableArray * categoryMutableArray;
@property (nonatomic, retain) NSMutableArray * rssLinkMutableArray;

+ (instancetype)sharedInstance;

@end
