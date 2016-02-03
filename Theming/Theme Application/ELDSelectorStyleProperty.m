//
//  ELDSelectorStyleProperty.m
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

#import "ELDSelectorStyleProperty.h"
#import "NSObject+ELD_Theme_Extensions.h"

@implementation ELDSelectorStyleProperty
    {
    SEL _selector;
    __strong NSArray* _values;
    __strong NSString* _key;
    }


- (id) initWithSelector:(SEL)selector values:(NSArray*)values key:(NSString *)key
    {
    self = [self init];
    if (self)
        {
        _selector = selector;
        _values = values;
        _key = key;
        }
    return (self);
    }

- (void) applyToView:(UIView *)view
    {
    NSInvocation* invocation;
    NSObject* argument;
    void* primitivePointer;
    
    if ([view respondsToSelector:_selector] && _values.count > 0)
        {
        invocation = [NSInvocation invocationWithMethodSignature:[view methodSignatureForSelector:_selector]];
        [invocation setTarget:view];
        [invocation setSelector:_selector];
        for (int index=0; index < _values.count; index++)
            {
            argument = _values[index];
            if ([argument isPrimitiveHolder])
                {
                [(NSValue*)argument getValue:&primitivePointer];
                [invocation setArgument:&primitivePointer atIndex:(index+2)];
                }
            else
                {
                [invocation setArgument:&argument atIndex:(index+2)];
                }
            }
        [invocation invoke];
        }
    }

- (NSString*) key
    {
    return (_key);
    }

- (void) setKey:(NSString *)key
    {
    _key = key;
    }
@end
