
class Node {
    var data: Int
    var next: Node?

    init(data: Int, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

///2.1 Remove Dups: Write code to remove duplicates from an unsorted linked list.

func removeDups(head: Node?) {
    var dataSet = Set<Int>()
    var prev : Node? = nil
    var current = head
    while current != nil {
        if dataSet.contains(current!.data) {
            prev?.next = current?.next
        }else {
            dataSet.insert(current!.data)
            prev = current
        }
        current = current?.next
    }
}

//let tail = Node(data: 6)
//let node1 = Node(data: 5, next: tail)
//let node2 = Node(data: 1, next: node1)
//let node3 = Node(data: 3, next: node2)
//let node4 = Node(data: 1, next: node3)
//var head :Node? = Node(data: 0, next: node4)
//
//removeDups(head: head)
//
//while head != nil {
//       print(head!.data)
//       head = head?.next
//}



/// 2.2 Return Kth to Last: Implement an algorithm to find the kth to last element of a singly linked list.

func findKthElement(head: Node?, k: Int) -> Node? {
    var current = head
    for i in 0..<k {
        if current == nil { return nil }
        current = current?.next
    }

    var desiredNode = head
    while current != nil {
        current = current?.next
        desiredNode =  desiredNode?.next
    }

    return desiredNode
}

//let tails = Node(data: 6)
//let tail = Node(data: 5,next: tails)
//let node1 = Node(data: 4, next: tail)
//let node2 = Node(data: 3, next: node1)
//let node3 = Node(data: 2, next: node2)
//let node4 = Node(data: 1, next: node3)
//var head :Node? = Node(data: 0, next: node4)
//
//print(findKthElement(head: head, k: 6)?.data ?? -1 )


/*
 2.3 Delete Middle Node: Implement an algorithm to delete a node in the middle (i.e., any node but the first and last node, not necessarily the exact middle) of a singly linked list, given only access to that node.
SOLUTION
EXAMPLE
lnput:the node c from the linked list a->b->c->d->e->f
Result: nothing is returned, but the new linked list looks like a->b->d->e->f
*/

func delete(node: Node?) -> Bool {
    guard let node = node, node.next != nil else { return false }
    var next = node.next!
    node.data = next.data
    node.next = next.next
    return true
}


/*
 2.4
 Partition: Write code to partition a linked list around a value x, such that all nodes less than x come before all nodes greater than or equal to x. If x is contained within the list the values of x only need to be after the elements less than x (see below). The partition element x can appear anywhere in the "right partition"; it does not need to appear between the left and right partitions.

 EXAMPLE
 Input: 3 -> 5 -> 8 5 -> 10 2 1[partition=5] Output: 3 -> 1 2 -> 10 -> 5 5 -> 8

 */

 func partition(linkList: Node, onValue value: Int) -> Node  {
    var current : Node? = linkList
    var leftHead : Node?
    var currentLeft: Node?
    var rightHead: Node?
    var currentRight: Node?

    while current !=  nil {
        if current!.data < value {
            let smallerNode =  Node(data: current!.data)
            if (leftHead ==  nil) {
                leftHead = smallerNode
                currentLeft = smallerNode
            }  else {
                currentLeft?.next = smallerNode
                currentLeft = smallerNode
            }
        } else {
            let biggerNode =  Node(data: current!.data)
            if (rightHead ==  nil) {
                rightHead = biggerNode
                currentRight = biggerNode
            }  else {
                currentRight?.next = biggerNode
                currentRight = biggerNode
            }
        }
        current = current?.next
    }
    currentLeft?.next = rightHead
    return leftHead!
}


/*
2.5 Sum Lists: You have two numbers represented by a linked list,where each node contains a single digit. The digits are stored in reverse order,such that the 1's digit is at the head of the list. Write a function that adds the two numbers and returns the sum as a linked list.
EXAMPLE
Input: (7-> 1 -> 6) + (5 -> 9 -> 2).That is,617 + 295. Output:2 -> 1 -> 9.Thatis,912.
FOLLOW UP
Suppose the digits are stored in forward order. Repeat the above problem. Input: (6 -> 1 -> 7) + (2 -> 9 -> 5).Thatis,617 + 295. Output:9 ->1 ->2.Thatis,912.
*/

func sumList(list1: Node?, list2:  Node?)  ->  Int {
    var list1  =  list1
    var list2 = list2
    var remainder = 0
    var sum = ""
    while (list1 != nil  || list2 != nil) {
        let newVal : Int
        if list1 == nil {
            newVal = list2!.data + remainder
        }  else if list2 == nil {
            newVal = list1!.data + remainder
        } else  {
            newVal  = list1!.data +  list2!.data + remainder
        }
        remainder = newVal / 10
        sum = "\(newVal % 10)" + sum
        list1 = list1?.next
        list2 = list2?.next

    }
    return Int("\(remainder)" + sum)!
}



