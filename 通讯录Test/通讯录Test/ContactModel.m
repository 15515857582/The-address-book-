//
//  ContactModel.m
//  通讯录Test
//
//  Created by apple on 15/12/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel


//归档  解档的方法
/*
    将某个文件写入文件的时候会调用
 在这个方法中说清楚哪些属性需要存储
*/
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.nameStr forKey:@"name"];
    [aCoder encodeObject:self.iphoneStr forKey:@"phone"];
}

//解档
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.nameStr=[aDecoder decodeObjectForKey:@"name"];
        self.iphoneStr=[aDecoder decodeObjectForKey:@"phone"];
    }
    return self;
}
@end
