// 协议 Protocol
// 协议（Protocol） 定义了满足特定任务或功能所需的方法、属性和其他要求的蓝图。类、结构体或枚举可以 采用（adopt） 该协议，并提供协议要求的具体实现。任何满足协议要求的类型都被称为 遵循（conform） 该协议。

// 协议语法
// 协议的定义方式与类、结构体和枚举的定义非常相似：
protocol SomeProtocol {
    // 这里是协议的定义部分
}
protocol FirstProtocol {}
protocol AnotherProtocol {}
// 要让自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号（:）分隔。遵循多个协议时，各协议之间用逗号（,）分隔
struct SomeStructure: FirstProtocol, AnotherProtocol {
    // 这里是结构体的定义部分
}
// 如果一个类拥有父类，应该将父类名放在任何遵循的协议名之前，以逗号分隔：
class SomeSuperclass {}
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // 这里是类的定义部分
}

// 属性要求
// 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储属性还是计算属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读写的。
// 如果协议要求属性可读写，那么该属性不能是常量属性或只读的计算属性。如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果你自己的代码需要的话，还可以是可写的。
// 协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get }来表示属性是可读可写的，可读属性则用 { get } 来表示：
protocol SomeProtocol2 {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
// 在协议中定义类型属性时，总是使用 static 关键字作为前缀。当一个类遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性：
protocol AnotherProtocol2 {
    static var someTypeProperty: Int { get set }
}
// 🌰：
protocol FullyNamed {
    var fullName: String { get }    // 要求遵循协议的类型提供一个可读的属性 fullName: String 
}
struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
// john.fullName 为 "John Appleseed"
class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {    // 只读的计算属性
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName 为 "USS Enterprise"

// 方法要求
// 协议可以要求遵循协议的类型实现某些指定的实例方法和类方法。这些方法的编写方式与普通实例方法和类型方法完全相同，都写在协议定义的一部分中，但没有大括号或方法主体。协议允许使用可变参数，和普通方法的定义方式相同。但是，不能在协议定义中为方法参数指定默认值。
// 正如属性要求中所述，在协议中定义类方法的时候，总是使用 static 关键字作为前缀。即使在类中实现时，类方法要求使用 class 或 static 作为关键字前缀，这条规则仍然适用：
protocol RandomNumberGenerator {
    func random() -> Double
}
// 🌰：
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")    // 打印 “Here's a random number: 0.37464991998171”
print("And another one: \(generator.random())")           // 打印 “And another one: 0.729023776863283”

// 变值方法要求
// 如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前加 mutating 关键字。这使得结构体和枚举能够遵循此协议并满足此方法要求。
// 实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。mutating 关键字只用于结构体和枚举。
protocol Togglable {
    mutating func toggle()
}
// 🌰：
enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()    // lightSwitch 现在的值为 .on

// 构造器要求
// 协议可以要求遵循协议的类型实现指定的构造器。你可以像编写普通构造器那样，在协议的定义里写下构造器的声明，但不需要写花括号和构造器的实体：
protocol SomeProtocol4 {
    init(someParameter: Int)
}
// 协议构造器要求的类实现
// 你可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符，使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能遵循协议。如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类。
class SomeClass2: SomeProtocol4 {
    required init(someParameter: Int) {
        // 这里是构造器的实现部分
    }
}
// 如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的构造器要求，那么该构造器的实现需要同时标注 required 和 override 修饰符：
protocol SomeProtocol5 {
    init()
}
class SomeSuperClass {
    init() {
        // 这里是构造器的实现部分
    }
}
class SomeSubClass: SomeSuperClass, SomeProtocol5 {
    // 因为遵循协议，需要加上 required；因为继承自父类，需要加上 override
    required override init() {
        // 这里是构造器的实现部分
    }
}
// 可失败构造器要求
// 协议还可以为遵循协议的类型定义可失败构造器要求
// 遵循协议的类型可以通过可失败构造器（init?）或非可失败构造器（init）来满足协议中定义的可失败构造器要求。协议中定义的非可失败构造器要求可以通过非可失败构造器（init）或隐式解包可失败构造器（init!）来满足。

// 协议作为类型
// 协议本身并不实现任何功能。尽管如此，你仍然可以在代码中将协议用作类型。
// 最常见的将协议用作类型的方式是将其用作泛型约束。具有泛型约束的代码可以与任何符合该协议的类型一起工作，具体的类型由使用该 API 的代码选择。
// 在代码中使用不透明类型时，可以与某个符合该协议的类型一起工作。底层类型在编译时是已知的，API 实现会选择该类型，但该类型的身份对 API 的使用方是隐藏的。使用不透明类型可以防止 API 的实现细节泄露到抽象层之外 —— 例如，通过隐藏函数的具体返回类型，并仅保证该值符合给定的协议。
// 代码使用装箱（boxed）的协议类型时，可以与任何在运行时选择的、符合该协议的类型一起工作。为了支持这种运行时的灵活性，Swift 在必要时会添加一个间接层 —— 称为 箱子（box），这会带来性能开销。由于这种灵活性，Swift 在编译时无法知道底层类型，这意味着你只能访问协议所要求的成员。要访问底层类型的任何其他 API，都需要在运行时进行类型转换。

// 代理
// 代理（Delegate） 是一种设计模式，它允许类或结构体将一些需要它们负责的功能代理给其他类型的实例。代理模式的实现很简单：定义协议来封装那些需要被代理的功能，这样就能确保遵循协议的类型能提供这些功能。代理模式可以用来响应特定的动作，或者接收外部数据源提供的数据，而无需关心外部数据源的类型。

// 在扩展里添加协议遵循
// 当一个协议的遵循被添加到实例类型的扩展中时，现有的实例会自动采用并遵循该协议。
// 通过扩展遵循并适配协议，和在原始定义中采用并遵循协议的效果完全相同。协议名称写在类型名之后，以冒号隔开，然后在扩展的大括号内实现协议要求的内容。
// 🌰：
class A {
    let name:String
    init(name:String){
        self.name = name
    }
}
protocol TextRepresentable {
    var textualDescription: String { get }
}
extension A:TextRepresentable{
    var textualDescription: String {
        return name
    }
}
let a = A(name: "Yunshuo")
print(a.textualDescription)    // Yunshuo

// 有条件地遵循协议
// 泛型类型可能只在某些情况下满足一个协议的要求，比如当类型的泛型形式参数遵循对应协议时。你可以通过在扩展类型时列出限制让泛型类型有条件地遵循某协议。在你采用协议的名字后面写泛型 where 分句。更多关于泛型 where 分句，参见 doc:Generics#Generic-Where-Clauses。

// 在扩展里声明协议遵循
// 当一个类型已经遵循了某个协议中的所有要求，却还没有声明遵循该协议时，可以通过空的扩展来让它遵循该协议：
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// 打印 “A hamster named Simon”

// 使用合成实现来遵循协议
// Swift 可以在很多简单场景下自动提供遵循 Equatable、Hashable 和 Comparable 协议的实现。在使用这些合成实现之后，无需再编写重复的样板代码来实现这些协议所要求的方法。
/*
 Swift 为以下几种自定义类型提供了 Equatable 协议的合成实现：
  - 只包含遵循 Equatable 协议的存储属性的结构体
  - 只包含遵循 Equatable 协议的关联类型的枚举
  - 没有任何关联类型的枚举
 在包含类型原始声明的文件中声明对 Equatable 协议的遵循，可以得到 == 操作符的合成实现，且无需自己编写任何关于 == 的实现代码。Equatable 协议同时包含 != 操作符的默认实现。
 */
struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}
let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}
// 打印 "These two vectors are also equivalent."
/*
 Swift 为以下几种自定义类型提供了 Hashable 协议的合成实现：
  - 只包含遵循 Hashable 协议的存储属性的结构体
  - 只包含遵循 Hashable 协议的关联类型的枚举
  - 没有任何关联类型的枚举
 在包含类型原始声明的文件中声明对 Hashable 协议的遵循，可以得到 hash(into:) 的合成实现，且无需自己编写任何关于 hash(into:) 的实现代码。
 */
