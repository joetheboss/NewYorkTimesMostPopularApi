//
//  MDEArticleTableViewCell.m
//  MDE_NYT_MostPopularArticles
//
//  Created by József Kern on 2017. 06. 28..
//  Copyright © 2017. wup. All rights reserved.
//

#import "MDEArticleTableViewCell.h"
@interface MDEArticleTableViewCell ()
@property (atomic, strong) UIImage *thumbnailImage;

@end

@implementation MDEArticleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.mediaThumbNailImage.layer.cornerRadius = self.mediaThumbNailImage.frame.size.width / 2;
    self.mediaThumbNailImage.clipsToBounds = YES;
}

- (void) loadImage:(NSString*)url {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
    ^{
       NSURL *imageURL = [NSURL URLWithString:url];
       NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
       dispatch_sync(dispatch_get_main_queue(), ^{
           self.thumbnailImage = [UIImage imageWithData:imageData];
           self.mediaThumbNailImage.image = self.thumbnailImage;
           
       });
    });

}

@end
