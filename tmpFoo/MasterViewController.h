//
//  MasterViewController.h
//  tmpFoo
//
//  Created by Eduardo Alvarado Díaz on 10/23/14.
//  Copyright (c) 2014 Organization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

