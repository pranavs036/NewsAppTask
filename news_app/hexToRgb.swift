
import UIKit
extension UIColor{
  convenience init(hexString: String){
    let curr_str=String(hexString.suffix(6))
    let r=CGFloat(Float(Int(calcSubstr(str: curr_str, start: 0, end: 4),radix: 16)!)/255.0)
    let g=CGFloat(Float(Int(calcSubstr(str: curr_str, start: 2, end: 2),radix:16)!)/255.0)
    let b=CGFloat(Float(Int(calcSubstr(str: curr_str, start: 4, end: 0),radix:16)!)/255.0)

    self.init(red: r, green: g, blue: b, alpha: 1)
  }
}
func calcSubstr(str:String,start:Int,end:Int)->String{
  let start = str.index(str.startIndex, offsetBy: start)
  let end = str.index(str.endIndex, offsetBy: -end)
  let range = start..<end
  let mySubstring = str[range]

  return String(mySubstring)
}



