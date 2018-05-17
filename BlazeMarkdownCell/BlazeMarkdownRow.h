//
//  BlazeMarkdownRow.h
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <Blaze/BlazeRow.h>

@interface BlazeMarkdownRow : BlazeRow
{
    
}

//String
@property(nonatomic,strong) NSString *markdownString;

//Alignment
@property(nonatomic,strong) NSNumber *textAlignment;

//Fonts
@property(nonatomic,strong) UIFont *markdownBoldFont;
@property(nonatomic,strong) UIFont *markdownItalicFont;
@property(nonatomic,strong) UIFont *markdownDefaultFont;
@property(nonatomic,strong) NSArray <UIFont *> *markdownHeaderFonts;

//Colors
@property(nonatomic,strong) UIColor *markdownTextColor;
@property(nonatomic,strong) UIColor *markdownLinksColor;
@property(nonatomic,strong) UIColor *markdownHeaderColor;
@property(nonatomic,strong) UIColor *markdownActiveLinksColor;

//Callbacks
@property(nonatomic,copy) void (^linkTapped)(NSURL *url);
@property(nonatomic,copy) void (^addressTapped)(NSDictionary *addressComponents);
@property(nonatomic,copy) void (^phoneNumberTapped)(NSString *phoneNumber);

@end
