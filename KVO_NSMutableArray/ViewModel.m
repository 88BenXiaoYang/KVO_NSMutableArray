//
//  ViewModel.m
//  KVO_NSMutableArray
//
//  Created by by on 2019/3/24.
//  Copyright © 2019 by. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel

- (instancetype)init {
    if (self = [super init]) {
        _students = [NSMutableArray array];
    }
    return self;
}

- (NSMutableArray *)studentsArray {
    return [self mutableArrayValueForKey:NSStringFromSelector(@selector(students))];
}

- (void)addStudents:(NSArray *)students {
    //每添加一个元素会触发一次代理
//    [[self studentsArray] addObjectsFromArray:students];
    
    //一次添加多个元素只触发一次代理
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self studentsArray].count, students.count)];
    [[self studentsArray] insertObjects:students atIndexes:indexSet];
}

- (void)addStudent:(Student *)student {
    [[self studentsArray] addObject:student];
}

- (void)deleteStudentAtIndex:(NSInteger)index {
    if ((index-1) >= [self studentsArray].count) {
        return;
    }

    [[self studentsArray] removeObjectAtIndex:index-1];
}

- (void)modifyStudentAtIndex:(NSInteger)index withNewStudent:(Student *)newStudent {
    if ((index-1) >= [self studentsArray].count) {
        [self addStudent:newStudent];
    } else {
        [[self studentsArray] replaceObjectAtIndex:index-1 withObject:newStudent];
    }
    
    NSLog(@"student name list : %@", [[self studentsArray] valueForKeyPath:@"name"]);
}

@end
