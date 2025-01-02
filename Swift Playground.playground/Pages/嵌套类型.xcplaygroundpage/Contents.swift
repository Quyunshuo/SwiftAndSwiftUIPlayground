// 嵌套类型
// 嵌套类型是指在一个类型内部定义另一个类型。这种设计通常用于将逻辑上相关的类型组织在一起，使代码更具模块化和可读性。

// 1. 结构体中的嵌套类型
struct VendingMachine {
    enum Selection {
        case snack, drink, candy
    }
    func vend(item: Selection) {
        switch item {
        case .snack:
            print("Dispensing a snack")
        case .drink:
            print("Dispensing a drink")
        case .candy:
            print("Dispensing candy")
        }
    }
}
let machine = VendingMachine()
machine.vend(item: .drink) // 输出: Dispensing a drink
// 解释：
// Selection 枚举只与 VendingMachine 有关，因此嵌套在其中。
// 外部代码通过 VendingMachine.Selection 访问嵌套类型。

// 2. 枚举中的嵌套结构体
enum ChessPiece {
    struct Position {
        var x: Int
        var y: Int
    }
    case king(Position)
    case queen(Position)
}
let kingPosition = ChessPiece.Position(x: 3, y: 4)
let piece = ChessPiece.king(kingPosition)
print(piece) // 输出: king(Position(x: 3, y: 4))

// 3. 类中的嵌套类型
class School {
    enum Grade {
        case first, second, third
    }
    struct Student {
        var name: String
        var grade: Grade
    }
}
let student = School.Student(name: "Alice", grade: .second)
print(student) // 输出: Student(name: "Alice", grade: second)
