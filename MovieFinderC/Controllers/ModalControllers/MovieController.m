//
//  MovieController.m
//  MovieFinderC
//
//  Created by Trevor Walker on 7/4/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

#import "MovieController.h"
//setting up my URL's
static NSString * const baseURLString = @"https://api.themoviedb.org/3/search/movie";
static NSString *const baseImageURL = @"http://image.tmdb.org/t/p/w500";
@implementation MovieController
//setting up my fetchMovies func
+ (void)fetchMovies:(NSString *)term completion:(void (^)(NSArray <Movie *> *))completion
{
    //setting base URL
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    //adding components/ querys to URL
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *search = [NSURLQueryItem queryItemWithName:@"query" value:term];
    NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:@"4a2e71d84437a37e1a22d55d024f3ebc"];
    components.queryItems = @[apiKey, search];
    //setting final URL
    NSURL *finalURL = components.URL;
    //starting a data session
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //error handling
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        //making sure we have data
        if (data){
            //setting up json decoder thing
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:&error];
            //grabbing first level dictionary
            NSMutableArray *moviesArray = [NSMutableArray new];
            //looping through results
            for (NSDictionary *movieDictionary in jsonDictionary[@"results"]) {
                //fixing bug where movies doesn't have image
                NSString *image = movieDictionary[@"poster_path"];
                if (image == (id)[NSNull null]){
                    image = @"";
                }
                //creating movie object
                Movie *movie = [[Movie alloc] initWithMovie: movieDictionary[@"title"] voteAverage: movieDictionary[@"vote_average"] overview: movieDictionary[@"overview"] imagePath:image];
                //adding movie to array
                [moviesArray addObject:movie];
            }
            //sending out data
            completion(moviesArray);
            return;
        }
        completion(nil);
    }]resume];
}
+ (void)fetchImageFromData:(NSString *)imagePath completion:(void (^)(NSData *))completion
{
    //url stuff
    NSURL *baseURL = [NSURL URLWithString:baseImageURL];
    NSURL *url = [baseURL URLByAppendingPathComponent:imagePath];
    //data session
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"Error fetching images: %@", error);
            return completion(nil);
        }
        if(!data){
            NSLog(@"Error fetching images: %@", error);
            return completion(nil);
        }
        //passing data
        completion(data);
    }]resume];
}
@end
