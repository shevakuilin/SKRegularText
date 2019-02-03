//
//  SKFormatting.swift
//  TestRegularText
//
//  Created by ShevaKuilin on 2019/1/12.
//  Copyright © 2019 ShevaKuilin. All rights reserved.
//

import UIKit

/** Format UIFont size
 *
 *  @param  x        Size value
 *  @param  bold     Bold face
 *
 *  @return UIFont   An UIFont instance
 *
 */
public func kFont(_ x: CGFloat,
                  _ bold: Bool = false) -> UIFont {
    return bold ? UIFont.boldSystemFont(ofSize: x):UIFont.systemFont(ofSize: x)
}

/** Format UIFont [Custom font]
 *
 *  @param text Font name
 *  @param x    Font size
 *
 */
public func kFontName(_ text: String,
                      _ x: CGFloat) -> UIFont {
    guard let theFont = UIFont(name: text, size: x) else {
        return UIFont.systemFont(ofSize: x)
    }
    return theFont
}

/** Format UIColor RGB value
 *
 *  @param  r        Rea color RGB value molecule
 *  @param  g        Green color RGB value molecule
 *  @param  blue     Blue color RGB value molecule
 *  @param  a        Alpha value. Default 1.0
 *
 *  @return UIColor  An UIColor instance
 *
 */
public func kColor(_ r: CGFloat,
                   _ g: CGFloat,
                   _ b: CGFloat,
                   _ a: CGFloat = 1.0) -> UIColor {
    let denominatorRGB: CGFloat = 255.0
    return UIColor(red: r/denominatorRGB, green: g/denominatorRGB, blue: b/denominatorRGB, alpha: a)
}

/** Format NSAttributedString
 *
 *  @param  string              Original text
 *  @param  font                Font size
 *  @param  color               Text color
 *  @param  alignment           Text alignment
 *  @param  lineSpacing         Text line spacing
 *
 *  @return NSAttributedString  A NSAttributedString instance
 *
 */
public func kAttributedStyle(_ string: String?,
                             _ font: UIFont,
                             _ color: UIColor = .black,
                             _ alignment: NSTextAlignment = .left,
                             _ lineSpacing: CGFloat = 0) -> NSAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
    if lineSpacing > 0 {
        paragraphStyle.lineSpacing = lineSpacing
    }
    return NSAttributedString(string: string ?? "",
                              attributes: [
                                NSAttributedString.Key.font: font,
                                NSAttributedString.Key.foregroundColor: color,
                                NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
}

/** Format print
 *
 *  @param  message             The text message you want to output
 *  @param  file                The file name. Automatic reading
 *  @param  method              The method name. Automatic reading
 *  @param  line                This print message appears in the first few lines of this file. Automatic reading
 *
 */
public func printLog<T>(_ message: T,
                        file: String = #file,
                        method: String = #function,
                        line: Int = #line) {
    #if DEBUG
    print("File => [\((file as NSString).lastPathComponent) \(method):] - [Line \(line)], Message => 「 \(message) 」")
    #endif
}

