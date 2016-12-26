//
//  LeftSideMenuViewController.h
//  Jil Jil
//
//  Created by AravindKumar on 12/25/16.
//  Copyright © 2016 DCI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "AddCategoryView.h"
#import "SharedVariables.h"

@interface LeftSideMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,RESideMenuDelegate,UIAlertViewDelegate>

@property(nonatomic) NSMutableArray * categotyArray;
@property(nonatomic) NSMutableArray * linkArray;
@property(nonatomic) NSArray * listArray;
@property(nonatomic) BOOL isSkiped;
@property(nonatomic) NSString * nameString;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong) UIActivityIndicatorView *mySpinner;
- (IBAction)addCategorySelected:(id)sender;
- (IBAction)DelectSelected:(id)sender;

@end
