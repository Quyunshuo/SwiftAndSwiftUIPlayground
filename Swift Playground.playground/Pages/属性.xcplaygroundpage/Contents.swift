// 属性
// 存储属性
struct FixedLengthRange {
    var firstValue: Int    // 变量存储属性
    let length: Int    // 常量存储属性
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// 该区间表示整数 0，1，2
rangeOfThreeItems.firstValue = 6
// 该区间现在表示整数 6，7，8

// 常量结构体实例的存储属性
// 如果创建了一个结构体实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使它们被声明为可变属性：
let rangeOfFourItems2 = FixedLengthRange(firstValue: 0, length: 4)
// 该区间表示整数 0，1，2，3
// rangeOfFourItems2.firstValue = 6 // 尽管 firstValue 是个可变属性，但这里还是会报错
// 这种行为是由于结构体属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
// 属于引用类型的类别则不一样，把一个引用类型的实例赋给一个常量后，依然可以修改该实例的可变属性

// 延时加载存储属性    延时加载存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延时加载存储属性。
// 必须将延时加载属性声明成变量（使用 var 关键词） 因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延时加载。
// 如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。因此 lazy 不是线程安全的
class DataImporter {
    /*
    DataImporter 是一个负责将外部文件中的数据导入的类。
    这个类的初始化会消耗不少时间。
    */
    var filename = "data.txt"
    // 这里会提供数据导入功能
}
class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // 这里会提供数据管理功能
}
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// DataImporter 实例的 importer 属性还没有被创建
print(manager.importer.filename)
// DataImporter 实例的 importer 属性现在被创建了
// 输出“data.txt”

// 计算属性    类似 Kotlin 重写属性的 get set
// 除存储属性外，类、结构体和枚举还可以定义计算属性。计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
    size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
// initialSquareCenter 位于（5.0， 5.0）
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// 打印“square.origin is now at (10.0, 10.0)”

// 简化 Setter 声明
// 如果计算属性的 setter 没有为要设置的新值定义名称，则默认会使用 newValue 作为名称
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// 简化 Getter 声明
// 如果 getter 的主体是一个单一表达式，那么 getter 会隐式返回该表达式
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// 只读计算属性
// 只有 getter 而没有 setter 的计算属性被称为只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置为其他值。
// 可以通过省略 get 关键字和它的花括号来简化只读计算属性的声明：
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// 打印 "the volume of fourByFiveByTwo is 40.0"

// 属性观察器
// 属性观察器用于监测并响应属性值的变化。每次属性值被设置时，无论新值是否与当前值相同，属性观察器都会被调用。
/*
 可以为属性添加以下一个或两个观察器：
  - willSet 在值存储之前被调用。
  - didSet 在新值存储之后立即被调用。
 */
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// 将 totalSteps 的值设置为 200
// 增加了 200 步
stepCounter.totalSteps = 360
// 将 totalSteps 的值设置为 360
// 增加了 160 步
stepCounter.totalSteps = 896
// 将 totalSteps 的值设置为 896
// 增加了 536 步

// 属性包装器
/*
 属性包装器在管理属性存储方式的代码和定义属性的代码之间添加了一层分离。
 例如，如果有一些属性需要提供线程安全检查或将其底层数据存储在数据库中，那么你必须在每个属性上编写这些代码。
 而使用属性包装器时，只需在定义包装器时编写一次管理代码，然后通过将其应用于多个属性来重复使用这些管理代码。
 要定义属性包装器，需要创建一个结构体、枚举或类，并定义一个 wrappedValue 属性
 */
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}
// 可以通过在属性前作为特性写上包装器的名称来应用包装器
struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}
var rectangle = SmallRectangle()
print(rectangle.height)    // 打印 "0"
rectangle.height = 10
print(rectangle.height)    // 打印 "10"
rectangle.height = 24
print(rectangle.height)    // 打印 "12"

// 设置被包装属性的初始值
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}
var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)    // 打印 "0 0"

struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}
var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)    // 打印 "1 1"

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}
var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)    // 打印 "2 3"
narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)    // 打印 "5 4"

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}
var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)    // 打印 "1"
mixedRectangle.height = 20
print(mixedRectangle.height)    // 打印 "12"

// 从属性包装器中呈现一个值    一个包装器可以通过实现 projectedValue 属性来提供被呈现值
@propertyWrapper
struct SmallNumber2 {
    private var number: Int
    private(set) var projectedValue: Bool    // 被呈现值
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    init() {
        self.number = 0
        self.projectedValue = false
    }
}
struct SomeStructure {
    @SmallNumber2 var someNumber: Int
}
var someStructure = SomeStructure()
someStructure.someNumber = 4
print(someStructure.$someNumber)    // 打印 "false"
someStructure.someNumber = 55
print(someStructure.$someNumber)    // 打印 "true"

// 全局变量和局部变量
/*
 全局常量和变量总是以类似于 doc:Properties#Lazy-Stored-Properties 的方式被延迟计算。与延迟存储属性不同，全局常量和变量不需要用 lazy 修饰符标记。
 局部常量和变量从不延迟计算。
 */

// 类型属性    静态
/*
 与存储实例属性不同，存储类型属性必须始终指定默认值。这是因为类型本身没有构造器，无法在初始化时为存储类型属性赋值。
 存储类型属性在第一次访问时会被延迟初始化。即使在多个线程同时访问时，也保证只会初始化一次，并且不需要用 lazy 修饰符标记。
 */

// 类型属性语法
struct SomeStructure2 {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

// 获取和设置类型属性的值
print(SomeStructure2.storedTypeProperty)       // 打印 "Some value."
SomeStructure2.storedTypeProperty = "Another value."
print(SomeStructure2.storedTypeProperty)       // 打印 "Another value."
print(SomeEnumeration.computedTypeProperty)    // 打印 "6"
print(SomeClass.computedTypeProperty)          // 打印 "27"
