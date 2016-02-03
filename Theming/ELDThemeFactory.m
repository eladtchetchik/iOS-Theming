//
//  ELDThemeFactory.m
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

#import "ELDThemeFactory.h"
#import "ELDKeypathStyleProperty.h"
#import "ELDSelectorStyleProperty.h"

@implementation ELDThemeFactory

+ (ELDTheme*) sampleThemeOne
    {
    ELDStyle* labelStyleOne;
    ELDStyle* buttonStyleOne;
    ELDStyle* backgroundViewStyle;
    ELDTheme* theme;
    
    labelStyleOne = [self labelStyleWithName:@"labelStyleOne" textColor:[UIColor whiteColor] backgroundColor:[UIColor blackColor]
											   fontSize:14.0f];
    backgroundViewStyle = [self filledViewStyleWithName:@"backgroundViewStyle" backgroundColor:[UIColor blackColor]];
    buttonStyleOne = [self unborderedButtonStyleWithName:@"buttonStyleOne" titleColor:[UIColor whiteColor] fillColor:[UIColor darkGrayColor] cornerRadius:0.0f];

    theme = [[ELDTheme alloc] initWithStyles:@[labelStyleOne, backgroundViewStyle, buttonStyleOne]];
    return (theme);
    }

+ (ELDTheme*) sampleThemeTwo
    {
    ELDStyle* labelStyleOne;
    ELDStyle* buttonStyleOne;
    ELDStyle* backgroundViewStyle;
    ELDTheme* theme;

    
    labelStyleOne = [self labelStyleWithName:@"labelStyleOne" textColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] fontSize:10.0f];
    [labelStyleOne addStyleProperty:[self cornerRadiusStylePropertyWithRadius:10.0f]];
    [labelStyleOne addStyleProperty:[self clipsToBoundsStylePropertyWithBoolean:YES]];
    backgroundViewStyle = [self filledViewStyleWithName:@"backgroundViewStyle" backgroundColor:[UIColor greenColor]];
    buttonStyleOne = [self borderedButtonStyleWithName:@"buttonStyleOne" titleColor:[UIColor blackColor] fillColor:[UIColor whiteColor] cornerRadius:5.0f borderWidth:2.0f borderColor:[UIColor blackColor]];

    theme = [[ELDTheme alloc] initWithStyles:@[labelStyleOne, backgroundViewStyle, buttonStyleOne]];
    return (theme);
    }


+ (ELDStyle*) unborderedButtonStyleWithName:(NSString*)styleName titleColor:(UIColor*)titleColor fillColor:(UIColor*)fillColor cornerRadius:(CGFloat)cornerRadius
    {
    UIControlState controlState = UIControlStateNormal;
    const void* primitivePointer = &controlState;
    
    ELDStyle* buttonStyle;
    ELDSelectorStyleProperty* buttonStyleBackgroundColourProperty;
    ELDSelectorStyleProperty* buttonStyleTitleColorProperty;
    ELDKeypathStyleProperty* cornerRadiusProperty;
    
    cornerRadiusProperty = [self cornerRadiusStylePropertyWithRadius:cornerRadius];
    buttonStyleBackgroundColourProperty = [self viewBackgroundStylePropertyWithColor:fillColor name:@"buttonBackgroundColor"];
    buttonStyleTitleColorProperty = [[[ELDSelectorStyleProperty alloc] init] initWithSelector:@selector(setTitleColor:forState:) values:@[titleColor,[NSValue value:primitivePointer withObjCType:@encode(int*)]] key:@"buttonTitleColor"];
    buttonStyle = [[ELDStyle alloc] initWithStyleProperties:@[buttonStyleBackgroundColourProperty,buttonStyleTitleColorProperty, cornerRadiusProperty]  key:styleName];
    return (buttonStyle);
    }

