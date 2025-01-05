// 构造过程

// 存储属性的初始赋值
// 创建类和结构体的实例时，必须为它们所有的存储属性设置一个适当的初始值。存储属性不能处于不确定的状态。
// 当你为存储属性赋予默认值，或者在构造器中设置其初始值时，该属性的值会被直接设置，而不会触发任何属性观察器。
// 构造器 被调用来创建某个特定类型的新实例。构造器在最简单的形式中就像一个没有参数的实例方法，以关键字init 来命名：
/*
 init() {
     // 在此处执行构造过程
 }
 */
struct Fahrenheit1 {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit1()
print("The default temperature is \(f.temperature)° Fahrenheit")
// 打印 "The default temperature is 32.0° Fahrenheit"
// 默认属性值
struct Fahrenheit2 {
    var temperature = 32.0
}

// 自定义构造过程
// 形参的构造过程
// 你可以在自定义构造过程的定义中提供构造形参，指定其值的类型和名字。构造形参的功能和语法与函数和方法的形参相同。
// 🌰：下面例子中定义了一个用来保存摄氏温度的结构体 Celsius。它定义了两个不同的构造器：init(fromFahrenheit:) 和 init(fromKelvin:)，二者分别通过接受不同温标下的温度值来创建新的实例：
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius 是 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius 是 0.0

// 形参命名和实参标签
// 与函数和方法形参相同，构造形参可以同时具有在构造器内部使用的形参名称和在调用构造器时使用的实参标签。
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
// 两种构造器都能通过为每一个构造器形参提供命名值来创建一个新的 Color 实例：
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
// 如果不通过实参标签传值，这个构造器是没法调用的。如果构造器定义了某个实参标签，就必须使用它，忽略它将导致编译期错误：
// let veryGreen = Color(0.0, 1.0, 0.0)    // 报编译期错误-需要实参标签

// 不带实参标签的构造器形参
// 如果你不希望构造器的某个形参使用实参标签，可以使用下划线 (_) 来代替显式的实参标签来重写默认行为。
struct Celsius2 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {    // 省略掉实参标签
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius2(37.0)
// bodyTemperature.temperatureInCelsius 是 37.0

// 可选属性类型
// 可选类型的属性将自动初始化为 nil，表示这个属性是特意在构造过程设置为空。
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// 打印 "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."

// 构造过程中常量属性的赋值
// 你可以在构造过程中的任意时间点给常量属性赋值，只要在构造过程结束时将它设置成确定的值。一旦常量属性被赋值，它将永远不可更改。对于类的实例来说，它的常量属性只能在类的构造过程中修改，不能在子类中修改。
class SurveyQuestion2 {
    let text: String    // 将 text 属性声明为常量
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion2(text: "How about beets?")
beetsQuestion.ask()
// 打印 "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"

// 默认构造器
// 如果结构体或类为所有属性提供了默认值，又没有提供任何自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器。这个默认构造器将简单地创建一个所有属性值都设置为它们默认值的实例。
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
// 由于 ShoppingListItem 类的所有属性都有默认值，并且它是一个没有超类的基类。因此，ShoppingListItem 会自动获得一个默认构造器实现，该实现会创建一个新实例，并将其所有属性设置为默认值。（name 属性是一个可选的 String 属性，因此它会自动接收一个默认值 nil，即使这个值没有在代码中写出。）上面的示例使用 ShoppingListItem 类的默认构造器来创建一个类的新实例（ ShoppingListItem()形式的构造语法），并将其赋值给变量 item 。

// 结构体类型的成员逐一构造器
// 如果结构体类型没有定义任何自定义构造器，它们会自动获得逐一成员构造器。与默认构造器不同，即使存储属性没有默认值，结构体也会获得逐一成员构造器。
// 成员逐一构造器是一种用于初始化新结构体实例里成员属性的快捷方法。新实例的属性的初始值可以通过名称传递给逐一成员构造器。
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)    // 输出 "0.0 2.0"
let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)    // Prints "0.0 0.0"

// 值类型的构造器代理
// 构造器可以调用其他构造器来完成实例的部分构造过程。这个过程被称为构造器代理，它避免了在多个构造器中重复代码。
// 构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，因为它们只能代理给自己的其它构造器。 然而，类不一样，它可以继承自其他类（请参考doc:继承）。这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。
// 对于值类型，你可以使用 self.init 在自定义的构造器中引用相同值类型的构造器。并且，你只能在构造器内部调用 self.init 。
// 请注意，如果你为某个值类型定义了一个自定义构造器，你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器）。这种限制避免了在一个更复杂的构造器中做了额外的重要设置，但有人不小心使用自动生成的构造器而导致错误的情况。
// 如果你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中。
// 🌰：
struct Size2 {
    var width = 0.0, height = 0.0
}
struct Point2 {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point2()
    var size = Size2()
    init() {}
    init(origin: Point2, size: Size2) {
        self.origin = origin
        self.size = size
    }
    init(center: Point2, size: Size2) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point2(x: originX, y: originY), size: size)
    }
}

