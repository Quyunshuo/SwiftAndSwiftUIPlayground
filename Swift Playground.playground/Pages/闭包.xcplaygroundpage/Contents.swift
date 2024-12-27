// 闭包    将执行的代码组合在一起，而不需要创建命名函数
// 闭包表达式
// 使用 Sorted 方法举例
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)                    // 这是一种繁琐的写法
// 闭包表达式语法
/*
 { (parameters) -> return type in
    statements
 }
 */
// 对上述 sorted(by:) 方法使用闭包表达式语法进行简化
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in    // 闭包函数主体的开始以 in 关键字开始
    return s1 > s2
})
// 根据上下文推断类型
// 对上述 sorted(by:) 方法进行更加简化的写法
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
// 单表达式闭包的隐式返回    单表达式闭包可以通过从其声明中省略 return 关键字来隐式返回其单表达式的结果
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
// reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

// 简写参数名称    Swift 自动为内联闭包提供了简写参数名称功能，你可以直接通过 $0、$1、$2 等来引用闭包参数的值，以此类推。
reversedNames = names.sorted(by: { $0 > $1 } )    // 由于此时闭包表达式仅由其函数体组成，因此 in 关键字也可以省略：

// 运算符方法
/*
 实际上有一种 更短 的方法来编写上面的闭包表达式。Swift 的 String 类型定义了关于大于运算符 （ > ） 的字符串实现方法，该方法具有两个 String 类型的参数，并返回一个 Bool 类型的值。这正好符合 sorted(by:) 方法所需的函数类型。因此，你可以直接传入大于运算符，Swift 会推断出你想使用它的字符串特定实现：
 */
reversedNames = names.sorted(by: >)

// 尾随闭包
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数主体在这里
}
// 以下是如何在不使用尾随闭包的情况下调用此函数的示例：
someFunctionThatTakesAClosure(closure: {
    // 闭包的主体在这里
})
// 以下是如何使用尾随闭包调用此函数的示例：
someFunctionThatTakesAClosure() {
    // 尾随闭包的主体在这里
}
// sorted(by:) 的尾随闭包写法
reversedNames = names.sorted() { $0 > $1 }
// 多个尾随闭包
//func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
//    if let picture = download("photo.jpg", from: server) {
//        completion(picture)
//    } else {
//        onFailure()
//    }
//}
//loadPicture(from: someServer) { picture in
//    someView.currentPicture = picture
//} onFailure: {
//    print("Couldn't download the next picture.")
//}

// 闭包是引用类型    函数和闭包是 引用类型
// 每当你将函数或闭包赋值给一个常量或变量时，你实际上是在将该常量或变量设置为对函数或闭包的 引用

// 逃逸闭包    逃逸闭包的关键字：@escaping
/*
 1. 什么是逃逸闭包？
 当一个闭包在函数返回后仍然存活并可能被调用时，就称为逃逸闭包。
 以下情况会导致闭包逃逸：
     •将闭包保存到函数外部的变量或属性中。
     •将闭包作为参数传递给其他异步操作，例如异步回调函数。
 2. 非逃逸闭包（默认情况）
 在 Swift 中，函数的参数闭包默认是非逃逸的。这意味着闭包只能在函数内部调用，函数执行完后闭包会被释放。
 */
var completionHandlers: [() -> Void] = []    // 外部变量 用于存储闭包
func addCompletionHandler(_ handler: @escaping () -> Void) {
    completionHandlers.append(handler) // 闭包逃逸出函数作用域 被添加到 completionHandlers 中
}
addCompletionHandler { print("This is a completion handler.") }

// 自动闭包    
// 在函数参数类型前加上 @autoclosure 标记，表示该参数为一个自动闭包。例如：
func log(message: @autoclosure () -> String) {
    print(message()) // 调用闭包
}
log(message: "Hello, World!") // 自动将 "Hello, World!" 封装为闭包
// 示例
func performTask(condition: Bool, action: @autoclosure () -> String) {
    if condition {
        print(action()) // 只有满足条件时，才执行闭包
    } else {
        print("Condition not met")
    }
}
performTask(condition: true, action: "Task Executed")  // 输出：Task Executed
performTask(condition: false, action: "Task Executed") // 输出：Condition not met
// 优点："Task Executed" 的字符串拼接等操作只有在条件满足时才会执行，避免不必要的性能开销。
