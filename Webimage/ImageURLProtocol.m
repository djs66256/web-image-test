//
//  DDLogURLProtocol.m
//  Pods
//
//  Created by hzduanjiashun on 2017/3/6.
//
//

#import <UIKit/UIKit.h>
#import "ImageURLProtocol.h"

@interface ImageURLProtocol () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSURLConnection *connection;

@end

@implementation ImageURLProtocol
static NSString * const onceKey = @"ImageURLProtocol";

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([[self propertyForKey:onceKey inRequest:request] boolValue]) {
        return NO;
    }
    else {
        return YES;
    }
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *newReq = request.mutableCopy;
    [self setProperty:@YES forKey:onceKey inRequest:newReq];

    return newReq;
}

- (void)startLoading {
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request
                                                      delegate:self
                                              startImmediately:YES];
}

- (void)stopLoading {
    [self.connection cancel];
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [self.client URLProtocol:self didReceiveAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [self.client URLProtocol:self didCancelAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Finish Loading" message:self.request.URL.absoluteString delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

@end
