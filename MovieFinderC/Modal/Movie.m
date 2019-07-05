//
//  Movie.m
//  MovieFinderC
//
//  Created by Trevor Walker on 7/4/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

#import "Movie.h"

@implementation Movie
- (instancetype)initWithMovie:(NSString *)title voteAverage:(NSNumber *)voteAverage overview:(NSString *)overview imagePath:(NSString *)imagePath
{
    if (self = [super init]){
        _title = title;
        _voteAverage = voteAverage;
        _overview = overview;
        _imagePath = imagePath;
    }
    return self;
}
@end
