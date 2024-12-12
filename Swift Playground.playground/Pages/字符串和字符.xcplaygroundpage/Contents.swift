
// 字符串字面量
let someString = "Some string literal value"

// 多行字符串字面量
let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

// 字符串字面量的特殊字符
// 转义字符 \0(空字符)、\\(反斜线)、\r(水平制表符)、\t(换行符)、\n(回车符)、\"(双引号)、\'(单引号)。
// 任意的 Unicode 标量，可以写成 \u{n}(u 为小写)，其中n为任意一到八位十六进制数且可用的 Unicode 位码。 (Unicode在文档Unicode 中进行解析讨论)
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496

// 初始化空字符串
var emptyString = ""               // 空字符串字面量
var anotherEmptyString = String()  // 初始化方法
// 两个字符串均为空并等价

// 字符串是值类型
/*
 在 Swift 中 String 类型是值类型。如果你创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。在前述任一情况下，都会对已有字符串值创建新副本，并对该新副本而非原始字符串进行传递或赋值操作。值类型在doc:ClassesAndStructures#Structures-and-Enumerations-Are-Value-Types中进行了详细描述。
 Swift 默认拷贝 String 的行为保证了在函数/方法向你传递的 String 所属权属于你，无论该值来自于哪里。你可以确信传递的 String 不会被修改，除非你自己去修改它。
 在实际编译时，Swift 编译器会优化字符串的使用，使实际的复制只发生在绝对必要的情况下，这意味着你将字符串作为值类型的同时可以获得极高的性能。
 */

// 使用字符
for character in "Dog!🐶" {    // 对字符串进行遍历操作
    print(character)
}
let exclamationMark: Character = "!"    // 单个字符

// 字符串可以通过传递一个值类型为 Character 的数组作为自变量来初始化：
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)                        // 打印 "Cat!🐱"

// 字符串插值
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message is "3 times 2.5 is 7.5"

// 计算字符数量
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters")
// 打印 "unusualMenagerie has 40 characters"

// 访问和修改字符串
// 字符串索引
let greeting = "Guten Tag!"
greeting[greeting.startIndex]                                    // G
greeting[greeting.index(before: greeting.endIndex)]              // !
greeting[greeting.index(after: greeting.startIndex)]             // u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]                                                  // a

for index in greeting.indices {                                  // 使用 indices 创建一个包含全部索引的范围 Range
    print("\(greeting[index]) ", terminator: "")
}
// 打印 "G u t e n   T a g ! "

// 插入和删除
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)                        // welcome 变量现在等于 "hello!"
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))    // welcome 变量现在等于 "hello there!"
welcome.remove(at: welcome.index(before: welcome.endIndex))      // welcome 现在等于 "hello there"
let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)                                    // welcome 现在等于 "hello"

// 子字符串
let fullString = "Hello, world!"
let substringIndex = fullString.firstIndex(of: ",") ?? fullString.endIndex
let substring = fullString[..<substringIndex]                    // substring 的值为 "Hello"
let newString = String(substring)                                // 把结果转化为 String 以便长期存储

// 比较字符串  Swift 提供了三种方式来比较文本值：字符串字符相等、前缀相等和后缀相等。
// 字符串和字符相等
let quotation2 = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation2 == sameQuotation {
    print("These two strings are considered equal")              // 打印 "These two strings are considered equal"
}
// 前缀和后缀相等
// 通过调用字符串的 hasPrefix(*:)或hasSuffix(*:) 方法来检查字符串是否拥有特定前缀或后缀，两个方法均接收一个 String 类型的参数，并返回一个布尔值
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")              // 打印 "There are 5 scenes in Act 1"