/*
 在包含类型原始声明的文件中声明对 Hashable 协议的遵循，可以得到 hash(into:) 的合成实现，且无需自己编写任何关于 hash(into:) 的实现代码。
 Swift 为没有原始值的枚举类型提供了 Comparable 协议的合成实现。如果枚举类型包含关联类型，那这些关联类型也必须同时遵循 Comparable 协议。在包含原始枚举类型声明的文件中声明其对 Comparable 协议的遵循，可以得到 < 操作符的合成实现，且无需自己编写任何关于 < 的实现代码。Comparable 协议同时包含 <=、> 和 >= 操作符的默认实现。
 */

// 协议类型的集合
// 协议类型可以在数组或者字典这样的集合中使用，在 doc:Protocols#Protocols-as-Types 提到了这样的用法。下面的例子创建了一个元素类型为 TextRepresentable 的数组：
let things: [TextRepresentable] = [a, simonTheHamster]

// 协议的继承
// 协议能够 继承（inherit） 一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔：
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 这里是协议的定义部分
}
// 🌰：
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

// 类专属的协议
// 通过添加 AnyObject 关键字到协议的继承列表，就可以限制协议只能被类类型遵循（而不能是结构体类型或者枚举类型）。
protocol SomeClassOnlyProtocol: AnyObject {
    // 这里是类专属协议的定义部分
}
// 在以上例子中，协议 SomeClassOnlyProtocol 只能被类类型遵循。如果尝试让结构体或枚举类型遵循 SomeClassOnlyProtocol，则会导致编译时错误。

