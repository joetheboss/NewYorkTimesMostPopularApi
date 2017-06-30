//
//  MDEObjectManagingProtocol.h
//  MDE_NYT_MostPopularArticles
//
//  Created by József Kern on 2017. 06. 29..
//  Copyright © 2017. wup. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * Object manager class.
 * This class give solutions that call the API-s and it help mapping datas to object.
 *
 */

@protocol MDEObjectManagingProtocol <NSObject>

/*!
 * Create and give instance the singleton.
 */
+ (id)sharedManager;

/*!
 * Init manager with Api url and Api parameters.
 *
 * @param url NSString Api url
 * @param params NSDictionar api parameters
 */
-(void)initWithUrlAndParams:(NSString*)url params:(NSDictionary*) params;

/*!
 * Get request path.
 * @return request path
 */
-(NSString*)getRequestPath;

/*!
 * Get Api key.
 * @return Api key
 */
-(NSString*)getApiKey;

/*!
 * Get Section ( NY times most popular api section )
 * @return section
 */
-(NSString*)getSection;
@end
