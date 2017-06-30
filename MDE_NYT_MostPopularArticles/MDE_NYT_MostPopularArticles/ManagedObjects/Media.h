//
//  Media.h
//  MDE_NYT_MostPopularArticles
//
//  Created by József Kern on 2017. 06. 29..
//  Copyright © 2017. wup. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MediaMetaData;

/*!
 * Media object.
 * This object hold the Media datas that come from media element from JSON.
 *
 */

@interface Media : NSObject

@property (nonatomic, strong) NSString* caption;
@property (nonatomic, strong) NSArray<MediaMetaData*> *media_metadata;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* subtype;
@property (nonatomic, strong) NSString* copyright;
@property (nonatomic, assign) NSInteger approved_for_syndication;

@end
