// 错误处理

// 表示与抛出错误
// 在 Swift 中，错误由遵循 Error 协议的类型值表示。这个空协议表示一种类型可用于错误处理
// Swift 枚举特别适用于一组相关的错误条件，枚举的关联值还可以提供错误状态的额外信息
enum VendingMachineError: Error {
    case invalidSelection                       // 不可选择
    case insufficientFunds(coinsNeeded: Int)    // 金额不足
    case outOfStock                             // 缺货
}
// throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

// 处理错误
// 当错误被抛出时，周围的部分代码必须负责处理该错误
// Swift 中的错误处理与其他语言中的错误处理类似，使用 try, catch and throw 关键字。 区别于其他语言（包括 Objective-C ）的是，Swift 中的错误处理并不涉及解除调用栈,而解除调用栈的过程可能会耗费大量计算资源。 因此，throw 语句的性能特征与 return 语句的性能特征相当。

// 用throwing函数传递错误    只有throwing函数可以传递错误。任何在非throwing函数中抛出的错误都必须在函数内部处理。
// 为了表示函数、方法或构造器可以抛出错误，您可以在函数声明中的参数后写入 throws 关键字。标有 throws 的函数称为 throwing函数。如果该函数指定了返回类型，则应在返回箭头（->）之前写入 throws 关键字。
func canThrowErrors() throws -> String{""}
func cannotThrowErrors() -> String{""}
// 抛出错误示例：
struct Item {
    var price: Int
    var count: Int
}
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection    // inventory 字典中没有 name 这个 key 时，抛出错误
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        coinsDeposited -= item.price
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        print("Dispensing \(name)")
    }
}
// 处理错误示例：
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)    // 当 vend 方法抛出错误时 因为添加了 try 关键字，会将错误进一步往外抛出
}

// 使用 Do-Catch 处理错误
// 使用 do-catch 语句通过运行闭包来处理错误。如果 do 子句中的代码抛出错误，就会与 catch 子句进行匹配，以确定哪个子句可以处理该错误。
// 下面是 do-catch 语句的一般形式：
/*
 do {
     try <#expression#>
     <#statements#>
 } catch <#pattern 1#> {
     <#statements#>
 } catch <#pattern 2#> where <#condition#> {
     <#statements#>
 } catch <#pattern 3#>, <#pattern 4#> where <#condition#> {
     <#statements#>
 } catch {
     <#statements#>
 }
 */
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// 打印 "Insufficient funds. Please insert an additional 2 coins."

// where 关键字
/*
 where 提供了一种 对错误进行更精确过滤 的机制。例如：
  - 当某些错误类型具有额外的属性时，可以根据属性值来决定是否捕获。
  - 对同一错误类型进行不同条件的分支处理。
 */
enum CustomError: Error {
    case invalidCode(code: Int)
    case other
}
func testError() throws {
    throw CustomError.invalidCode(code: 404)
}
do {
    try testError()
} catch CustomError.invalidCode(let code) where code == 404 {
    print("Error: Invalid code 404.") // 输出: Error: Invalid code 404.
} catch {
    print("Some other error.")
}

// 将错误转换成可选值
// 使用 try? 将错误转换为可选值来处理错误。如果在计算 try? 表达式时抛出错误，则表达式的值为 nil 
func someThrowingFunction() throws -> Int {10086}
let x = try? someThrowingFunction()
let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}
// 使用 try? 可让您在希望以相同方式处理所有错误时编写简洁的错误处理代码
/*
 func fetchData() -> Data? {
     if let data = try? fetchDataFromDisk() { return data }
     if let data = try? fetchDataFromServer() { return data }
     return nil
 }
 */

// 禁用错误传递
// 使用 try! 以禁用错误传递
// let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")

// 指定错误类型 该语法因该是 swift 6 的新特性
/*
 enum StatisticsError: Error {
     case noRatings
     case invalidRating(Int)
 }
 func summarize(_ ratings: [Int]) throws(StatisticsError) {
     guard !ratings.isEmpty else { throw .noRatings }
     var counts = [1: 0, 2: 0, 3: 0]
     for rating in ratings {
         guard rating > 0 && rating <= 3 else { throw .invalidRating(rating) }
         counts[rating]! += 1
     }
     print("*", counts[1]!, "-- **", counts[2]!, "-- ***", counts[3]!)
 }
 */

// 指定清理操作
/*
 func processFile(filename: String) throws {
     if exists(filename) {
         let file = open(filename)
         defer {
             close(file)
         }
         while let line = try file.readline() {
             // 处理文件。
         }
         // close(file) 会在这里被调用，即作用域的最后。
     }
 }
 */
