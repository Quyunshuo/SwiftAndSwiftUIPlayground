
// 元组  元组将多个值组合成一个复合值。元组内的值可以是任何类型，且不必彼此属于同一类型。
let http404Error = (404, "Not Found")                             // http404Error 的类型为（Int，String），且等于（404，"Not Found"）
let (statusCode, statusMessage) = http404Error                    // 类似于 Kotlin 的解构
let (justTheStatusCode, _) = http404Error                         // 使用_来忽略不需要的部分
print("The status code is \(http404Error.0)")                     // 使用从零开始的索引访问元组中的单个元素值
let http200Status = (statusCode: 200, description: "OK")          // 在定义元组时为元组中的各个元素命名
print("The status code is \(http200Status.statusCode)")           // 使用元素名访问这些元素的值
print("The status message is \(http200Status.description)")

// 可选（相当于Kotlin 中的可空类型）  可选代表两种可能性：要么存在一个指定类型的值，并可以解包可选以访问该值；要么根本就没有值。
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)        // convertedNumber 的类型是 "可选 Int"
// nil（相当于 null）  通过给可选变量赋特殊值 nil，可以将其设置为无值状态
var serverResponseCode: Int? = 404               // serverResponseCode 包含一个实际 Int 值 404
serverResponseCode = nil                         // serverResponseCode 现在不包含任何值
if serverResponseCode == nil {
    print("serverResponseCode is nil")
}
// 可选链式调用（Optional Chaining）
// TODO
// 可选绑定  使用可选绑定来确定可选是否包含值，如果包含，则将该值作为临时常量或变量使用
// 下面代码可理解为：如果 Int(possibleNumber) 返回的可选 Int 中包含一个值，则将它赋值给名为 actualNumber 的新常量。”
if let actualNumber = Int(possibleNumber) {
    /*
     如果转换成功，actualNumber 常量就可以在 if 语句的第一个分支中使用。这个常量已经用可选中的值进行了初始化，并具有相应的非可选类型。在本例中，possibleNumber 的类型是 Int?，因此 actualNumber 的类型是 Int。
     */
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}
// 如果在访问原可选常量或变量的值后不需要再引用它，则可以考虑使用相同的名称来命名新常量或变量，同时新常量或变量是一个临时的：
let myNumber = Int(possibleNumber)
// 这里，myNumber 是一个可选整数
if let myNumber = myNumber {
    // 这里，myNumber 是一个非可选整数
    print("My number is \(myNumber)")    
}
// 更为简化的写法
if let myNumber {
    print("My number is \(myNumber)")    
}
// if 语句中可以包含任意数量的可选绑定和布尔条件，并用逗号分隔。如果可选绑定中的任何值为 nil，或任何布尔条件的值为 false，则整个 if 语句的条件被视为 false
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")            // 打印 "4 < 42 < 100"
}
// 等价于
if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")    // 打印 "4 < 42 < 100"
        }
    }
}
/*
 提供后备值
 处理缺失值的另一种方法是使用 nil-coalescing 操作符（??）提供一个缺省值。如果 ?? 左边的可选值不是 nil，那么该值将被解包并使用。否则，将使用 ?? 右侧的值
 与 kotlin 可空变量的?:默认值 相同
 */
let name: String? = nil
let greeting = "Hello, " + (name ?? "friend") + "!"
print(greeting)    // 打印 "Hello, friend!"
// 强制解包  类似于 Kotlin 中对可空类型断言
let possibleNumber2 = "123"
let convertedNumber2 = Int(possibleNumber2)
let number = convertedNumber2!    // 强制解包
// 隐式解包可选
/*
 有时，从程序结构中可以清楚地看出，在首次设置可选值后，该可选将始终有一个值。在这种情况下，无需在每次访问可选时都对其值进行检查和解包，因为你可以安全地假定它一直都有值。
 这类可选被定义为隐式解包可选。在编写隐式解包可选时，需要在可选类型后面加上感叹号（String!）而不是问号（String?）。要注意不是在使用可选时在其名称后加上感叹号，而是在声明可选时在其类型后加上感叹号。
 当首次定义可选后，可选的值立即被确认存在，并且可以确保在此后的每一个时间点都存在值时，隐式解包可选就非常有用了。在 Swift 中，隐式解包可选的主要用途是在类初始化过程中。
 当变量有可能在稍后阶段变为 nil 时，不要使用隐式解包可选。如果需要在变量的生命周期内检查变量是否为 nil，请务必使用普通的可选类型。
 */
let possibleString: String? = "An optional string."
let forcedString: String = possibleString!    // 强制解包
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString    // 隐式解包

// 错误处理 类似 Kotlin or Java 中的异常
enum MyError: Error {
    case invalidInput
    case networkFailure
    case unknown
}
// 此函数可能抛出错误，也可能不抛错
func performTask(value: Int) throws {
    if value < 0 {
        throw MyError.invalidInput
    }
    print("Task performed successfully.")
}    
// do-catch 语句，类似于 Kotlin 中的 try-catch
do {
    try performTask(value: -1)
    // 无错误的情况
} catch MyError.invalidInput {
    print("Invalid input provided.")
} catch MyError.networkFailure {
    print("Network failure occurred.")
} catch {
    print("An unknown error occurred: \(error).")
}
// 其他语法
let result = try? performTask(value: -1)    // 使用 try? 将错误转换为可选值，result 为 nil 
try! performTask(value: 10)                 // 使用 try! 强制执行，如果发生错误会崩溃

// 断言和先决条件
// 断言和前提条件的区别在于何时检查：断言只在调试构建中进行检查，而前提条件则在调试构建和生产构建中都进行检查
// 在生产版本中，断言中的条件不会被评估。这意味着你可以在开发过程中随意使用断言，而不会影响生产过程中的性能。

// 使用断言进行调试  调用 Swift 标准库中的 assert(_:_:file:line:) 函数来编写断言
let age = 3
assert(age >= 0, "A person's age can't be less than zero.")    // 断言信息可以省略
// 在本例中，如果 age >= 0 的值为 true，即 age 的值为非负值，代码将继续执行。如果 age 的值为负数则 age >= 0 的值为 false，断言失败，应用终止。
// 如果代码已经检查了条件，则使用 assertionFailure(_:file:line:) 函数来表示断言失败。例如：
if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age >= 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.")
}

// 强制执行先决条件  调用 precondition(_:_:file:line:) 函数来编写先决条件
var index = 1
precondition(index > 0, "Index must be greater than zero.")
// 还可以调用 preconditionFailure(_:file:line:) 函数来表示发生了故障
// 可以使用 fatalError(_:file:line:) 函数为尚未实现的功能创建存根
