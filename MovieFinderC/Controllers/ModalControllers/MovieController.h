//
//  MovieController.h
//  MovieFinderC
//
//  Created by Trevor Walker on 7/4/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface MovieController : NSObject
+(void)fetchMovies:(NSString *)term
        completion: (void (^) (NSArray <Movie *> *))completion;
+(void)fetchImageFromData:(NSString *)imagePath completion:(void (^)(NSData *imageData))completion;
@end

NS_ASSUME_NONNULL_END
