//
//  MDEArticleListViewController.m
//  MDE_NYT_MostPopularArticles
//
//  Created by József Kern on 2017. 06. 28..
//  Copyright © 2017. wup. All rights reserved.
//
#import "MDEPopularArticleObjectManager.h"
#import "MDEArticleListViewController.h"
#import "MDEArticleDetailViewController.h"
#import "MDEArticleTableViewCell.h"
#import "Article.h"
#import "MediaMetaData.h"
#import "Media.h"


#import <RestKit/RestKit.h>


@interface MDEArticleListViewController ()

@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, strong) MDEPopularArticleObjectManager *popularArticleObjectManager;
@end

@implementation MDEArticleListViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popularArticleObjectManager = [MDEPopularArticleObjectManager sharedManager];

    // Setup View and Table View
    self.title = [NSString stringWithFormat:@"NY Times Most Popular: %@",[self.popularArticleObjectManager getSection]];
    self.tableView.separatorColor = [UIColor clearColor];
    
    [self loadData];
    
}

- (void)loadData
{
    // Load the object model via RestKit
    NSString* requestPath = [self.popularArticleObjectManager getRequestPath];
    NSDictionary *parameters = @{@"api-key":[self.popularArticleObjectManager getApiKey]};

    [[RKObjectManager sharedManager] getObjectsAtPath:requestPath
          parameters:parameters
          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
              self.articles = mappingResult.array;
              [self.tableView reloadData];
          }
          failure:^(RKObjectRequestOperation *operation, NSError *error) {
              [self MDEPopularArticleShowAlertWithError:error];
          }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    MDEArticleDetailViewController *controller = (MDEArticleDetailViewController *)[segue destinationViewController];
    if([self.articles count]) {
        controller.article = self.articles[indexPath.row];

    }
    controller.navigationItem.leftItemsSupplementBackButton = YES;
    
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.articles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDEArticleTableViewCell *cell = (MDEArticleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Article *article = self.articles[indexPath.row];
    cell.articleTitleLabel.text = article.title;
    cell.articleDateLabel.text = article.published_date;
    cell.articleByLabel.text = article.byline;
    if([article.media count]) {
        Media *media = [article.media firstObject];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"format == %@", @"Standard Thumbnail"];
        NSArray *filteredArray = [media.media_metadata filteredArrayUsingPredicate:predicate];
        MediaMetaData *firstFoundObject = [filteredArray firstObject];
        if( firstFoundObject ) {
            [cell loadImage:firstFoundObject.url];
        }
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


#pragma mark NSFetchedResultsControllerDelegate methods
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}
 
#pragma mark - utils

-(void)MDEPopularArticleShowAlertWithError:(NSError*)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:[error localizedDescription]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
