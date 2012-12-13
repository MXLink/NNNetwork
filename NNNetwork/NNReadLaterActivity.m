//
//  NNReadLaterActivity.m
//  NNNetwork
//
//  Copyright (c) 2012 Tomaz Nedeljko (http://nedeljko.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NNReadLaterActivity.h"
#import "NNOAuthCredential.h"

NSString * const NNReadLaterActivityType = @"NNReadLaterActivityType";

@implementation NNReadLaterActivity

#pragma mark -
#pragma mark Initialization

- (id)initWithCredential:(NNOAuthCredential *)credential
{
    self = [super init];
    if (self) {
        _credential = credential;
        _URLArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark UIActivity

- (NSString *)activityType
{
    return NNReadLaterActivityType;
}

- (NSString *)activityTitle
{
    return self.client.name;
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:NSStringFromClass([self class])];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    if (!self.credential && ![self.delegate respondsToSelector:@selector(readLaterActivityNeedsCredential:)]) {
        return NO;
    }
    
    for (id object in activityItems) {
        if ([object isKindOfClass:[NSURL class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id object in activityItems) {
        if ([object isKindOfClass:[NSURL class]]) {
            [_URLArray addObject:[object copy]];
        }
    }
}

- (void)performActivity
{
    if (!self.credential && [self.delegate respondsToSelector:@selector(readLaterActivityNeedsCredential:)]) {
        [self activityDidFinish:YES];
        [self.delegate readLaterActivityNeedsCredential:self];
        return;
    }
    
    for (NSURL *URL in self.URLArray) {
        NNReadLaterActivity *activity = self;
        [self.client addURL:URL withCredential:self.credential success:^(AFHTTPRequestOperation *operation) {
            if ([activity.delegate respondsToSelector:@selector(readLaterActivity:didFinishWithURL:operation:error:)]) {
                [activity.delegate readLaterActivity:activity didFinishWithURL:URL operation:operation error:nil];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([activity.delegate respondsToSelector:@selector(readLaterActivity:didFinishWithURL:operation:error:)]) {
                [activity.delegate readLaterActivity:activity didFinishWithURL:URL operation:operation error:error];
            }
        }];
    }
    [self activityDidFinish:YES];
}

@end
