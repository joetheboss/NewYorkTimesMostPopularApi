//
//  MediaMetaData.h
//  MDE_NYT_MostPopularArticles
//
//  Created by József Kern on 2017. 06. 29..
//  Copyright © 2017. wup. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * Media metadate object.
 * This object hold the meta datas that come from media_metadata element from JSON.
 *
 */

@interface MediaMetaData : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *format;

@end
