// 内存安全

// Swift 会要求修改内存的代码拥有对被修改区域的独占访问权，以确保对同一块内存区域的多次访问不会产生冲突。由于 Swift 会自动管理内存，大多数情况下你不需要考虑内存访问相关的问题。

// 理解内存访问冲突
var one = 1    // 向 one 所在的内存区域发起一次写操作
print("We're number \(one)!")    // 向 one 所在的内存区域发起一次读操作
// 访问冲突即便在单线程环境中也有可能产生
// 如果你的程序在单线程上运行时产生了内存访问冲突问题，Swift 保证会抛出编译时或运行时错误。对于多线程代码，你可以使用 Thread Sanitizer 来检测不同线程间的访问冲突。

// 内存访问的特点
/*
 在访问冲突的语境下，我们需要考虑内存访问的三个特点：此次访问是读还是写、访问的时长、被访问内存区域的位置。特别地，两次内存访问会在满足以下所有条件时产生冲突：
  - 它们不是都是读操作，也不是都是原子化操作。
  - 它们访问的是同一块内存区域。
  - 它们的时间窗口出现了重叠。 
 */
// 读操作和写操作之间的区别是显而易见的：写操作会改变内存区域，而读操作不会。「内存区域」指的是被访问的内容（例如变量、常量、属性）。内存访问的要么瞬间完成，要么持续较长时间。
// 一次访问如果满足以下条件之一则为原子访问:
// - 是对 Atomic 或 AtomicLazyReference 的原子操作调用
// - 仅使用 C 原子操作 否则就是非原子访问。 关于 C 原子函数的列表,请参阅 stdatomic(3) 手册页。
// 如果在一次内存访问的过程中没有任何其他代码可以在其开始后、结束前运行，则这次访问是瞬时完成的。其性质决定了两次瞬时访问不可能同时发生。大多数内存访问都是瞬时完成的。比如，下面这段代码中的所有读写操作都是瞬时完成的：
func oneMore(than number: Int) -> Int {
    return number + 1
}
var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)    // Prints "2"
// 然而，也有其他被称作长时访问的内存访问 —— 它们的执行过程会「横跨」其它代码的执行。长时访问和瞬时访问的区别在于：前者执行开始后、结束前的这段时间内，其它的代码有可能会执行，我们称之为重叠。一次长时访问可以与其它的长时或瞬时访问重叠。
// 重叠访问通常出现在函数和方法的 in-out 参数以及结构体的变值方法中。

// 对 In-Out 参数的访问冲突
// 一个函数会对它所有的 in-out 参数保持长时写访问。in-out 参数的写访问会在所有非 in-out 参数处理完之后开始，直到函数执行完毕为止。如果存在多个 in-out 参数，则写访问的开始顺序和参数的排列顺序一致。
// 这种长时保持的写访问带来的问题是：即便作用域和访问权限规则允许，你也不能再访问以 in-out 形式传入的原始变量。这是因为任何访问原始变量的行为都会造成冲突，例如：
var stepSize = 1
func increment(_ number: inout Int) {
    number += stepSize    // 对于 stepSize 的读访问与 number 的写访问重叠了，number 和 stepSize 都指向了同一个内存区域
}
// increment(&stepSize)    // 错误：stepSize 访问冲突
// 其中一个解决冲突的方式是显式地复制一份 stepSize：
var copyOfStepSize = stepSize    // 显式复制
increment(&copyOfStepSize)
stepSize = copyOfStepSize        // 更新原来的值
print(stepSize)                  // stepSize 现在的值是 2
// 对于 in-out 参数保持长时写访问的另一个后果是，往同一个函数的多个 in-out 参数里传入同一个变量也会产生冲突。例如：
func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)    // OK
// balance(&playerOneScore, &playerOneScore)    // 错误：playerOneScore 访问冲突

// 方法中的 self 访问冲突
// 一个结构体的变值（mutating）方法会在其被调用期间保持对于 self 的长时写访问

// 属性访问冲突
// 结构体、元组、枚举这样的类型是由多个独立的值构成的（例如结构体的属性、元组的元素）。它们都是值类型，所以修改值的任何一部分都是对于整个值的修改。这意味着对于其中任何一个属性的读或写访问，都需要对于整个值的访问。例如，对于元组元素的重叠写访问会造成冲突：
var playerInformation = (health: 10, energy: 20)
// balance(&playerInformation.health, &playerInformation.energy)
// 错误：对 playerInformation 的属性访问有冲突

// 在实践中，大多数时候对于结构体属性的重叠访问是安全的。举个例子，如果上方例子中的变量 holly 是一个本地变量而非全局变量，编译器可以证明对于该结构体的属性的重叠访问是安全的：
struct Player {
    var name: String
    var health: Int
    var energy: Int
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}
func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)  // OK
}
/*
 在上方的例子中，Oscar 的生命值和能量值被作为两个 in-out 参数传递给了 balance(_:_:)。此时编译器能够证明内存是安全的，因为这两个属性并不会以任何方式交互。
 要保证内存安全，限制结构体属性的重叠访问并不总是必要的。内存安全性是我们想获得的一种保证，但是「独占访问」是相比「内存安全」更加严格的一种要求 —— 这意味着即使有些代码违反了「独占访问」的原则，它也可以是内存安全的。只要编译器可以「证明」这种非专属的访问是内存安全的，Swift 就会允许这样的代码存在。特别地，在以下条件满足时，编译器就可以证明对结构体属性的重叠访问是安全的：
 代码只访问了实例的存储属性，而没有访问计算属性或类属性
 结构体是本地变量，而非全局变量的值
 结构体要么没有被闭包捕获，要么只被非逃逸闭包捕获了
 如果编译器无法证明访问安全性，它就会拒绝访问。
 */
