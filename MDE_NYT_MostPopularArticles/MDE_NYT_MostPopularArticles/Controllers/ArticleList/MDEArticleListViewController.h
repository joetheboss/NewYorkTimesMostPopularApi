//
//  MDEArticleListViewController.h
//  MDE_NYT_MostPopularArticles
//
//  Created by József Kern on 2017. 06. 28..
//  Copyright © 2017. wup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class MDEArticleDetailViewController;

@interface MDEArticleListViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) MDEArticleDetailViewController *articleDetailViewController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

