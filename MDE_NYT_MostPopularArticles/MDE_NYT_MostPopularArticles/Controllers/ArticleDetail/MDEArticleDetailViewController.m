//
//  MDEArticleDetailViewController.m
//  MDE_NYT_MostPopularArticles
//
//  Created by József Kern on 2017. 06. 28..
//  Copyright © 2017. wup. All rights reserved.
//

#import "MDEArticleDetailViewController.h"
#import "Media.h"   
#import "MediaMetaData.h"

@interface MDEArticleDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *articleDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;

@property (atomic,strong) UIImage* artImage;

@end

@implementation MDEArticleDetailViewController

#pragma mark - view initialization

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view configuration

- (void)loadImage:(NSString*)url {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
   ^{
       NSURL *imageURL = [NSURL URLWithString:url];
       NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
       dispatch_sync(dispatch_get_main_queue(), ^{
           self.artImage = [UIImage imageWithData:imageData];
           self.articleImage.image = self.artImage;
           
       });
   });
    
}

- (void)configureView {
    
    self.title = @"NY Times Most Popular";
    
    if(self.article) {
        self.articleTitleLabel.text = self.article.title;
        self.articleDescriptionLabel.text = self.article.abstract;
        Media *media = [ self.article.media firstObject];
        if(media) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"format == %@", @"mediumThreeByTwo440"];
            NSArray *filteredArray = [media.media_metadata filteredArrayUsingPredicate:predicate];
            MediaMetaData *firstFoundObject = [filteredArray firstObject];
            if( firstFoundObject ) {
                [self loadImage:firstFoundObject.url];
            }
        }
    }
}

@end
