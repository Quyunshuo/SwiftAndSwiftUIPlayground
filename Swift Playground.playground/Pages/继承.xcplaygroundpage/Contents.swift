// 继承
// 定义基类    如果一个类没有继承其他类，那他就是一个基类
// Swift 中没有统一的基类，所有类的起源都是平等的。不指定父类的类会自动成为基类。
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // 不做任何事情 - 不是任何一辆车都会发出噪音。
    }
}
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")     // Vehicle: traveling at 0.0 miles per hour

// 子类化    子类化是基于现有类创建新类的行为。子类继承现有类的特性，可以对其进行完善,可以向子类添加新的特性
/*
 语法：
 class 子类ClassName: 父类ClassName {
     // 子类定义在这里
 }
 */
class Bicycle: Vehicle {                 // 父类为 Vehicle
    var hasBasket = false                // 子类增加新的属性
}
class Tandem: Bicycle {                  // 父类为 Bicycle
    var currentNumberOfPassengers = 0    // 子类增加新的属性
}
let tandem = Tandem()
tandem.hasBasket = true                  // 父类 Bicycle 的属性
tandem.currentNumberOfPassengers = 2     // 子类自身的属性
tandem.currentSpeed = 22.0               // 父类 Vehicle 的属性
print("Tandem: \(tandem.description)")   // Tandem: traveling at 22.0 miles per hour

// 重写    子类可以提供自己的自定义实现来覆盖它将从父类继承的实例方法、类型方法、实例属性、类型属性或下标。这被称为重写。
// 重写方法需要在方法前使用 override 关键字

// 访问父类方法、属性和下标    使用 super 前缀来访问父类的方法、属性或下标

// 重写方法
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()    // 打印 "Choo Choo"

// 重写属性 Getter 和 Setter
// 可以通过在子类属性重写中提供 getter 和 setter 来将继承的只读属性表示为可读写属性。但是不能将继承的可读写属性声明为只读属性。
class Car: Vehicle {    // 继承自 Vehicle
    var gear = 1
    override var description: String {    // 重写了父类 Vehicle 的只读属性 description
        return super.description + " in gear \(gear)"    // 重写逻辑中调用了 父类的属性 description
    }
}

// 重写属性观察器
// 无法为继承的常量存储属性或继承的只读计算属性添加属性观察器。这些属性的值无法被修改，所以在重写时提供 willSet 或 didSet 实现是不合适的。
// 每当你设置 AutomaticCar 实例的 currentSpeed 属性时，该属性的 didSet 观察器会根据新速度为实例的 gear 属性设置一个合适的挡位
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

// 防止重写    可以通过将其标记为 final 来防止方法、属性或下标被重写。在方法、属性或下标的引入关键字前写 final 修饰符。（如 final var、final func、final class func 和 final subscript）
// 通过在类定义（final class）中在 class 关键字前写 final 修饰符来将整个类标记为 final。任何尝试子类化 final 类的行为都会在编译时报错。
