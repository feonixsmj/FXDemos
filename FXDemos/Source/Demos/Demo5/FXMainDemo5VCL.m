//
//  FXMainDemo5VCL.m
//  FXDemos
//
//  Created by FeoniX on 2019/5/22.
//  Copyright © 2019 FX. All rights reserved.
//

#import "FXMainDemo5VCL.h"

@interface FXMainDemo5VCL ()

@end

@implementation FXMainDemo5VCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self listReverse];
    [self test];
}

/**
   链表反转
 * 反转前：1->2->3->4->NULL
 * 反转后：4->3->2->1->NULL
 */
- (void)listReverse{
    struct Node *p = [self constructList];
    [self printList:p];
    
//    struct Node *header = p->next;
//
//    [self printList:header];
    //反转后的链表头部
    struct Node *newH = NULL;
    
    //头插法
    while (p != NULL) {

        //记录下一个节点
        struct Node *temp = p->next;
        //当前节点的next指向新链表的头部
        p->next = newH;
        //更改新链表的头部为当前节点
        newH = p;
        //移动p到下一个节点
        p = temp;
    }

    [self printList:newH];
}

/**
 定义一个链表
 */

struct Node{
    NSInteger data;
    
    struct Node *next;
};


/**
 打印链表
 
 @param head 给定链表
 */
- (void)printList:(struct Node *)head{
    struct Node *temp = head;
    printf("list is :");
    
    while (temp != NULL) {
        printf("%zd", temp->data);
        temp = temp->next;
    }
    printf("\n");
}

/**  构造链表  */
- (struct Node *)constructList{
    //头节点
    struct Node *head = NULL;
    //临时记录的当前节点
    struct Node *cur = NULL;
    
    for (NSInteger i = 0; i < 10; i++) {
        struct Node *node = malloc(sizeof(struct Node));
        node->data = i;
        
        if (head == NULL) {
            head = node;
        } else {
            cur->next = node;
        }
        
        cur = node;
    }
    cur->next = NULL;
    
    return head;
}


- (struct Node *)createNode{
    
    struct Node *head = NULL;
    struct Node *cur = NULL;
    
    for (NSInteger i = 0; i < 10; i ++) {
        
        struct Node *node = malloc(sizeof(struct Node));
        node->data = i;
        if (head == NULL) {
            head = node;
        } else {
            cur->next = node;
        }
        cur = node;
    }
    
    cur->next = NULL;
    return head;
}


- (void)test{
    struct Node *testNode = [self createNode];
    
    [self printList:testNode];
    
    [self fanzhuanNode:testNode];
}

-(void)fanzhuanNode:(struct Node*)node{
    
    //头插法
    struct Node *head = NULL;
    struct Node *temp = NULL;
    
    while (node != NULL) {
        temp = node->next;
        
        node->next = head;
        head = node;
        node = temp;
    
    }
    [self printList:head];
}

@end
