//
//  FXMainDemo7VCL.m
//  FXDemos
//
//  Created by FeoniX on 2020/8/20.
//  Copyright © 2020 FX. All rights reserved.
//
/// 链表、二叉树
#import "FXMainDemo7VCL.h"

@interface FXMainDemo7VCL ()
@property (nonatomic, strong) NSArray *array;

@end

@implementation FXMainDemo7VCL

struct BinaryTreeNode *root;

struct BinaryTreeNode{
    NSInteger data;
    //左孩子
    struct BinaryTreeNode *left;
    //右孩子
    struct BinaryTreeNode *right;
};

- (void)dealloc
{
    NSLog(@"dealloc");
    root = NULL;
}

- (struct BinaryTreeNode *)addBTNode:(struct BinaryTreeNode *)node data:(NSInteger)data{
    /*
    if (root == NULL) {
        root = node ;
        root->data = data;
        
        return root;
    }
    
    if (node == NULL) {
        <#statements#>
    }
    
    if (node->data < root->left->data) {
        root->left = [self addBTNode:node data:data];
        root->
    } else {
        root->right = [self addBTNode:node data:data];
    }
     */
    return NULL;
}


/// 循环添加
- (void)add:(NSInteger)data{
    struct BinaryTreeNode *node = malloc(sizeof(struct BinaryTreeNode));
    node->data = data;
    node->left = NULL;
    node->right = NULL;
    
    if (root == NULL) {
        root = node;
    } else {
        struct BinaryTreeNode *temp = NULL;
//        temp = root->left
        if (node->data < root->data) {
            //添加到左子树
            
            if (root->left == NULL) {
                root->left = node;
            } else {
                temp = root->left;
                BOOL bool1;
                BOOL bool2;
                BOOL bool3;
                
                do {
                    BOOL isBreak = false;
                    
                    bool1 = node->data < temp->data && temp->left == NULL;
                    if (bool1 ) {
                        temp->left = node;
                        isBreak = YES;
                        break;
                    }
                    
                    bool2 = node->data > temp->data && temp->right == NULL;
                    if (bool2) {
                        temp->right = node;
                        isBreak = YES;
                        break;
                    }
                    bool3 = node->data < temp->data && temp->right == NULL && node->data > temp->left->data;
                    if ( bool3) {
                        temp->right = node;
                        isBreak = YES;
                        break;
                    }
                    
                    if (!isBreak) {
                        if (node->data < temp->data) {
                            temp = temp->left;
                        } else if (node->data > temp->data) {
                            temp = temp->right;
                        } else {
                            
                        }
                        
                    }


                } while (!bool1 || !bool2 || !bool3);

            }
        }
        
        if (node->data > root->data) {
            //添加到左子树
            
            if (root->right == NULL) {
                root->right = node;
            } else {
                temp = root->right;
                BOOL bool1;
                BOOL bool2;
                BOOL bool3;
                
                do {
                    BOOL isBreak = false;
                    
                    bool1 = node->data < temp->data && temp->left == NULL;
                    if (bool1 ) {
                        temp->left = node;
                        isBreak = YES;
                        break;
                    }
                    
                    bool2 = node->data > temp->data && temp->right == NULL;
                    if (bool2) {
                        temp->right = node;
                        isBreak = YES;
                        break;
                    }
                    bool3 = node->data < temp->data && temp->right == NULL && node->data > temp->left->data;
                    if ( bool3) {
                        temp->right = node;
                        isBreak = YES;
                        break;
                    }
                    
                    if (!isBreak) {
                        if (node->data < temp->data) {
                            temp = temp->left;
                        }
                        
                        if (node->data > temp->data) {
                            temp = temp->right;
                        }
                    }
                } while (!bool1 || !bool2 || !bool3);
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //有序数组递归创建二叉树，+ 二叉树反转
//    [self testGenerateBTTree];
    
    [self loopAdd];

    [self preOrder:root];
    NSLog(@"-----------------------------");
    [self inOrder:root];
    NSLog(@"-----------------------------");
    [self backOrder:root];
     
}


// 通过循环创建 二叉树
- (void)loopAdd{
    for (NSInteger i = 0; i < self.array.count; i ++) {
        [self add:[self.array[i] integerValue]];
    }
}


- (NSArray *)array{
    if (!_array) {
        _array = @[@(4),@(2),@(1),@(3),@(6),@(5),@(7)];
    }
    return _array;
}


#pragma mark - 前序遍历
- (void)preOrder:(struct BinaryTreeNode *)node{
    
    if (node) {
        NSLog(@"%ld",node->data);
        [self preOrder:node->left];
        [self preOrder:node->right];
    }
}

#pragma mark - 中序遍历
- (void)inOrder:(struct BinaryTreeNode *)node{
    
    if (node) {
        [self inOrder:node->left];
        NSLog(@"%ld",node->data);
        [self inOrder:node->right];
    }
}
#pragma mark - 后序序遍历
- (void)backOrder:(struct BinaryTreeNode *)node{
    
    if (node) {
        [self backOrder:node->left];
        [self backOrder:node->right];
        NSLog(@"%ld",node->data);
    }
}
/* 简化版 循环创建
void CreateTreeLoop(Binarytree **tree,int data)
{
    Binarytree *pNode=new Binarytree;
    pNode->data=data;
    pNode->pLeft=pNode->pRight=NULL;
    if(NULL==*tree)
        *tree=pNode;
    else
    {
        Binarytree *back=NULL;
        Binarytree *current=*tree;
        while(current!=NULL)
        {
            back=current;
            if(current->data>data)
                current=current->pLeft;
            else
                current=current->pRight;
        }
        if(back->data>data)
            back->pLeft=pNode;
        else
            back->pRight=pNode;
    }
}
for(int i=0;i<length;i++)
{
    CreateTreeLoop(&pRoot1,arr1[i]);
}
 
 */

/* 有序数组，通过递归创建二叉搜索树
public class GenearteTree {
    public static class Node {
        public int value;
        public Node left;
        public Node right;

        public Node(int value) {
            this.value = value;
        }
    }
        public static Node generateTree(int[] arr) {
            if (arr == null) {
                return null;
            }
            return generate(arr, 0, arr.length - 1);
        }

        public static Node generate(int[] arr, int start, int end) {
            if (start > end) {
                return null;
            }
            int mid = (start + end) / 2;
            Node head = new Node(arr[mid]);
            head.left = generate(arr, start, mid - 1);
            head.right = generate(arr, mid + 1, end);
            return head;
        }
}
 
 */

//  public static Node generate(int[] arr, int start, int end) {

- (struct BinaryTreeNode*)generateBTTree:(NSArray *)arr
                                   start:(NSInteger)start
                                     end:(NSInteger)end{
    if (start > end) {
        return nil;
    }
    
    NSInteger mid = (start + end)/2;
    
    struct BinaryTreeNode *node = malloc(sizeof(struct BinaryTreeNode));
    node->data = [arr[mid] integerValue];
    node->left = [self generateBTTree:arr start:start end:mid-1];
    node->right = [self generateBTTree:arr start:mid+1 end:end];
    
    return node;
}

- (void)testGenerateBTTree{
    struct BinaryTreeNode *node = [self generateBTTree:@[@(1),@(2),@(3),@(4),@(5),@(6),@(7)] start:0 end:6];
    node;
    
    [self backNode:node];
    node;
}

//反转二叉树
- (struct BinaryTreeNode *)backNode:(struct BinaryTreeNode *)root{
    if (!root) {
        return nil;
    }
    struct BinaryTreeNode *left = [self backNode:root->left];
    struct BinaryTreeNode *right = [self backNode:root->right];
    
    root->left = right;
    root->right = left;
    return root;
}

//if root == nil {
//    return nil
//}
//let left : TreeNode? = invertTree(root?.left)
//let right : TreeNode? = invertTree(root?.right)
//
//root?.left = right
//root?.right = left
//return root;
@end
