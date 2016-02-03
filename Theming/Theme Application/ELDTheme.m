//
//  ELDTheme.m
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

#import "ELDTheme.h"

@implementation ELDTheme
    {
    __strong NSMutableDictionary* _stylesByKey;
    __strong NSMutableArray* _styles;
    }

- (id) init
    {
    self =[super init];
    if (self)
        {
        _stylesByKey = [NSMutableDictionary new];
        _styles = [NSMutableArray new];
        }
    return (self);
    }

- (id) initWithStyles:(NSArray*)styles
   {
    self = [self init];
    if (self)
        {
        if ([styles count] > 0)
            {
            [_styles addObjectsFromArray:styles];
            for (ELDStyle* style in styles)
                {
                [_stylesByKey setObject:style forKey:[style key]];
                }
            }
        }
    return (self);
    }

- (void) setStyle:(ELDStyle*)style forKey:(NSString*)key
    {
    [self checkAndRemoveStyleWithSameKey:key];
    [_styles addObject:style];
    [_stylesByKey setObject:style forKey:key];
    }

- (ELDStyle*) styleForKey:(NSString*)key
    {
    return ([_stylesByKey objectForKey:key]);
    }

- (void) addStyle:(ELDStyle*) style
    {
    [self checkAndRemoveStyleWithSameKey:[style key]];
    [_styles addObject:style];
    [_stylesByKey setObject:style forKey:[style key]];
    }

- (void) applyToView: (UIView*) view
    {
    for (ELDStyle* style in _styles)
        {
        [style applyToView:view];
        }
    }

- (void) applyStyleWithName: (NSString*)styleName ToView: (UIView*) view
    {
    ELDStyle* style;
    
    style = [self styleForKey:styleName];
    [style applyToView:view];
    }

- (void) checkAndRemoveStyleWithSameKey:(NSString*)key
    {
    __block ELDStyle* styleToRemove;
    
    if (_stylesByKey[key] != nil)
        {
        [_styles enumerateObjectsUsingBlock:^(ELDStyle* obj, NSUInteger idx, BOOL *stop) {
            if([obj.key isEqualToString:key])
                {
                styleToRemove = obj;
                *stop = YES;
                }
            }];
        [_styles removeObject:styleToRemove];
        }
    }


- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState*)state objects:(__unsafe_unretained id[])stackbuf count:(NSUInteger)len
    {
    return ([_styles countByEnumeratingWithState:state objects:stackbuf count:len]);
    }

@end
