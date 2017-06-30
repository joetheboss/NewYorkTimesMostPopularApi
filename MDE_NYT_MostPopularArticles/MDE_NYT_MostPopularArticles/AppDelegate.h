//
//  AppDelegate.h
//  MDE_NYT_MostPopularArticles
//
//  Created by József Kern on 2017. 06. 28..
//  Copyright © 2017. wup. All rights reserved.
//

#import "MDEPopularArticleObjectManager.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MDEPopularArticleObjectManager *popularArticleManager;


@end

