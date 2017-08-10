//
//  BlazeMarkdownTableViewCell.m
//  Blaze
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "TSMarkdownParser.h"
#import "BlazeMarkdownRow.h"
#import "BlazeMarkdownTableViewCell.h"

@interface BlazeMarkdownTableViewCell () <TTTAttributedLabelDelegate>
{
    
}

@property(nonatomic,strong) TSMarkdownParser *parser;

@end

@implementation BlazeMarkdownTableViewCell

#pragma mark - Update

-(void)updateCell
{
    //Get markdown row
    BlazeMarkdownRow *row = (BlazeMarkdownRow *)self.row;
    
    //Get string
    if(row.markdownString.length) {
        if(!self.parser) {
            self.parser = [TSMarkdownParser standardParser];
        }
        
        //TextColor
        UIColor *textColor;
        if(row.markdownTextColor) {
            textColor = row.markdownTextColor;
        }
        else {
             textColor = [UIColor blackColor];
        }
        
        //LinksColor
        UIColor *linksColor;
        if(row.markdownLinksColor) {
            linksColor = row.markdownLinksColor;
        }
        else {
            linksColor = [UIColor blueColor];
        }
        
        //HeaderColor
        UIColor *headersColor;
        if(row.markdownHeaderColor) {
            headersColor = row.markdownHeaderColor;
        }
        else {
            headersColor = textColor;
        }
        
        //Default font
        UIFont *defaultFont;
        if(row.markdownDefaultFont) {
            defaultFont = row.markdownDefaultFont;
        }
        else {
            defaultFont = [UIFont systemFontOfSize:16.0f];
        }
        
        //Bold font
        UIFont *boldFont;
        if(row.markdownBoldFont) {
            boldFont = row.markdownBoldFont;
        }
        else {
            boldFont = [UIFont boldSystemFontOfSize:16.0f];
        }
        
        //Italic font
        UIFont *italicFont;
        if(row.markdownItalicFont) {
            italicFont = row.markdownItalicFont;
        }
        else {
            italicFont = [UIFont italicSystemFontOfSize:16.0f];
        }
        
        //Header attributes
        NSMutableArray <NSDictionary *> *headerAttributes = [NSMutableArray new];
        if(row.markdownHeaderFonts) {
            //headerAttributes = row.markdownHeaderFonts;
            for(UIFont *font in row.markdownHeaderFonts) {
                [headerAttributes addObject:@{NSFontAttributeName:font, NSForegroundColorAttributeName:textColor}];
            }
        }
        else {
            [headerAttributes addObjectsFromArray:@[@{NSFontAttributeName:[UIFont systemFontOfSize:22.0f], NSForegroundColorAttributeName:headersColor},
              @{NSFontAttributeName:[UIFont systemFontOfSize:21.0f], NSForegroundColorAttributeName:headersColor},
              @{NSFontAttributeName:[UIFont systemFontOfSize:20.0f], NSForegroundColorAttributeName:headersColor},
              @{NSFontAttributeName:[UIFont systemFontOfSize:19.0f], NSForegroundColorAttributeName:headersColor},
              @{NSFontAttributeName:[UIFont systemFontOfSize:18.0f], NSForegroundColorAttributeName:headersColor},
              @{NSFontAttributeName:[UIFont systemFontOfSize:17.0f], NSForegroundColorAttributeName:headersColor}]];
        }
        
        //Parser attributes
        self.parser.defaultAttributes = @{NSFontAttributeName:defaultFont, NSForegroundColorAttributeName:textColor};
        self.parser.headerAttributes = headerAttributes;
        
        //Bullet lists
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.headIndent = 28;
        NSDictionary *listAttributes = @{NSFontAttributeName:defaultFont, NSForegroundColorAttributeName:textColor, NSParagraphStyleAttributeName:style};
        self.parser.listAttributes = @[listAttributes];
        
        //Numbered lists
        NSMutableParagraphStyle *numberedStyle = [NSMutableParagraphStyle new];
        numberedStyle.headIndent = 28;
        NSDictionary *numberedListAttributes = @{NSFontAttributeName:defaultFont, NSForegroundColorAttributeName:textColor, NSParagraphStyleAttributeName:numberedStyle};
        self.parser.numberedListAttributes = @[numberedListAttributes];
        
        //Links
        self.parser.skipLinkAttribute = FALSE;
        self.parser.strongAttributes = @{NSFontAttributeName:boldFont, NSForegroundColorAttributeName:textColor};
        self.parser.emphasisAttributes = @{NSFontAttributeName:italicFont, NSForegroundColorAttributeName:textColor};
        self.parser.linkAttributes = @{NSFontAttributeName:defaultFont, NSForegroundColorAttributeName:linksColor};
        
        //Generate string
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[self.parser attributedStringFromMarkdown:row.markdownString]];
        
        //Finally set it
        self.markdownLabel.text = attributedString;
        
        //TTT-AttributedLabel link attributes, necessary after setting text
        self.markdownLabel.linkAttributes = @{NSFontAttributeName:defaultFont, NSForegroundColorAttributeName:linksColor};
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //Delegate
    self.markdownLabel.delegate = self;
    
    //Performance boost
    self.markdownLabel.extendsLinkTouchArea = FALSE;
    
    //Text checking types - only link, address & phonenumber for now
    self.markdownLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink|NSTextCheckingTypeAddress|NSTextCheckingTypePhoneNumber;
}

#pragma mark - TTTAttributedLabelDelegate

-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    BlazeMarkdownRow *row = (BlazeMarkdownRow *)self.row;
    if(row.linkTapped) {
        row.linkTapped(url);
    }
}

-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents
{
    BlazeMarkdownRow *row = (BlazeMarkdownRow *)self.row;
    if(row.addressTapped) {
        row.addressTapped(addressComponents);
    }
}

-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    BlazeMarkdownRow *row = (BlazeMarkdownRow *)self.row;
    if(row.phoneNumberTapped) {
        row.phoneNumberTapped(phoneNumber);
    }
}


@end



















































