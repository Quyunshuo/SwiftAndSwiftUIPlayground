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
// 值捕获