// 类的继承和构造过程
// 类里面的所有存储型属性———包括所有继承自父类的属性——都必须在构造过程中设置初始值。
// Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们被称为指定构造器和便利构造器。

// 指定构造器和便利构造器
// 指定构造器 是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并调用合适的父类构造器让构造过程沿着父类链继续往上进行。
// 每一个类都必须至少拥有一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。
// 便利构造器 是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为部分形参提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。
// 你应当只在必要的时候为类提供便利构造器，比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器，能够节省更多开发时间并让类的构造过程更清晰明了。

// 指定构造器和便利构造器的语法
// 类的指定构造器的写法跟值类型简单构造器一样:
/*
 init(<#parameters#>) {
    <#statements#>
 }
 */
// 便利构造器也采用相同样式的写法，但需要在 init 关键字之前放置 convenience 关键字，并使用空格将其分开:
/*
 convenience init(<#parameters#>) {
    <#statements#>
 }
 */

// 类类型的构造器代理
/*
 为了简化指定构造器和便利构造器之间的调用关系，Swift 构造器之间的代理调用遵循以下三条规则:
 规则 1: 指定构造器必须调用其直接父类的的指定构造器。
 规则 2: 便利构造器必须调用 相同 类中定义的其它构造器.
 规则 3: 便利构造器最后必须调用指定构造器。
 一个更方便记忆的方法是:
  - 指定构造器必须总是 向上 代理
  - 便利构造器必须总是 横向 代理
 */

// 两段式构造过程
// Swift 中类的构造过程包含两个阶段。第一个阶段，类中的每个存储型属性赋一个初始值。当每个存储型属性的初始值被赋值后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步自定义它们的存储型属性。
// 两段式构造过程的使用让构造过程更安全，同时在整个类层级结构中给予了每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值。
// Swift 的两段式构造过程跟 Objective-C 中的构造过程类似。最主要的区别在于阶段 1，Objective-C 给每一个属性赋值零或空值(比如说 0 或 nil)。 Swift 的构造流程则更加灵活，它允许你设置定制的初始值，并自如应对某些属性不能以 0 或 nil 作为合法默认值的情况

// 构造器的继承和重写
// 跟 Objective-C 中的子类不同，Swift 中的子类默认情况下不会继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，而在用来创建子类的新实例时没有完全或错误被初始化。
// 当你在编写一个和父类中指定构造器相匹配的子类构造器时，你实际上是在重写父类的这个指定构造器。因此，你必须在定义子类构造器时带上 override 修饰符。即使你重写的是系统自动提供的默认构造器，也需要带上 override 修饰符
// 正如重写属性，方法或者是下标，override 修饰符会让编译器去检查父类中是否有相匹配的指定构造器，并验证构造器参数是否按预想中被指定。
// 🌰：
// Vehicle 类只为存储型属性提供默认值，也没有提供自定义构造器。因此，它会自动获得一个默认构造器。默认构造器（如果有的话）总是类中的指定构造器。
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")
// Vehicle: 0 wheel(s)
class Bicycle: Vehicle { // 子类 Bicycle 继承 Vehicle
    override init() {// 这个指定构造器和父类的指定构造器相匹配，所以 Bicycle 中这个版本的构造器需要带上 override 修饰符
        super.init()
        numberOfWheels = 2
    }
}
// 如果子类的构造器没有在阶段 2 过程中做自定义操作，并且父类有一个同步、无参数的指定构造器，你可以在所有子类的存储属性赋值之后省略 super.init() 的调用。若父类的构造器是异步的，你就需要明确地写入 await super.init() 。
// 🌰：这个例子定义了另一个 Vehicle 的子类 Hoverboard ，只设置它的 color 属性。这个构造器依赖隐式调用父类的构造器来完成，而不是显式调用 super.init() 。
class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() 在这里被隐式调用
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}
// 子类可以在构造过程修改继承来的变量属性，但是不能修改继承来的常量属性。

// 构造器的自动继承
// 如上所述，子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以 被 自动继承的。事实上，这意味着对于许多常见场景你不必重写父类的构造器，并且可以在安全的情况下以最小的代价继承父类的构造器。
// 假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则将适用:
/*
 规则 1: 如果子类没有定义任何指定构造器，它将自动继承父类所有的指定构造器。
 规则 2: 如果子类提供了 所有 父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承父类所有的便利构造器。
 即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。
 */
// 注意 子类可以将父类的指定构造器实现为便利构造器来满足规则 2。

