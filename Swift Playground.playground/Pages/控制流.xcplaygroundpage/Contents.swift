// 控制流  使用分支、循环和提前退出来搭建代码的流程结构。

// For-In 循环    使用 for-in 循环来遍历一个集合中的所有元素，例如数组中的元素、范围内的数字或者字符串中的字符
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
for _ in 1...3 {}                            // 可以使用下划线（_）替代变量名来忽略这个值

// While 循环    while 循环会一直运行一段语句直到条件变成 false
/*
 Swift 提供两种 while 循环形式：
 - while 循环，每次在循环开始时评估条件是否符合；
 - repeat-while 循环，每次在循环结束时评估条件是否符合。
 */
var count = 1
while count <= 5 {
    print("Count is \(count)")
    count += 1
}
// 输出：
// Count is 1
// Count is 2
// Count is 3
// Count is 4
// Count is 5
var number = 1
repeat {
    print("Number is \(number)")
    number += 1
} while number <= 5
// 输出：
// Number is 1
// Number is 2
// Number is 3
// Number is 4
// Number is 5

// 条件语句
// if
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a T-shirt.")
}
// 可以使用 if 来进行返回一个值
let temperatureInCelsius = 25
let weatherAdvice = if temperatureInCelsius <= 0 {
    "It's very cold. Consider wearing a scarf."
} else if temperatureInCelsius >= 30 {
    "It's really warm. Don't forget to wear sunscreen."
} else {
    "It's not that cold. Wear a T-shirt."
}
// 在返回 nil 的情况下需要进行声明返回值的类型，一种是在返回值变量出声明，另一种是在 nil 分支声明
let freezeWarning: String? = if temperatureInCelsius <= 0 {
    "It's below freezing. Watch for ice!"
} else {
    nil
}
let freezeWarningFroNil = if temperatureInCelsius <= 0 {
    "It's below freezing. Watch for ice!"
} else {
    nil as String?
}

// Switch switch 语句会尝试把某个值与若干个模式（pattern）进行匹配。根据第一个匹配成功的模式，switch 语句会执行对应的代码。当有可能的情况较多时，通常用 switch 语句替换 if 语句。
/*
 语法如下：
 switch some value to consider {
 case value 1:
     respond to value 1
 case value 2,
     value 3:
     respond to value 2 or 3
 default:
     otherwise, do something else
 }
 */
let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the Latin alphabet")
case "z":
    print("The last letter of the Latin alphabet")
default:
    print("Some other character")
}
// 和 if 语句一样，switch 语句也具有表达式形式:
let anotherCharacter: Character = "a"
let message = switch anotherCharacter {
case "a","A":
    "The first letter of the Latin alphabet"
case "z":
    "The last letter of the Latin alphabet"
default:
    "Some other character"
}
// 区间匹配
let approximateCount = 62
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
// 元组
/*
 可以使用元组在同一个 switch 语句中测试多个值。可以针对不同的值或值区间来测试元组的每个元素。另外，使用下划线（_）通配符来匹配所有可能的值
 */
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// 值绑定（Value Bindings）
// switch 的 case 分支允许将匹配的值声明为临时常量或变量，并且在 case 分支体内使用
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// 输出 "on the x-axis with an x value of 2"
// Where    case 分支可以使用 where 从句来判断附加的条件
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// 输出 "(1, -1) is on the line x == -y"
// 复合型 Cases（Compound Cases）
let someCharacter2: Character = "e"
switch someCharacter2 {
case "a", "e", "i", "o", "u":
    print("\(someCharacter2) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
    "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter2) is a consonant")
default:
    print("\(someCharacter2) isn't a vowel or a consonant")
}
// 输出 "e is a vowel"
// 复合匹配同样可以包含值绑定
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

// 控制转移语句
// Continue    continue 语句告诉一个循环体立刻停止本次循环，重新开始下次循环
// Break     break 语句会立刻结束整个控制流的执行。break 可以在 switch 或循环语句中使用，用来提前结束 switch 或循环语句。
// 贯穿（Fallthrough）     fallthrough 关键字不会检查它下一个将会落入执行的 case 中的匹配条件。fallthrough 简单地使代码继续连接到下一个 case （或 default）中的代码
// 带标签的语句
// guard    guard 语句用于判断一个 Bool 值，如果为 Ture 则跳出 guard 执行后面的代码，如果为 false 则执行 else 中的代码
/*
 语法：
 guard 条件 else {
     // 条件不满足时执行的代码块（退出当前作用域）
     执行语句（如 return, break, continue, throw 等）
 }
 guard 的特点
 1.用于提前退出：如果条件不满足，guard 块内的代码将执行，并通过 return, break, continue, 或 throw 等语句退出当前作用域。
 2.条件必须为真：guard 的条件需要返回布尔值，当条件为 false 时才会进入 else 块。
 3.适合解包可选值（Optional Binding）：guard 经常用于可选值的安全解包，解包后的值在当前作用域中可用。
 */
/*
 guard let 解包成功与否可以被视为布尔条件，因为：
 1.person["name"] 返回的是一个可选值（Optional<String>）。
 2.可选值有一个隐式的布尔值判断逻辑：有值（非 nil）时视为 true；为 nil 时视为 false。
 */
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)!")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}
greet(person: ["name": "John"])
// 输出 "Hello John!"
// 输出 "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// 输出 "Hello Jane!"
// 输出 "I hope the weather is nice in Cupertino."

// 延迟执行的操作（Deferred Actions）
// defer 控制何时执行一段代码  使用 defer 块编写代码，这些代码将在以后程序到达当前代码块的末尾时执行
/*
 无论程序如何退出该范围，defer 内的代码始终运行。这包括提前退出函数、中断 for 循环或抛出错误等代码。此特性使得 defer 对于需要保证成对的操作非常有用(例如手动分配和释放内存、打开和关闭底层文件描述符以及在数据库中开始和结束事务)
 */
var score = 1
if score < 10 {
    defer {
        print(score)
    }
    score += 5
}
// 输出 "6"
score = 1
if score < 10 {
    defer {
        print(score)
    }
    defer {
        print("The score is:")
    }
    score += 5
}
// 输出 "The score is:"
// 输出 "6"

// 检测 API 可用性
// 可用性检查
if #available(iOS 10, macOS 10.12, *) {
    // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
} else {
    // 使用先前版本的 iOS 和 macOS 的 API
}
// 不可用性检查
if #unavailable(iOS 10) {
    // 回退代码
}



