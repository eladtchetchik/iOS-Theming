# Theming for IOS 

## Quick and Easy Set of Classes to Theme all Aspects of an iOS Application

This project aims at providing a bunch of class extensions and theming classes to quickly apply a theme to an app. It plugs in to Interface builder, through runtime attributes to make theming even easier. It does require some initial setup, but once setup completely changing the look and feel of the app as well as the wording and names is painless.

**Version 1.0**

## How do I get set up?

Clone this project

`git clone https://eladtchetchik@bitbucket.org/eladtchetchik/ios-theming.git`

Copy the files in the _Theme Application_ folder to somewhere in your project and add the attached files to your project. 
Use the sample code from the ELDThemeFactory in the cloned project to create a theme, and set it on the __ELDThemeDecorator__. This must happen when the app starts up if you want your first views to be themed.  
In interface builder add runtime properties to the views you want to theme. The properties must be called **customStyle** and their values must be the keys of the styles you want applied to them as defined in your custom theme. 

To theme the words add a **themeWording** runtime property and make the value the property of the view item whose words need to be changed. Words that needs to be themed in must be encapsulated by three exclamation marks on each side. The value of the word to be themed must be placed in the themeWording file.

## Example ##

To see the theming of views and words and action, look at the sample project declined. In the app delegate change the code between the two themes to see how the theme quickly changes. 

`   [ELDThemeDecorator setTheme:[ELDThemeFactory sampleThemeOne]];`       

`//    [ELDThemeDecorator setTheme:[ELDThemeFactory sampleThemeTwo]];`

To change the theme name as displayed in the UILabel and UITextfield, modify the value in the _ThemeWording.strings_ file.

To see how easy it is to theme once setup, add a button to the view and add a runtime attribute to it called **customStyle** with a string value of "buttonStyleOne". Run the app and the button is themed the same as the other button.

If you want to add a themed view through code you can set its custom style property with the name of the style you want applied to it in code and the style will be applied.


### The Basics ###

An app will have a ELDTheme object that is set on the ELDThemeDecorator. An ELDTheme is composed of ELDStyles, and an ELDStyle is composed of ELDStyleProperties. It is also possible to compose a ELDStyle with ELDSyles. At runtime a themed view will ask the ELDThemeDecorator to apply the specific style it has stored in its customStyle property, to itself.  

### Future Changes

I will soon add code to quickly link in different theme packages to allow for static Theme definitions and ThemeWordings files that can be quickly switched in and out. This will also allow for theming images and assets.

#### Code Support 

This project is created in Objective-C and has been tested on iOS 6 and above

#### Who do I talk to?

For any queries please contact me on eladtche@gmail.com

### Credits 
I would like to thank Rudi Grobler for helping me with this. The base idea is based on his [Project](https://github.com/rudigrobler/iXAML)