// 可失败构造器
// 有时，定义一个构造器可失败的类，结构体或者枚举是很有用的。这里的“失败” 指的是，如给构造器传入无效的形参，或缺少某种所需的外部资源，又或是不满足某种必要的条件等。
// 为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在 init 关键字后面添加问号 (init?) 。
// 注意 可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
// 可失败构造器会创建一个类型为自身类型的 可选 类型的对象。你通过 return nil 语句来表明可失败构造器在何种情况下应该 “失败”。
// 注意 严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确构造。因此你只是用 return nil 表明可失败构造器构造失败，而不要用关键字 return 来表明构造成功。
// 🌰：下面示例中，定义一个名为 Animal 的结构体，其中有一个名为 species 的 String 类型的常量属性。同时该结构体还定义了一个接受一个名为 species 的 String 类型形参的可失败构造器。这个可失败构造器检查传入的 species 值是否为一个空字符串。如果为空字符串，则构造失败。否则， species 属性被赋值，构造成功。
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
// someCreature 的类型是 Animal?, 而不是 Animal
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// 打印 "An animal was initialized with a species of Giraffe"
let anonymousCreature = Animal(species: "")
// anonymousCreature 的类型是 Animal?, 而不是 Animal
if anonymousCreature == nil {
    print("The anonymous creature couldn't be initialized")
}
// 打印 "The anonymous creature couldn't be initialized"

// 枚举类型的可失败构造器
// 你可以通过一个基于一个或多个形参的可失败构造器来获取枚举类型中特定的枚举成员。如果提供的形参无法匹配任何枚举成员，则构造失败。
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// 打印 "This is a defined temperature unit, so initialization succeeded."
let unknownUnit = TemperatureUnit(symbol: "X") // 传入一个不能匹配成功的字符串 X
if unknownUnit == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}
// 打印 "This isn't a defined temperature unit, so initialization failed."

// 带原始值的枚举类型的可失败构造器
// 带原始值的枚举类型会自带一个可失败构造器 init?(rawValue:) ，该可失败构造器有一个合适的原始值类型的 rawValue 形参，选择找到的相匹配的枚举成员，找不到则构造失败。
enum TemperatureUnit2: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}
let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
if fahrenheitUnit2 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// 打印 "This is a defined temperature unit, so initialization succeeded."
let unknownUnit2 = TemperatureUnit2(rawValue: "X")
if unknownUnit2 == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}
// 打印 "This isn't a defined temperature unit, so initialization failed."

// 构造失败的传递
// 类、结构体、枚举的可失败构造器可以横向代理到它们自己其他的可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。
// 无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止，接下来的任何构造代码不会再被执行。
// 注意 可失败构造器也可以代理到其它的不可失败构造器。通过这种方式，你可以增加一个可能的失败状态到现有的构造过程中。
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}
// CartItem 可失败构造器首先验证接收的 quantity 值是否大于等于1。倘若 quantity 值无效，则立即终止整个构造过程，返回失败结果，且不再执行余下代码。同样地， Product 的可失败构造器首先检查 name 值， 如果 name 值为空字符串，则构造器立即执行失败。
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// 打印 "Item: sock, quantity: 2"
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
// 打印 "Unable to initialize zero shirts"
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}
// 打印 "Unable to initialize one unnamed product"

// 重写一个可失败构造器
// 如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。
// 注意，当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。你可以用非可失败构造器重写可失败构造器，但反过来却不行。
class Document {
    var name: String?
    // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
    init() {}
    // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
// 使用强制解包来调用父类的可失败构造器
class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

// init! 可失败构造器
// 通常来说我们通过在 init 关键字后添加问号的方式 (init?) 来定义一个可失败的构造器。但你也可以通过在 init 后面添加感叹号的方式来定义一个可失败构造器 (init!) ，该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。
// 你可以在 init? 中代理到 init! ，反之亦然。你也可以用 init? 重写 init! ，反之亦然。你还可以用 init 代理到 init! ，不过，一旦 init! 构造失败，则会触发断言。

// 必要构造器
// 在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器:
class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}
// 在子类重写父类的必要构造器时，必须在子类的构造器前也添加 required 修饰符，表明该构造器要求也应用于继承链后面的子类。在重写父类中必要的指定构造器时，不需要添加 override 修饰符:
class SomeSubclass: SomeClass {
    required init() {
        // 子类的必要构造器实现
    }
}

// 通过闭包或函数设置属性的默认值
// 如果某个存储型属性的默认值需要一些自定义或设置，你可以使用闭包或全局函数为其提供定制的默认值。每当某个属性所在类型的新实例被构造时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性。
// 这种类型的闭包或函数通常会创建一个跟属性类型相同的临时变量，然后修改它的值以满足预期的初始状态，最后返回这个临时变量，作为属性的默认值。
// 下面模板介绍了如何用闭包为属性提供默认值：
/*
 class SomeClass {
     let someProperty: SomeType = {
         // 在这个闭包中给 someProperty 创建一个默认值
         // someValue 必须和 SomeType 类型相同
         return someValue
     }()
 }
 */
// 注意闭包结尾的花括号后面接了一对空的小括号。这用来告诉 Swift 立即执行此闭包。如果你忽略了这对括号，相当于将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
// 如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的 self 属性，或者调用任何实例方法。
