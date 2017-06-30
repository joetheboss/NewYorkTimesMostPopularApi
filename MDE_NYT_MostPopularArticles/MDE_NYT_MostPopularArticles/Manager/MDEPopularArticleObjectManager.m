//
//  MDEPopularArticleObjectManager.m
//  MDE_NYT_MostPopularArticles
//
//  Created by József Kern on 2017. 06. 29..
//  Copyright © 2017. wup. All rights reserved.
//

#import "MDEPopularArticleObjectManager.h"
#import "Article.h"
#import "MediaMetaData.h"
#import "Media.h"

#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

@interface MDEPopularArticleObjectManager()

@property (nonatomic,strong) NSString *pattern;
@property (nonatomic,strong) NSString *apiKey;
@property (nonatomic,strong) NSString *baseUrl;
@property (nonatomic,strong) NSString *urlString;
@property (nonatomic,strong) NSString *requestPath;
@property (nonatomic,strong) NSString *section;
@property (nonatomic,strong) NSString *timePeriod;
@end

@implementation MDEPopularArticleObjectManager

#pragma mark - Initialization
+ (id)sharedManager {
    
    static MDEPopularArticleObjectManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void)initWithUrlAndParams:(NSString*)url params:(NSDictionary*) params {
    
    if(params) {
       
        self.section =[params objectForKey:@"section"];
        self.timePeriod = [params objectForKey:@"time_period"];
        self.apiKey = [params objectForKey:@"apiKey"];
        self.baseUrl = [params objectForKey:@"baseUrl"];
        self.urlString =[NSString stringWithFormat:@"%@%@/%@/%@.json?api-key=%@",self.baseUrl,url,self.section,self.timePeriod,self.apiKey];
        self.pattern =[NSString stringWithFormat:@"%@/:id/:id.json",url];
        self.requestPath = [NSString stringWithFormat:@"%@/%@/%@.json",url,self.section,self.timePeriod];
        [self initPopularArticlesObjectManager];

    }

}

-(void)initPopularArticlesObjectManager {
   
    // initialize AFNetworking HTTPClient
    NSURL *nsBaseURL = [NSURL URLWithString:self.baseUrl];
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:nsBaseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *articleMapping = [RKObjectMapping mappingForClass:[Article class]];
    [articleMapping addAttributeMappingsFromDictionary:@{ @"column": @"column",
                                                          @"section": @"section",
                                                          @"byline": @"byline",
                                                          @"type": @"type",
                                                          @"title": @"title",
                                                          @"abstract": @"abstract",
                                                          @"published_date": @"published_date",
                                                          @"source": @"source",
                                                          }];
    
    RKObjectMapping *mediaMapping = [RKObjectMapping mappingForClass:[Media class]];
    [mediaMapping addAttributeMappingsFromDictionary:@{ @"caption": @"caption",
                                                        @"type": @"type",
                                                        @"subtype": @"subtype",
                                                        @"copyright": @"copyright",
                                                        @"approved_for_syndication": @"approved_for_syndication"}];
    [articleMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"media" toKeyPath:@"media" withMapping:mediaMapping]];

    RKObjectMapping *mediaMetadataMapping = [RKObjectMapping mappingForClass:[MediaMetaData class]];
    [mediaMetadataMapping addAttributeMappingsFromDictionary:@{ @"url": @"url", @"format": @"format" }];
    [mediaMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"media-metadata" toKeyPath:@"media_metadata" withMapping:mediaMetadataMapping]];
    
    
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:self.pattern
                                                keyPath:@"results"
                                            statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

#pragma mark - utils

-(NSString*)getRequestPath {
    return self.requestPath;
}

-(NSString*)getApiKey {
    return self.apiKey;
}

-(NSString*)getSection {
    return self.section;
}


@end
