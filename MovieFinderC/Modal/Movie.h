//
//  Movie.h
//  MovieFinderC
//
//  Created by Trevor Walker on 7/4/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject
@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSNumber* voteAverage;
@property(nonatomic, copy)NSString* overview;
@property(nonatomic, copy)NSString* imagePath;

-(instancetype)initWithMovie:(NSString *)title
                 voteAverage:(NSNumber *)voteAverage
                    overview:(NSString *)overview
                   imagePath:(NSString *)imagePath;

@end

NS_ASSUME_NONNULL_END
