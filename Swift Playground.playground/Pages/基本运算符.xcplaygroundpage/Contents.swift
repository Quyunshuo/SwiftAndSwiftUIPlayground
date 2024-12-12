// 赋值运算符
let (x, y) = (1, 2) // 元组赋值  x 等于 1, y 等于 2

// 三元运算符
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)    // rowHeight 等于 90

// 空合并运算符
let defaultColorName = "red"
var userDefinedColorName: String?   // 默认为 nil
var colorNameToUse = userDefinedColorName ?? defaultColorName    // userDefinedColorName 为空，所以 colorNameToUse 为默认值 "red"

// 区间运算符
// 1.闭区间运算符  闭区间运算符（a...b）定义了一个从 a 到 b 的范围，包括 a 和 b 的值。a 的值不能大于 b
for index in 1...5 {
    print("\(index) 乘以 5 等于 \(index * 5)") 
}
// 2.半开区间运算符  半开区间运算符（a..<b）定义了一个从 a 到 b 但不包括 b 的范围
let names = ["Anna", "Alex", "Brian", "Jack"] 
let count = names.count
for i in 0..<count {
    print("第 \(i + 1) 个人叫 \(names[i])")
}
// 3.单侧区间  闭区间运算符有一种替代形式，用于一直延伸到尽可能远的区间
// 一个包含从索引 2 到数组末尾所有元素的区间。 在这些情况下，你可以省略区间运算符的一侧值。 这种区间被称为单侧区间，因为运算符只有一侧有值
for name in names[2...] { print(name) }
// Brian
// Jack
for name in names[...2] { print(name) }
// Anna
// Alex
// Brian 
// 半开区间运算符也有一种只写最后一个值的单侧形式。 就像在两侧都包含值时一样，最后一个值不包含在区间内
for name in names[..<2] { print(name) }
// Anna
// Alex
// 检查单侧区间是否包含特定值
let range = ...5
range.contains(7)   // false
range.contains(4)   // true
range.contains(-1)  // true

// 逻辑运算符
// 逻辑非（!a）
// 逻辑与（a && b）
// 逻辑或（a || b）