+ (ELDStyle*) unborderedButtonStyleWithName:(NSString*)styleName titleColor:(UIColor*)titleColor fillColor:(UIColor*)fillColor fontSize:(CGFloat)fontSize   cornerRadius:(CGFloat)cornerRadius
    {
    ELDStyle* buttonStyle;
    ELDKeypathStyleProperty* fontSizeProperty;

    fontSizeProperty = [self buttonFontSizeStylePropertyWithSize:fontSize];
    buttonStyle= [self unborderedButtonStyleWithName:styleName titleColor:titleColor fillColor:fillColor cornerRadius:cornerRadius];
    [buttonStyle addStyleProperty:fontSizeProperty];
    return (buttonStyle);
    }


+ (ELDStyle*) borderedButtonStyleWithName:(NSString*)styleName titleColor:(UIColor*)titleColor fillColor:(UIColor*)fillColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor
    {
    ELDStyle* buttonStyle;
    ELDKeypathStyleProperty* borderWidthProperty;
    ELDKeypathStyleProperty* borderColorProperty;
    
    borderWidthProperty = [self borderWidthStylePropertyWithWidth:borderWidth];
    borderColorProperty = [self borderColorStylePropertyWithColor:borderColor];
    buttonStyle= [self unborderedButtonStyleWithName:styleName titleColor:titleColor fillColor:fillColor cornerRadius:cornerRadius];
    [buttonStyle addStyleProperty:borderWidthProperty];
    [buttonStyle addStyleProperty:borderColorProperty];
    return (buttonStyle);
    }

+ (ELDStyle*) borderedButtonStyleWithName:(NSString*)styleName titleColor:(UIColor*)titleColor fillColor:(UIColor*)fillColor fontSize:(CGFloat)fontSize   cornerRadius:(CGFloat)cornerRadius
    {
    ELDStyle* buttonStyle;
    ELDKeypathStyleProperty* fontSizeProperty;

    fontSizeProperty = [self buttonFontSizeStylePropertyWithSize:fontSize];
    buttonStyle= [self unborderedButtonStyleWithName:styleName titleColor:titleColor fillColor:fillColor cornerRadius:cornerRadius];
    [buttonStyle addStyleProperty:fontSizeProperty];
    return (buttonStyle);
    }

+ (ELDStyle*) borderedViewStyleWithName:(NSString*)styleName fillColor:(UIColor*)fillColor cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor*)borderColor borderWidth: (CGFloat) borderWidth
    {
    ELDStyle* viewStyle;
    ELDKeypathStyleProperty* cornerRadiusProperty;
    ELDSelectorStyleProperty* backgroundColorProperty;
    ELDKeypathStyleProperty* borderColorProperty;
    ELDKeypathStyleProperty* borderWidthProperty;
    
    cornerRadiusProperty = [self cornerRadiusStylePropertyWithRadius:cornerRadius];
    backgroundColorProperty = [self viewBackgroundStylePropertyWithColor:fillColor];
    borderColorProperty = [self borderColorStylePropertyWithColor:borderColor];
    borderWidthProperty = [self borderWidthStylePropertyWithWidth:borderWidth];
        
    viewStyle= [[ELDStyle alloc] initWithStyleProperties:@[cornerRadiusProperty,backgroundColorProperty,borderColorProperty, borderWidthProperty] key:styleName];
    return (viewStyle);
    }


+ (ELDKeypathStyleProperty*) buttonFontSizeStylePropertyWithSize: (CGFloat) fontSize
    {
    return ([[ELDKeypathStyleProperty alloc] initWithKeyPath:@"titleLabel.font" value:[UIFont systemFontOfSize:fontSize] key:@"ButtonFontSize"]);
    }

+ (ELDKeypathStyleProperty*) clipsToBoundsStylePropertyWithBoolean: (BOOL) mustClipToBounds
    {
    return ([[ELDKeypathStyleProperty alloc] initWithKeyPath:@"clipsToBounds" value:@(mustClipToBounds) key:@"clipsToBounds"]);
    }

+ (ELDKeypathStyleProperty*) cornerRadiusStylePropertyWithRadius: (CGFloat) cornerRadius
    {
    return ([[ELDKeypathStyleProperty alloc] initWithKeyPath:@"layer.cornerRadius" value:@(cornerRadius) key:@"cornerRadius"]);
    }

