// Swift 提供了三种主要的 集合类型
// 数组：有序的值集合
// 集合：无序的唯一值集合
// 字典：无序的键值对关联集合
// 集合的可变性
// 声明为 var 允许数组、集合或字典进行改变
// 声明为 let 是不可变的

// 数组  将相同类型的值存储在一个有序列表中。相同的值可以在数组中以不同位置多次出现。
// 数组类型简写语法
// Swift 数组的类型完整写作 Array<Element>，其中 Element 是数组允许存储的值的类型。你也可以以简写形式 [Element] 来表示数组的类型
// 创建空数组
var someInts: [Int] = []                              // 构造器语法创建空数组
someInts.append(10086)
var threeDoubles = Array(repeating: 0.0, count: 3)    // 使用默认值创建数组 大小为3 值全都为 0.0
// 通过合并两个数组创建一个新数组
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles 的类型是 [Double]，并且等于 [2.5, 2.5, 2.5]
var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles 被推断为 [Double] 类型，并且等于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
// 使用数组字面量创建数组
var shoppingList: [String] = ["Eggs", "Milk"]
// 访问和修改数组
print("The shopping list contains \(shoppingList.count) items.")    // 获取数组中的项数
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list isn't empty.")
}
shoppingList.append("Flour")                               // 在末尾增加一个元素
shoppingList += ["Baking Powder"]                          // 在末尾合并一个数组
var firstItem = shoppingList[0]                            // 使用下标来获取元素
shoppingList[0] = "Six eggs"                               // 使用下标来修改元素
shoppingList[0...3] = ["Bananas", "Apples"]                // 更改指定范围的元素，是将指定范围的元素移除，替换为新的数组中的元素
shoppingList.insert("Maple Syrup", at: 0)                  // 在指定位置插入元素
let mapleSyrup = shoppingList.remove(at: 0)                // 删除指定位置的元素，并返回该元素
let apples = shoppingList.removeLast()                     // 删除数组中的最后一个元素，并返回该元素
for item in shoppingList {                                 // 遍历数组
    print(item)
}
for (index, value) in shoppingList.enumerated() {          // 遍历数组，会返回一个索引和元素组成的元组
    print("Item \(index + 1): \(value)")
}

// 集合 将相同类型的不同值存储在没有定义序列化的集合中。当项的顺序不重要，或者需要确保项只出现一次时，可以使用集合而不是数组。相当于 Java/Kotlin 中的 Sert
// 集合类型的哈希值
/*
 一个类型必须是 可哈希的 才能存储在集合中—也就是说，该类型必须提供一种为自身计算 哈希值 的方法。哈希值是一个 Int 类型的值，对于所有相等的对象，它们的哈希值相同。也就是说，如果 a == b，那么 a 的哈希值必须等于 b 的哈希值。
 */
var letters = Set<Character>()                             // 创建一个空集合
letters.insert("A")                                        // 插入一个元素
letters = []                                               // 变为空集合
var favoriteGenres: Set<String> = ["Rock", "Hip hop"]      // 使用字面量创建一个集合
if favoriteGenres.contains("Funk") {                       // 判断集合中是否包含指定元素
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
// 基本集合操作 图示：https://doc.swiftgg.team/images/team.swiftgg.tspl/setVennDiagram~dark@2x.png
/*
 使用 intersection(_:) 方法创建一个只包含两个集合共有值的新集合。
 使用 symmetricDifference(_:) 方法创建一个包含两个集合中存在但不同时存在的值的新集合。
 使用 union(_:) 方法创建一个包含两个集合中所有值的新集合。
 使用 subtracting(_:) 方法创建一个不包含指定集合中值的新集合。
 */
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
oddDigits.union(evenDigits).sorted()                                // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()                         // []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()             // [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()     // [1, 2, 9]
// 集合成员关系与相等
/*
 使用 “等于” 运算符 （==）判断两个集合是否包含相同的所有值。
 使用 isSubset(of:) 方法判断一个集合的所有值是否包含在指定集合中。
 使用 isSuperset(of:) 方法判断一个集合是否包含指定集合中的所有值。
 使用 isStrictSubset(of:) 或 isStrictSuperset(of:) 方法判断一个集合是否是指定集合的子集或超集（但不相等）。
 使用 isDisjoint(with:) 方法判断两个集合是否没有共同的值。
 */

// 字典相当于 Java/Kotlin 中的 Map  将相同类型的键与集合中相同类型的值之间的关联存储在集合中，没有定义顺序。每个值都与一个唯一键相关联，该 键 充当字典中该值的标识符
// Swift 字典的完整类型写作 Dictionary<Key, Value>  也可以将字典的类型以简写形式写成 [Key: Value]
var namesOfIntegers: [Int: String] = [:]                        // 创建空字典
namesOfIntegers[16] = "sixteen"                                 // namesOfIntegers 现在包含 1 个键值对
namesOfIntegers = [:]                                           // namesOfIntegers 再次成为一个类型为 [Int: String] 的空字典
var airports: [String: String] = ["DUB": "Dublin"]              // 使用字面量创建字典
var airports2 = ["DUB": "Dublin"]                               // 与数组一样，如果使用的字典字面量的键和值具有一致的类型，则不必指定字典的类型
airports["LHR"] = "London"                                      // 添加新的元素
airports["LHR"] = "London Heathrow"                             // 修改指定键的值
airports["LHR"] = nil                                           // LHR 已经从字典中删除
if let removedValue = airports.removeValue(forKey: "DUB") {     // 还可以使用 removeValue(forKey:) 方法从字典中删除键值对
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary doesn't contain a value for DUB.")
}
for (airportCode, airportName) in airports {                    // 遍历字典
    print("\(airportCode): \(airportName)")
}
for airportCode in airports.keys {                              // 单独遍历字典的键
    print("Airport code: \(airportCode)")
}
for airportName in airports.values {                            // 单独遍历字典的值
    print("Airport name: \(airportName)")
}
let airportCodes = [String](airports.keys)                      // 将字典的键初始化为一个新的数组
let airportNames = [String](airports.values)                    // 将字典的值初始化为一个新的数组
