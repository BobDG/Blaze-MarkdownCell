//
//  BlazeMarkdownTableViewCell.h
//  Blaze
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <Blaze/BlazeTableViewCell.h>

@import TTTAttributedLabel;

@interface BlazeMarkdownTableViewCell : BlazeTableViewCell
{
    
}

@property(nonatomic,strong) IBOutlet TTTAttributedLabel *markdownLabel;

@end
