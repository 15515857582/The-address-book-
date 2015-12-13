//
//  ContactModel.h
//  通讯录Test
//
//  Created by apple on 15/12/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject<NSCoding>


@property(nonatomic,copy)NSString *nameStr;
@property(nonatomic,copy)NSString *iphoneStr;
@end
