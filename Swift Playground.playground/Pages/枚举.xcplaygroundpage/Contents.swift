
// 枚举 enum
// 语法
enum SomeEnumeration {
    // 枚举定义放在这里
}
// 示例
enum CompassPoint {
    case north
    case south
    case east
    case west
}
// 每个枚举都定义了一个全新的类型
var directionToHead = CompassPoint.west

// 使用 Switch 语句匹配枚举值
directionToHead = .south    // directionToHead在上面已经赋值，类型已知，所以可以使用 .语法来简化
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// 打印 "Watch out for penguins"

// 关联值
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// 如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个 let 或者 var：
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// 打印 "QR code: ABCDEFGHIJKLMNOP."
