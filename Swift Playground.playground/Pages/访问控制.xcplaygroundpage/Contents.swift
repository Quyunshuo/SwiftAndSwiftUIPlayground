// 访问控制

// 模块、源文件和包
// Swift 的访问控制模型是基于模块、源文件和包（packages）这三个概念的

// 访问级别

/*
 Swift 为代码中的实体提供了六种不同的访问级别。这些访问级别取决于实体所在的源文件、源文件所属的模块，以及模块所属的包。
  - open 和 public 允许实体被同一模块内的任意源文件使用，也可以在导入该模块的其他模块的源文件内使用。通常使用 open 或 public 访问级别来指定框架的公共接口。open 和 public 访问级别的区别将在下文中说明。
  - package 允许实体被同一模块内的任意源文件使用，但不能在包外的源文件内使用。通常在包含多个模块的应用或框架中使用 package。
  - internal 允许实体被同一模块内的任意源文件使用，但不能在模块外的源文件中使用。通常在定义应用或框架的内部结构体时使用 internal。
  - fileprivate 将对实体的使用限制在定义它的源文件内。当某个功能的实现细节只需要在当前文件中使用时，可以使用 fileprivate 来隐藏这些实现细节。
  - private 将对实体的使用限制在其声明的作用域内，以及同一文件中该声明的扩展（extension）内。当某个功能的实现细节只在单个声明内部使用时，可以使用 private 来隐藏这些实现细节。
 
 open 是最高（限制最少）的访问级别，而 private 是最低（限制最多）的访问级别。
 
 open 仅适用于类及类的成员，它与 public 的不同之处在于 open 允许模块外的代码进行继承和重写，如下文 doc:AccessControl#Subclassing 中所述。将类显式指定为 open 表明你已考虑到其他模块的代码将该类用作父类的影响，并为此相应地设计了类的代码。
 */

// 访问级别的指导原则
// 实体的定义都不能依赖于访问级别更低（更严格）的其他实体。

// 默认访问级别
// 如果没有显式指定访问级别，那么默认的访问级别是 internal

// 访问控制语法
// 在实体声明的前面添加修饰符 open、public、internal、fileprivate 或 private 来定义该实体的访问级别。
open class SomeOpenClass {
    open var someOpenVariable = 0
}
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

// 自定义类型
// public 类型的成员默认具有 internal 访问级别，而不是 public。如果你想让某个成员是 public，必须显式地将其指定为 public。这样可以确保公共 API 都是你经过选择才发布的，避免错误地将内部使用的接口公开。
public class SomePublicClass2 {                   // 显式指定为 public 类
    public var somePublicProperty = 0            // 显式指定为 public 类成员
    var someInternalProperty = 0                 // 隐式指定为 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式指定为 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式指定为 private 类成员
}
class SomeInternalClass2 {                        // 隐式指定为 internal 类
    var someInternalProperty = 0                 // 隐式指定为 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式指定为 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式指定为 private 类成员
}
fileprivate class SomeFilePrivateClass2 {         // 显式指定为 fileprivate 类
    func someFilePrivateMethod() {}              // 隐式指定为 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式指定为 private 类成员
}
private class SomePrivateClass2 {                 // 显式指定为 private 类
    func somePrivateMethod() {}                  // 隐式指定为 private 类成员
}

// 元组类型
// 元组类型的访问级别是由元组中访问级别最严格的类型决定的。例如，你构建了一个包含两种不同类型的元组，其中一个是 internal 访问级别，另一个是 private 访问级别，那么这个元组的访问级别将是 private。

// 函数类型
// 函数类型的访问级别是根据函数的参数类型和返回类型中最严格的访问级别计算得出的。如果函数计算出的访问级别与上下文默认值不匹配，则必须在函数定义中显式指定访问级别。

// 枚举类型
// 枚举成员的访问级别和其所属的枚举类型相同。你不能为单个枚举成员指定不同的访问级别。
// 枚举定义中的原始值或关联值的类型，其访问级别至少不能低于该枚举的访问级别。例如，你不能在访问级别为 internal 的枚举中使用 private 类型作为原始值类型。

// 嵌套类型
// 嵌套类型的访问级别和包含它的类型的访问级别相同，除非包含它的类型是 public。定义在 public 类型中的嵌套类型，其访问级别默认是 internal。如果你想让这个嵌套类型拥有 public 访问级别，那么必须显式将其声明为 public。

// 子类
// 可以继承同一模块中的所有有访问权限的类，也可以继承不同模块中被 open 修饰的类。子类的访问级别不得高于父类的访问级别。
// 此外，对于同一模块中定义的类，你可以重写在上下文中可访问的任意类成员（方法、属性、构造器或下标）。对于在其他模块中定义的类，你可以重写访问级别为 open 的任意类成员。
// 通过重写可以给子类的成员提供更高的访问级别

// 常量、变量、属性、下标
// 常量、变量或属性的访问级别不能高于其类型的访问级别
// 常量、变量、属性和下标的 getter 和 setter 会自动获得与它们所属的常量、变量、属性或下标相同的访问级别。
// 你可以为 setter 指定一个比对应 getter 更低的访问级别，以限制该变量、属性或下标的读写范围。你可以通过在 var 或 subscript 关键字之前写上 fileprivate(set)、private(set)、internal(set) 或 package(set) 来指定较低的访问级别。
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

// 构造器
// 自定义构造器的访问级别可以低于或等于它所初始化的类型。唯一的例外是必要构造器（如 doc:Initialization#Required-Initializers 中定义的）。必要构造器必须具有与其所属类相同的访问级别。
// 与函数和方法的参数一样，构造器的参数类型的访问级别不能比构造器自身的访问级别更严格。

// 协议
// 协议定义中的每个要求都必须具有和该协议相同的访问级别。你不能将协议要求的访问级别设置为其他访问级别。这样才能确保遵循该协议的任何类型都能访问协议中的所有要求。
// 如果你定义了一个 public 协议，那么在实现该协议时，协议的所有要求也需要具有 public 访问级别。这点与其他类型不同，在其他类型中，如果类型的访问级别是 public，通常意味着该类型的成员具有 internal 访问级别。
// 如果你定义了一个继承自其他协议的新协议，那么新协议的访问级别最高也只能与其继承的协议相同
// 

// 扩展
// 可以在访问级别允许的情况下对类、结构体或枚举进行扩展。在扩展中添加的类型成员具有与原始类型中声明的类型成员相同的默认访问级别。如果你扩展的是 public 或 internal 类型，那么任何新增的类型成员默认的访问级别是 internal。
// 扩展的私有成员
/*
 扩展同一文件内的类，结构体或者枚举，扩展里的代码会表现得跟声明在原始类型里的一模一样。因此，你可以：
  - 在原始声明中声明一个 private 成员，并在同一文件中的扩展中访问该成员。
  - 在一个扩展中声明一个 private 成员，并在同一文件中的另一个扩展中访问该成员。
  - 在扩展中声明一个 private 成员，并在同一文件中的原始声明中访问该成员。
 */

// 泛型
// 泛型类型或泛型函数的访问级别取决于它本身的访问级别和其类型参数的类型约束的访问级别，最终由这些访问级别中的最低者决定。

// 类型别名
// 在访问控制层面，你定义的任何类型别名都被视为独立的类型。类型别名的访问级别不可以高于其表示的类型的访问级别。
