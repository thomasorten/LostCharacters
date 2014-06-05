//
//  CharacterTableViewCell.m
//  LostCharacters
//
//  Created by Thomas Orten on 6/3/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "CharacterTableViewCell.h"

@implementation CharacterTableViewCell

- (void)setLabels:(NSArray *)labels
{
    float itr = 17.0;
    for (NSString *labelText in labels) {
        UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake( itr, 30.0, 140.0, 44.0 )];
        tmpLabel.font = [UIFont systemFontOfSize: 12.0];
        tmpLabel.textColor = [UIColor darkGrayColor];
        tmpLabel.text = labelText;
        tmpLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        tmpLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview: tmpLabel];
        itr += 100.0;
    }
}

@end
