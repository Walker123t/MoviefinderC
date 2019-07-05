//
//  MovieController.m
//  MovieFinderC
//
//  Created by Trevor Walker on 7/4/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

#import "MovieController.h"
static NSString * const baseURLString = @"https://api.themoviedb.org/3/search/movie";
@implementation MovieController
+ (MovieController *)shared
{
    static MovieController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [MovieController new];
    });
    return shared;
}
- (void)fetchMovies:(NSString *)term completion:(void (^)(NSArray * _Nonnull))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *components = [NSURLComponents new];
    
}
@end
