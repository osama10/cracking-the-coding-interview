
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
