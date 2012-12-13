//
//  NNPocketActivity.h
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
#import "NNPocketClient.h"

extern NSString * const NNActivityTypeSendToPocket;

/**
 The `NNPocketActivity` class provides a way to display an activity for sending a set of URLs to Pocket. It uses the `sharedClient` from `NNPocketClient` class as the base client.
 
 By default, `NNPocketActivity` objects display a name, returned by `NNPocketClient`, and an image named `NNPocketActivity`.
 
 ## Subclassing Notes
 
 This class should almost never be subclassed. The only reason for subclassing `NNPocketActivity` is to provide a custom client, image or name for the activity.
 
 ### Methods to Override
 
 You should override the `client` property if you want to use a different client than the `sharedClient` returned by `NNPocketClient`.
 
 You should override `activityName` if you want to display a custom name in the `UIActivityViewController` instance.
 
 You should override `activityImage` if you want to display a custom image in the `UIActivityViewController` instance.
 */
@interface NNPocketActivity : NNReadLaterActivity

///-------------------------------------------
/// @name Accessing Pocket Activity Properties
///-------------------------------------------

/**
 Pocket client to display activity for.
 */
@property(strong, readonly, nonatomic) NNPocketClient *client;

@end
