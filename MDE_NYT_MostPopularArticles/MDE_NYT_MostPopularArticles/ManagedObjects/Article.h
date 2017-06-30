//
//  Article.h
//  MDE_NYT_MostPopularArticles
//
//  Created by József Kern on 2017. 06. 29..
//  Copyright © 2017. wup. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Media;

/*!
 * Article object.
 * This object hold the Articles data that come from results element from JSON.
 *
 */

@interface Article : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *section;
@property (nonatomic, strong) NSString *byline;
@property (nonatomic, strong) NSString *column;
@property (nonatomic, strong) NSString *abstract;
@property (nonatomic, strong) NSString *published_date;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray<Media*> *media;


@end
