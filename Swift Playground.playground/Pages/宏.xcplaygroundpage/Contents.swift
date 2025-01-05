// 宏
// 宏会在编译你的源代码时对其进行转换，从而让你避免手动编写重复的代码。在编译过程中，Swift 会先展开代码中的所有宏，然后再像往常一样构建代码。
// 宏展开始终是一种加法操作：宏会添加新代码，但绝不会删除或修改现有代码。
// 每个宏的输入和宏展开的输出都会被检查，以确保它们是语法上有效的 Swift 代码。同样，你传给宏的值以及宏生成的代码中的值也会被检查，以确保它们具有正确的类型。此外，如果宏的实现在展开宏时遇到错误，编译器会将其视为编译错误。这些保证让使用了宏的代码更容易被推导，也让人更容易发现诸如宏使用不当或宏实现有错误这样的问题。
/*
 Swift 有两种宏:
  - 独立宏（Freestanding macros） 可单独出现，无需被附加到任何声明中。
  - 附加宏（Attached macros） 会修改它被附加到的声明。
 */
// 附加宏和独立宏的调用方式略有不同，但它们都遵循相同的宏展开模型，并都使用相同的方法来实现。下面的章节将更详细地描述这两种宏。

// 独立宏
// 要调用独立宏，需要在其名称前写入井号 (#)，并在名称后的括号中写入宏的参数。例如：
func myFunction() {
    print("Currently running \(#function)")
    #warning("Something's wrong")
}
// 在函数内的第一行中，#function 调用了 Swift 标准库中的 function() 宏。当你编译此代码时，Swift 会调用该宏的实现，将 #function 替换为当前函数的名称。当你运行这段代码并调用 myFunction() 时，它会打印 “Currently running myFunction()”。在第二行中，#warning 调用了 Swift 标准库中的 warning(_:) 宏，来生成一个自定义的编译时警告。
// 独立宏可以像 #function 所做的那样产出一个值，也可以像 #warning 所做的那样在编译时执行一个操作。

// 附加宏
// 要调用附加宏，需要在其名称前写入 at 符号 (@) ，并在名称后的括号中写入宏的参数。
// 附加宏会修改它们所附加到的声明。它们为被附加到的声明添加代码，比如定义一个新的方法或者增加对某个协议的遵循。
// 🌰：例如，请看下面这段不使用宏的代码：
struct SundaeToppings: OptionSet {
    let rawValue: Int
    static let nuts = SundaeToppings(rawValue: 1 << 0)
    static let cherry = SundaeToppings(rawValue: 1 << 1)
    static let fudge = SundaeToppings(rawValue: 1 << 2)
}
// 下面是该代码使用宏后的替代版本：
/*
 @OptionSet<Int>
 struct SundaeToppings2 {
     private enum Options: Int {
         case nuts
         case cherry
         case fudge
     }
 }
 */
// 此版本的 SundaeToppings 调用了 @OptionSet 宏。这个宏会读取私有枚举类中的枚举值列表，并为其中的每个值生成常量列表，同时也会为结构体增加对 OptionSet 协议的遵循。
// 作为对比，@OptionSet 宏展开后是下面这样。这段代码不是由你自己编写的，只有当你特别要求 Swift 展示宏的展开时，你才会看到它。
struct SundaeToppings2 {
    private enum Options: Int {
        case nuts
        case cherry
        case fudge
    }
    typealias RawValue = Int
    var rawValue: RawValue
    init() { self.rawValue = 0 }
    init(rawValue: RawValue) { self.rawValue = rawValue }
    static let nuts: Self = Self(rawValue: 1 << Options.nuts.rawValue)
    static let cherry: Self = Self(rawValue: 1 << Options.cherry.rawValue)
    static let fudge: Self = Self(rawValue: 1 << Options.fudge.rawValue)
}
extension SundaeToppings2: OptionSet { }
