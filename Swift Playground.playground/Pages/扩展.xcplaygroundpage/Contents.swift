// 扩展    为现有类型添加功能
/*
 扩展（Extensions） 用于为现有的类、结构体、枚举或协议类型添加新功能。这包括了扩展那些无法访问原始源代码的类型的能力（即追溯建模）。扩展和 Objective-C 的分类很相似。（与 Objective-C 分类不同的是，Swift 扩展是没有名字的。）
 Swift 中的扩展可以：
  - 添加计算实例属性和计算类属性
  - 定义实例方法和类方法
  - 提供新的构造器
  - 定义下标
  - 定义和使用新的嵌套类型
  - 使已经存在的类型遵循一个协议
 */

// 扩展的语法
class SomeType{}
extension SomeType {
    // 在这里给 SomeType 添加新的功能
}
// 增加协议
/*
 extension SomeType: SomeProtocol, AnotherProtocol {
     // 协议所需要的实现写在这里
 }
 */

// 计算属性
// 扩展可以添加新的计算属性，但是它们不能添加存储属性，也不能为现有属性添加属性观察器。
// 这个例子给 Swift 内建的 Double 类型添加了五个计算型实例属性，以提供基本的距离单位处理功能：
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")        // 打印“One inch is 0.0254 meters”
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")    // 打印“Three feet is 0.914399970739201 meters”

// 构造器
// 扩展可以为一个类添加新的便利构造器（convenience initializer），但是它们不能为一个类添加新的指定构造器（designated initializer）或析构器（deinitializer）。指定构造器和析构器必须始终由类的原始实现提供。
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),size: Size(width: 3.0, height: 3.0))
// centerRect 的 origin 是 (2.5, 2.5) 并且它的 size 是 (3.0, 3.0)

// 方法    扩展可以为现有类型添加新的实例方法和类方法
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
3.repetitions {print("Hello!")}
// Hello!
// Hello!
// Hello!

// 变值实例方法
// 通过扩展添加的实例方法同样也可以修改（modify）（或 改变（mutating））实例本身。修改 self 或其属性的结构体和枚举方法，必须将实例方法标记为 mutating，就像原始实现中的变值方法（mutating methods）一样。
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
// someInt 现在是 9

// 下标
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
// 返回 5
746381295[1]
// 返回 9
746381295[2]
// 返回 2
746381295[8]
// 返回 7

// 嵌套类型    扩展可以给现有的类，结构体，和枚举添加新的嵌套类型：
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// 打印“+ + - 0 - 0 + ”
















