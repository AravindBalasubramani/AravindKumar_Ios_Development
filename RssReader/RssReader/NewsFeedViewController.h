
//
//  NewsFeedViewController.h
//  RssReader
//
//  Created by AravindKumar on 12/25/16.
//  Copyright © 2016 DCI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "UIViewController+RESideMenu.h"

@interface NewsFeedViewController : UIViewController<RESideMenuDelegate,NSXMLParserDelegate>
@property (weak, nonatomic) IBOutlet UILabel *navigationTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButtonOutlet;
@property (weak, nonatomic) IBOutlet UIView *navigationBarBaseView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)sideMenuButtonSelected:(id)sender;
- (IBAction)addCategorySelected:(id)sender;
@property (strong) UIActivityIndicatorView *mySpinner;

@property (strong) NSMutableString *mutableData;
@property NSMutableDictionary *item;
@property NSMutableArray *items;
@property NSInteger channelFlag;
@property NSMutableDictionary *channel;
@property NSXMLParser *parser;
@property (retain, nonatomic) NSString *url;

@end
