// 方法
// 实例方法
/*
 这是一个定义简单“Counter”类的示例，可用于计算某个动作发生的次数：
 Counter 类定义了三个实例方法：
 increment() 将计数器增加 1。
 increment(by: Int) 将计数器增加指定的整数值。
 reset() 将计数器重置为零。
 Counter 类还声明了一个变量属性 count，用于跟踪当前的计数器值。
 */
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

// self 属性    每个类型的实例都有一个隐式属性，称为 self，它与实例本身完全等同，也就是 this

// 从实例方法内部修改值类型
// 结构体和枚举是 值类型。默认情况下，值类型的属性不能在其实例方法内部被修改。
struct Point {
    var x = 0.0, y = 0.0
    /*
     这个方法直接修改其调用的点，而不是返回一个新的点。为了使该方法能够修改其属性，mutating 关键字被添加到它的定义中
     */
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// Prints "The point is now at (3.0, 4.0)"

// 在 mutating 方法中给 self 赋值    mutating 方法可以将一个全新的实例赋值给隐式的 self 属性
struct Point2 {
    var x = 0.0, y = 0.0
    /*
     这个版本的 mutating moveBy(x:y:) 方法创建了一个新的结构体，其 x 和 y 值被设置为目标位置。 调用这个替代版本方法与调用早期版本方法的最终结果完全相同。
     */
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point2(x: x + deltaX, y: y + deltaY)
    }
}
// 枚举的 mutating 方法可以将隐式的 self 参数设置为同一枚举的不同case：
enum TriStateSwitch {
    case off, low, high
    /*
     这个示例定义了一个三状态开关的枚举。每次调用其 next() 方法时，开关将在三种不同的电源状态（off, low 和 high）之间循环切换。
     */
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off

// 类型方法（静态方法）    在方法的 func 关键字前添加 static 关键字来标识类型方法。 类可以使用 class 关键字代替 static ，以允许子类覆盖父类对该方法的实现。
class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()
// 示例
struct LevelTracker {
    // 已解锁的最高关卡
    static var highestUnlockedLevel = 1
    // 当前关卡
    var currentLevel = 1

    // 解锁关卡
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }

    // 判断关卡是否解锁
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    /*
     @discardableResult 是 Swift 中的一个属性，用来标记函数或方法的返回值可以被忽略。如果一个函数的返回值被标记为 @discardableResult，调用该函数时即使不使用返回值，编译器也不会发出警告。
     */
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

// 游戏玩家
class Player {
    // 记录关卡的结构体
    var tracker = LevelTracker()
    // 玩家名字
    let playerName: String
    // 完成关卡时调用
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Yunshuo Qu")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// Prints "highest unlocked level is now 2"
// 如果你创建第二个玩家，并尝试将其移动到尚未被任何玩家解锁的关卡，那么尝试设置玩家的当前等级时会失败：
player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 hasn't yet been unlocked")
}
// Prints "level 6 hasn't yet been unlocked"




















