// 下标
// 下标语法    定义下标使用 subscript 关键字，与定义实例方法类似，都是指定一个或多个输入参数和一个返回类型
/*
 subscript(index: Int) -> Int {
     get {
         // 返回一个适当的 Int 类型的值
     }
     set(newValue) {
         // 执行适当的赋值操作
     }
 }
 
 只读下标：
 subscript(index: Int) -> Int {
     // 返回一个适当的 Int 类型的值
 }
 */
// 只读下标的实现示例：
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// 打印“six times three is 18”

// 下标用法    下标通常用作访问集合、列表或序列中的成员元素的快捷方式

// 下标选项    下标可以接受任意数量的入参，并且这些入参可以是任何类型。下标的返回值也可以是任意类型。
// 一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标。它通常被称为 下标重载。

// 类型下标    静态
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)

