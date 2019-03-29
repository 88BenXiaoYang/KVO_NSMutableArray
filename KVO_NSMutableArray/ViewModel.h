//
//  ViewModel.h
//  KVO_NSMutableArray
//
//  Created by by on 2019/3/24.
//  Copyright © 2019 by. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Student;
NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *students;

/**
 批量添加元素

 @param students 要添加的元素数组
 */
- (void)addStudents:(NSArray *)students;

/**
 逐个添加元素

 @param student 要添加的元素
 */
- (void)addStudent:(Student *)student;

- (void)deleteStudentAtIndex:(NSInteger)index;
- (void)modifyStudentAtIndex:(NSInteger)index withNewStudent:(Student *)newStudent;

@end

NS_ASSUME_NONNULL_END
