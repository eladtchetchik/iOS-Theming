//
//  UIView (ELD_Extensions)
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

#import "UIView+ELD_Theme_Extensions.h"
#import "ELDThemeDecorator.h"
#import <objc/runtime.h>

@implementation UIView (Extensions)


#pragma mark - Style

- (void)setCustomStyle:(id)style
    {
    objc_setAssociatedObject(self, @"___customStyle", style, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [ELDThemeDecorator applyToView:self];
    }

- (id)customStyle
    {
    return objc_getAssociatedObject(self, @"___customStyle");
    }

- (void)setThemeWording:(NSString*)textProperty
    {
    objc_setAssociatedObject(self, @"___themeWording", textProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self respondsToSelector:NSSelectorFromString(textProperty)])
        {
        [self replaceThemeWordsInTextForProperty:textProperty];
        }
    }

- (BOOL) themeWording
    {
    return objc_getAssociatedObject(self, @"___customStyle");
    }


- (void) replaceThemeWordsInTextForProperty:(NSString*)propertyName
    {
    BOOL isOnAComponentToReplace;
    NSString* originalText;
    NSMutableString* modifiedText;
    NSArray* stringComponents;
    NSString* componentText;
    
    originalText = [self performSelector:NSSelectorFromString(propertyName)];

    isOnAComponentToReplace = NO;
    modifiedText = [NSMutableString new];
    stringComponents = [originalText componentsSeparatedByString:@"!!!"];
    
    for (int componentIndex = 0 ; componentIndex < [stringComponents count]; componentIndex++)
        {
        componentText = stringComponents[componentIndex];
        if (isOnAComponentToReplace)
            {
            componentText = [[NSBundle mainBundle] localizedStringForKey:componentText value:componentText table:@"ThemeWording"];
            }
        [modifiedText appendString:componentText];
        isOnAComponentToReplace = !isOnAComponentToReplace;
        }
    [self performSelector:NSSelectorFromString([self methodSetterNameStringFromGetterString:propertyName]) withObject:modifiedText];
    }


- (NSString*) firstLetterCapitalizedStringFromString:(NSString*) uncapitalisedString
    {
    NSMutableString* string;

    string = [NSMutableString stringWithString: uncapitalisedString];
    [string replaceCharactersInRange: NSMakeRange(0,1) withString: [NSString stringWithFormat: @"%c",toupper([uncapitalisedString characterAtIndex: 0])]];
    return(string);
    }


- (NSString*) methodSetterNameStringFromGetterString: (NSString*) getterString
    {
    return([NSString stringWithFormat: @"set%@:",[self firstLetterCapitalizedStringFromString:getterString]]);
    }


@end
