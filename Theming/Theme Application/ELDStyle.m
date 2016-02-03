//
//  ELDStyle.m
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

#import "ELDStyle.h"

@implementation ELDStyle
    {
    __strong NSMutableArray* _styleProperties;
    __strong NSMutableDictionary *_stylePropertiesByKey;
    __strong NSString* _key;
    }

- (id) init
    {
    self =[super init];
    if (self)
        {
        _styleProperties = [NSMutableArray new];
        _stylePropertiesByKey = [NSMutableDictionary new];
        _key = nil;
        }
    return (self);
    }

- (id) initWithStyleProperties:(NSArray*)styleProperties key:(NSString *)key
    {
    self = [self init];
    if (self)
        {
        _key = key;
        if ([styleProperties count] > 0)
            {
            [_styleProperties addObjectsFromArray:styleProperties];
            for (ELDStyleProperty* styleProperty in styleProperties)
                {
                [_stylePropertiesByKey setObject:styleProperty forKey:[styleProperty key]];
                }
            }
        }
    return (self);
    }


- (void) setStyleProperty:(ELDStyleProperty*)propertyStyle forKey:(NSString*)key
    {
    [_styleProperties addObject:propertyStyle];
    [_stylePropertiesByKey setObject:propertyStyle forKey:key];
    }

- (ELDStyleProperty*) propertyStyleForKey:(NSString*)key
    {
    return ([_stylePropertiesByKey objectForKey:key]);
    }

- (void) addStyleProperty:(ELDStyleProperty*) styleProperty
    {
    [_styleProperties addObject:styleProperty];
    [_stylePropertiesByKey setObject:styleProperty forKey:[styleProperty key]];
    }

- (void) applyToView: (UIView*) view
    {
    for (ELDStyleProperty* styleProperty in _styleProperties)
        {
        [styleProperty applyToView:view];
        }
    }

- (NSString*) key
    {
    return (_key);
    }


- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState*)state objects:(__unsafe_unretained id[])stackbuf count:(NSUInteger)len
    {
    return ([_styleProperties countByEnumeratingWithState:state objects:stackbuf count:len]);
    }

@end
