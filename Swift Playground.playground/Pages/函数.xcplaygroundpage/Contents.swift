
// Swift 中的每个函数都有一个类型，由函数的形参值类型和返回值类型组成 类似 Kotlin 中的函数类型
// 定义和调用函数
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}
print(greet(person: "Anna"))
print(greet(person: "Brian"))
// 简写返回值部分代码
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
// 函数参数与返回值
// 1.无参数函数
func sayHelloWorld() -> String {
    return "hello, world"
}
// 2.多参数函数
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
// 3.无返回值函数    没有定义返回类型的函数会返回 Void 类型的特殊值。 这是一个空元组，写成 ()
func greet2(person: String) {
    print("Hello, \(person)!")
}
// 4.多重返回值函数    可以用元组（tuple）类型让多个值作为一个复合值从函数中返回
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")            // 由于返回值元组的成员值已被命名，可以使用点语法访问成员
// 5.可选元组返回类型    可选元组类型如 (Int, Int)? 与元组包含可选类型如 (Int?, Int?) 是不同的。 可选的元组类型，整个元组是可选的，而不只是元组中的每个元素值。
func func5(b:Bool) -> (Int,Int)?{
    if b {
        return (0,0)
    }else{
        return nil   
    }
}
// 6.隐式返回的函数    如果函数的整个主体是一个表达式，则函数隐式返回该表达式，可以省略 return
func func6()->Int{
     0
}

// 函数参数标签和参数名称    每个函数参数都有一个 参数标签（argument label） 和 参数名称（parameter name）
// 1.指定参数标签    在参数名之前写入参数标签，用空格隔开;如果参数有参数标签，则在调用函数时 必须 使用标签来标示参数。
func someFunction(argumentLabel parameterName: Int) {
    // In the function body, parameterName refers to the argument value
    // for that parameter.
}
// 2.省略参数标签
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction(1, secondParameterName: 2)
// 3.默认参数值
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12
// 4.可变参数    可变参数（variadic parameter） 接受零个或多个指定类型的值
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// 返回 3.0，是这 5 个数的平均数
arithmeticMean(3, 8.25, 18.75)
// 返回 10.0，是这 3 个数的平均数
arithmeticMean()
// 5.输入输出参数    
/*
 可以通过在参数类型前添加 inout 关键字来编写输入输出参数。输入输出参数有一个值，该值 传入 给函数，被函数修改后，然后被 传出 函数，以替换原来的值
 当传入的参数作为输入输出参数时，需要在参数名前加 （&） 符，表示这个值可以被函数修改。
 */
// 输入输出参数不能有默认值，而且可变参数不能标记为 inout
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// 打印 "someInt is now 107, and anotherInt is now 3"

// 函数类型    每个函数都有一个特定的 函数类型，由函数的参数类型和返回类型组成
func addTwoInts(_ a: Int, _ b: Int) -> Int {    // 该函数的类型为 (Int,Int) -> Int
    return a + b
}
func printHelloWorld() {                        // 该函数的类型为 () -> Void
    print("hello, world")
}
// 使用函数类型
var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(2, 3))")          // Prints "Result: 5"
// 函数类型作为参数类型
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)               // 打印 "Result: 8"
// 函数类型作为返回类型
func stepForward(_ input: Int) -> Int {input + 1}
func stepBackward(_ input: Int) -> Int {input - 1}
func chooseStepFunction(backward: Bool) -> (Int) -> Int {    // 根据参数决定返回哪个函数作为返回值
    return backward ? stepBackward : stepForward
}
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)    // moveNearerToZero 现在指向 stepBackward() 函数。
// 嵌套函数
// 默认情况下，嵌套函数是对外界不可见的，但仍可被其外围函数（enclosing function）调用。外围函数也可以返回它的某个嵌套函数，以便在另一个作用域中使用这个函数。
// 重写上述函数
func chooseStepFunction2(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { input + 1 }
    func stepBackward(input: Int) -> Int { input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue2 = -4
let moveNearerToZero2 = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero 现在引用了 chooseStepFunction2 嵌套的 stepForward() 函数

















