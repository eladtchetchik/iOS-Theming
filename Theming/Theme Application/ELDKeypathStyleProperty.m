//
//  ELDKeypathStyleProperty.m
//  ELDTheming
//
//  Created by Elad Tchetchik on 1/29/16.
//  Copyright © 2016 elad. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ELDKeypathStyleProperty.h"
#import "NSObject+ELD_Theme_Extensions.h"

@implementation ELDKeypathStyleProperty
    {
    __strong NSString* _keypath;
    __strong id _value;
    __strong NSString* _key;
    }

- (id) initWithKeyPath:(NSString*) keyPath value:(id) value key:(NSString *)key
    {
    self = [self init];
    if (self)
        {
        _keypath = keyPath;
        _value = value;
        _key = key;
        }
    return (self);
    }

- (void) applyToView:(UIView *)view
    {
    [view setValue:_value forKeyPath:_keypath];
    }

- (NSString*) key
    {
    return (_key);
    }

@end
