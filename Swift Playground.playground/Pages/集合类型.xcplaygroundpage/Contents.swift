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
// 使用默认值创建数组
var threeDoubles = Array(repeating: 0.0, count: 3)    // 大小为3 值全都为 0.0
// 通过合并两个数组创建一个新数组
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles 的类型是 [Double]，并且等于 [2.5, 2.5, 2.5]
var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles 被推断为 [Double] 类型，并且等于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
