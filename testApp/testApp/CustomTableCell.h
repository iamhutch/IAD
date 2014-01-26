//
//  CustomTableCell.h
//  testApp
//
//  Created by Lucy Hutcheson on 1/25/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *subTitleLabel;
}
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLabel;


@end
