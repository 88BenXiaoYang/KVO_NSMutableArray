//
//  ViewController.m
//  KVO_NSMutableArray
//
//  Created by by on 2019/3/24.
//  Copyright © 2019 by. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "Student.h"

@interface ViewController ()

@property (nonatomic, strong) ViewModel *vm;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *modifyBtn;

@end

@implementation ViewController

#pragma mark- Live circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareSubViews];
    [self addObserver];
}

- (void)dealloc {
    [self.vm removeObserver:self forKeyPath:@"students" context:nil];
}

#pragma mark- Overwrite
#pragma mark- Delegate
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"students"]) {
        NSNumber *kind = change[NSKeyValueChangeKindKey]; //操作的类型
        NSArray *students = change[NSKeyValueChangeNewKey];
        NSArray *oldStudent = change[NSKeyValueChangeOldKey];
        NSIndexSet *changedIndexs = change[NSKeyValueChangeIndexesKey];
        
        NSLog(@"kind: %@, students: %@ - value: %@, oldStudent: %@ - oldValue: %@, changedIndexs: %@", kind, students, [students valueForKey:@"name"], oldStudent, [oldStudent valueForKey:@"name"], changedIndexs);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark- Notification methods
#pragma mark- Interface methods
#pragma mark- Event Response methods
- (void)addItem:(UIButton *)sender {
    static NSInteger nameIndex = 0;
    NSLog(@"### add ###");
    Student *st = [[Student alloc] init];
    st.name = [NSString stringWithFormat:@"student:%ld",(long)++nameIndex];
    [self.vm addStudent:st];
    
    Student *stu = [[Student alloc] init];
    stu.name = [NSString stringWithFormat:@"stu:hahahaha"];
    NSArray *stus = @[st, stu];
//    [self.vm addStudents:stus];
}

- (void)deleteItem:(UIButton *)sender {
    NSLog(@"### delete ###");
    [self.vm deleteStudentAtIndex:2];
}

- (void)modifyItem:(UIButton *)sender {
    static NSInteger newStuNameIndex = 0;
    NSLog(@"### modify ###");
    Student *newStu = [[Student alloc] init];
    newStu.name = [NSString stringWithFormat:@"newStu:%ld",(long)++newStuNameIndex];
    [self.vm modifyStudentAtIndex:10 withNewStudent:newStu];
}

#pragma mark- Net request
#pragma mark- Private methods
- (void)prepareSubViews {
    self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 70, 30)];
    self.addBtn.backgroundColor = [UIColor lightGrayColor];
    [self.addBtn setTitle:@"add" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.addBtn.frame) + 30, 100, 70, 30)];
    self.deleteBtn.backgroundColor = [UIColor lightGrayColor];
    [self.deleteBtn setTitle:@"delete" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.modifyBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.deleteBtn.frame) + 30, 100, 70, 30)];
    self.modifyBtn.backgroundColor = [UIColor lightGrayColor];
    [self.modifyBtn setTitle:@"modify" forState:UIControlStateNormal];
    [self.modifyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.modifyBtn addTarget:self action:@selector(modifyItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.addBtn];
    [self.view addSubview:self.deleteBtn];
    [self.view addSubview:self.modifyBtn];
}

- (void)addObserver {
    self.vm = [[ViewModel alloc] init];
    [self.vm addObserver:self forKeyPath:@"students" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

#pragma mark- Setter and getter

@end
