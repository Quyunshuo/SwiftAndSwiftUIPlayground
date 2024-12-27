
/*
 比较结构体和类
 Swift 中的结构体和类有许多共同点。两者都可以:
  - 定义属性来存储值
  - 定义方法来提供功能
  - 定义下标来使用下标语法访问其值
  - 定义构造器来设置初始状态
  - 被扩展以增加默认实现之外的功能
  - 遵循协议以提供某种标准功能

 相比结构体,类有一些额外的功能:
  - 一个类可以继承另一个类的特征。
  - 类型转换允许你在运行时检查和解释类实例的类型。
  - 析构器允许一个类的实例释放其分配的任何资源。
  - 引用计数允许对类实例有多个引用。
 
 类支持的额外功能以增加其复杂性为代价。 作为一般准则，我们会优先使用结构体， 因为它们更易于理解，并在适当或必要时使用类。 在实践中，这意味着你定义的大多数自定义类型将是结构体和枚举。 
 */

// 定义语法    使用 struct 关键字引入结构体， 使用 class 关键字引入类
struct Resolution {
    var width = 0 
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// 结构体和类的实例    结构体和类都使用构造器语法来创建新实例
let someResolution = Resolution()
let someVideoMode = VideoMode()

// 访问属性
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280    // 赋值
print("The width of someVideoMode is now \(someVideoMode.resolution.width)") 

// 结构体逐一成员构造器    所有结构体都有一个自动生成的逐一成员构造器
let vga = Resolution(width: 640, height: 480)
// 结构体和枚举是值类型    值类型是一种在被赋值给变量或常量时， 或者在传递给函数时，其值会被复制的类型
let hd = Resolution(width: 1920, height: 1080) 
var cinema = hd    // 实际上 cinema 和 hd 已经是两个不同的实例了
// 因为 Resolution 是一个结构体， 所以会对现有实例进行复制，并将这个新副本赋值给 cinema。 尽管 hd 和 cinema 现在具有相同的宽度和高度， 但在底层它们是两个完全不同的实例。
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")    // 打印 "cinema is now 2048 pixels wide"
print("hd is still \(hd.width) pixels wide")    // 打印 "hd is still 1920 pixels wide"
// 内存示例图：https://doc.swiftgg.team/images/team.swiftgg.tspl/sharedStateStruct~dark@2x.png

// 类是引用类型
// 不同于值类型每次都会创建一个新的副本， 引用类型在被赋值给变量或常量， 或者在被传递给函数时不会被复制。 而是指向同一个现有实例的引用。
// 内存示例图：https://doc.swiftgg.team/images/team.swiftgg.tspl/sharedStateClass~dark@2x.png

// 恒等运算符
// 恒等 (===)
// 不恒等 (!==)
// 注意恒等（用三个等号 === 表示）与相等（用两个等号==表示）意义不同。 恒等意味着两个类型的常量或变量引用了完全相同的类实例。 相等意味着两个实例在值上被认为是相等或等价的， 具体的相等定义由类型的设计者决定。

























