//
//  MDEArticleTableViewCell.h
//  MDE_NYT_MostPopularArticles
//
//  Created by József Kern on 2017. 06. 28..
//  Copyright © 2017. wup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDEArticleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mediaThumbNailImage;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleByLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleDateLabel;

/*!
 * Load cell image
 * @param url NSString Image url
 *
 */
- (void)loadImage:(NSString *)url;

@end