// 协议组合
// 要求一个类型同时遵循多个协议是很有用的。你可以使用 协议组合 来组合多个协议到一个要求里。协议组合的行为就和你定义的临时局部协议一样，拥有组合中所有协议的需求。协议组合不定义任何新的协议类型。
// 协议组合使用 SomeProtocol & AnotherProtocol 的形式。你可以列举任意数量的协议，用和符号（&）分开。除了协议列表，协议组合也能包含类类型，这允许你标明一个需要的父类。
// 🌰：下面的例子中，将 Named 和 Aged 两个协议按照上述语法组合成一个协议，作为函数参数的类型：
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct PersonStruct: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {    // 参数需要同时遵循 Named 和 Aged 协议
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = PersonStruct(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)
// 打印 “Happy birthday Malcolm - you're 21!”

// 检查是否遵循协议
/*
 你可以使用 类型转换 中描述的 is 和 as 操作符来检查是否遵循某协议，并且可以类型转换到指定的协议。检查和转换协议的语法与检查和转换类型是完全一样的：
  - is 用来检查实例是否遵循某个协议，若遵循则返回 true，否则返回 false。
  - as? 返回一个可选值，当实例遵循某个协议时，返回类型为协议类型的可选值，否则返回 nil。
  - as! 将实例强制向下转换到某个协议类型，如果强转失败，将触发运行时错误。
 */

// 可选协议要求
// 协议可以定义 可选要求（optional requirements），遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上 @objc 属性。注意被标记为 @objc 的协议只能被类遵循，不能被结构体和枚举遵循。
// 使用可选要求中的方法或者属性时，它们的类型会自动变成可选的。比如，一个类型为 (Int) -> String 的方法会变成 ((Int) -> String)?。需要注意的是整个函数类型是可选的，而不是函数的返回值。
// 🌰：下面的例子定义了一个名为 Counter 的用于整数计数的类，它使用外部的数据源来提供每次的增量。数据源由 CounterDataSource 协议定义，它包含两个可选要求：
import Foundation    // 导入 Foundation 以使用 @objc
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

// 协议扩展
// 协议可以通过扩展来为遵循协议的类型提供方法、初始化方法、下标以及计算属性的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现，也无需使用全局函数。
// 协议扩展可以为遵循协议的类型增加实现，但不能声明该协议继承自另一个协议。协议的继承只能在协议声明处进行指定。
// 🌰：例如，可以扩展 RandomNumberGenerator 协议来提供 randomBool() 方法。该方法使用协议中定义的 random() 方法来返回一个随机的 Bool 值：
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
// 通过添加协议扩展，所有遵循协议的类型，都能自动获得这个扩展所增加的方法实现，而无需任何额外修改。
let generator2 = LinearCongruentialGenerator()
print("Here's a random number: \(generator2.random())")
// 打印 “Here's a random number: 0.37464991998171”
print("And here's a random Boolean: \(generator2.randomBool())")
// 打印 “And here's a random Boolean: true”

// 提供默认实现
// 你可以通过协议扩展来为协议要求的方法、计算属性提供默认的实现。如果遵循协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
// 通过协议扩展为协议要求提供的默认实现和可选的协议要求不同。虽然在这两种情况下，遵循协议的类型都无需自己实现这些要求，但是通过扩展提供的默认实现可以直接调用，而无需使用可选链式调用。
// 🌰：例如，PrettyTextRepresentable 协议继承自 TextRepresentable 协议，可以为其提供一个默认的 prettyTextualDescription 属性来简单地返回 textualDescription 属性的值：
extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

// 为协议扩展添加限制条件
// 在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。这些限制条件写在协议名之后，使用 where 子句来描述，更多和泛型 where 子句的内容，参见 doc:Generics#Generic-Where-Clauses。
// 🌰：例如，你可以扩展 Collection 协议，适用于集合中的元素遵循了 Equatable 协议的情况。通过限制集合元素遵循 Equatable 协议（Swift 标准库的一部分）， 你可以使用 == 和 != 操作符来检查两个元素的等价性和非等价性。
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}
let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
// 由于数组遵循 Collection 并且整数遵循 Equatable，equalNumbers 和 differentNumbers 都可以使用 allEqual() 方法：
print(equalNumbers.allEqual())
// 打印 “true”
print(differentNumbers.allEqual())
// 打印 “false”
// 如果一个遵循类型满足了为同一方法或属性提供实现的多个有限制条件的协议扩展的要求，Swift 会使用最贴合限制的实现。