+ (ELDKeypathStyleProperty*) borderWidthStylePropertyWithWidth: (CGFloat) width
    {
    return ([[ELDKeypathStyleProperty alloc] initWithKeyPath:@"layer.borderWidth" value:@(width) key:@"borderWidth"]);
    }

+ (ELDKeypathStyleProperty*) borderColorStylePropertyWithColor: (UIColor*) borderColor
    {
    return ([[ELDKeypathStyleProperty alloc] initWithKeyPath:@"layer.borderColor" value:borderColor.CGColor key:@"borderColor"]);
    }

+ (ELDSelectorStyleProperty*) viewBackgroundStylePropertyWithColor: (UIColor*) color
    {
    return ([[ELDSelectorStyleProperty alloc] initWithSelector:@selector(setBackgroundColor:) values:@[color] key:@"backgroundColor"]);
    }

+ (ELDSelectorStyleProperty*) viewBackgroundStylePropertyWithColor: (UIColor*)color name:(NSString*) name
    {
    ELDSelectorStyleProperty* backgroundColorProperty;
    
    backgroundColorProperty = [self viewBackgroundStylePropertyWithColor:color];
    backgroundColorProperty.key = name;
    return (backgroundColorProperty);
    }

+ (ELDSelectorStyleProperty*) textColorStylePropertyWithColor:(UIColor*) color
    {
    return ([[ELDSelectorStyleProperty alloc] initWithSelector:@selector(setTextColor:) values:@[color] key:@"labelTextColor"]);
    }

+ (ELDStyle*) labelStyleWithName:(NSString*)styleName textColor:(UIColor*)textColor backgroundColor:(UIColor*) backgroundColor
    {
    ELDStyle* labelStyle;
    ELDSelectorStyleProperty* labelColorProperty;
    ELDSelectorStyleProperty* backgroundColorProperty;

    backgroundColorProperty = [self viewBackgroundStylePropertyWithColor:backgroundColor];
    labelColorProperty = [self textColorStylePropertyWithColor:textColor];
    labelStyle= [[ELDStyle alloc] initWithStyleProperties:@[backgroundColorProperty, labelColorProperty]  key:styleName];
    return (labelStyle);
    }

+ (ELDStyle*) labelStyleWithName:(NSString*)styleName textColor:(UIColor*)textColor backgroundColor:(UIColor*) backgroundColor fontSize:(CGFloat)fontSize
    {
    ELDKeypathStyleProperty* fontSizeProperty;
    ELDStyle* labelStyle;
    
    fontSizeProperty = [[ELDKeypathStyleProperty alloc] initWithKeyPath:@"font" value:[UIFont systemFontOfSize:fontSize] key:@"fontSize"];
    labelStyle = [self labelStyleWithName:styleName textColor:textColor backgroundColor:backgroundColor];
    [labelStyle addStyleProperty:fontSizeProperty];
    
    return (labelStyle);
    }


+ (ELDStyle*) filledViewStyleWithName: (NSString*) styleName backgroundColor:(UIColor*) backgroundColor
    {
    ELDStyle* viewStyle;
    ELDSelectorStyleProperty* backgroundColorProperty;
    
    backgroundColorProperty = [self viewBackgroundStylePropertyWithColor:backgroundColor];
    viewStyle = [[ELDStyle alloc] initWithStyleProperties:@[backgroundColorProperty] key:styleName];
    return (viewStyle);
    }

+ (ELDStyle*) textFieldStyleWithName:(NSString*) styleName textColor:(UIColor*) textColor backgroundColor:(UIColor*) backgroundColor
    {
    ELDStyle* textfieldStyle;
    ELDSelectorStyleProperty* textColorProperty;
    ELDSelectorStyleProperty* backgroundColorProperty;
    
    backgroundColorProperty = [self viewBackgroundStylePropertyWithColor:backgroundColor];
    textColorProperty = [self textColorStylePropertyWithColor:textColor];
    textfieldStyle= [[ELDStyle alloc] initWithStyleProperties:@[backgroundColorProperty, textColorProperty]  key:styleName];
    return (textfieldStyle);
    }




@end

