//
//  SKRegularText.swift
//  TestRegularText
//
//  Created by ShevaKuilin on 2019/1/12.
//  Copyright © 2019 ShevaKuilin. All rights reserved.
//

import UIKit

public enum SKImageIconLocation {
    case left   // The icon will be inserted in the first place of the replaced text.
    case right  // The icon will be inserted in the last place of the replaced text.
}

public class SKRegularText: NSObject {
    private var textContent: NSAttributedString?
    private var originalTextContent: NSAttributedString?
    
    private var textColor: UIColor!
    private var textFont: UIFont!
    private var textLineSpacing: CGFloat!
    private var textAlignment: NSTextAlignment!
    
    private var replaceTextColor: UIColor!
    private var replaceTextFont: UIFont!
    private var replaceIconImage: UIImage?
    private var replaceIconSize: CGSize!
    private var iconImageLocation: SKImageIconLocation!
    
    private var customRegularExpression: String?
    
    private var replaceAreaRanges = [NSValue]()
    private var replaceContents = [String]()
    
    
    /** Initialization RegularText [Insert icon]
     *
     *  @param  textColor                   Plain text color. Default black color
     *  @param  textFont                    Plain text font. Default 16
     *  @param  textLineSpacing             Text line spacing. Default 5
     *  @param  textAlignment               Text alignment. Default left
     *  @param  replaceTextColor            The text color of the replaced part. Default RGB 0/127/255 color
     *  @param  replaceTextFont             The text font of the replaced part. Default 16
     *  @param  replaceIconImage            The icon of the replaced part.
     *  @param  replaceIconSize             The size of the icon being replaced. Default 0
     *  @param  iconImageLocation           The location of the icon in the replaced text. Default left
     *
     */
    init(textColor: UIColor = .black, textFont: UIFont = kFont(16), textLineSpacing: CGFloat = 5, textAlignment: NSTextAlignment = .left, replaceTextColor: UIColor = kColor(0, 127, 255), replaceTextFont: UIFont = kFont(16), replaceIconImage: UIImage?, replaceIconSize: CGSize = CGSize(width: 15, height: 15), iconImageLocation: SKImageIconLocation = .left) {
        self.textColor = textColor
        self.textFont = textFont
        self.textLineSpacing = textLineSpacing
        self.textAlignment = textAlignment
        self.replaceTextColor = replaceTextColor
        self.replaceTextFont = replaceTextFont
        self.replaceIconImage = replaceIconImage
        self.replaceIconSize = replaceIconSize
        self.iconImageLocation = iconImageLocation
    }
    
    /** Initialization RegularText [No icon]
     *
     *  @param  textColor                   Plain text color. Default black color
     *  @param  textFont                    Plain text font. Default 16
     *  @param  textLineSpacing             Text line spacing. Default 5
     *  @param  textAlignment               Text alignment. Default left
     *  @param  replaceTextColor            The text color of the replaced part. Default RGB 0/127/255 color
     *  @param  replaceTextFont             The text font of the replaced part. Default 16
     *
     */
    init(textColor: UIColor = .black, textFont: UIFont = kFont(16), textLineSpacing: CGFloat = 5, textAlignment: NSTextAlignment = .left, replaceTextColor: UIColor = kColor(0, 127, 255), replaceTextFont: UIFont = kFont(16)) {
        self.textColor = textColor
        self.textFont = textFont
        self.textLineSpacing = textLineSpacing
        self.textAlignment = textAlignment
        self.replaceTextColor = replaceTextColor
        self.replaceTextFont = replaceTextFont
    }
    
    /** Initialization RegularText [Custom regular expression & Insert icon]
     *
     *  @param  textColor                   Plain text color. Default black color
     *  @param  textFont                    Plain text font. Default 16
     *  @param  textLineSpacing             Text line spacing. Default 5
     *  @param  textAlignment               Text alignment. Default left
     *  @param  replaceTextColor            The text color of the replaced part. Default RGB 0/127/255 color
     *  @param  replaceTextFont             The text font of the replaced part. Default 16
     *  @param  replaceIconImage            The icon of the replaced part.
     *  @param  replaceIconSize             The size of the icon being replaced. Default 0
     *  @param  iconImageLocation           The location of the icon in the replaced text. Default left
     *  @param  customRegularExpression     Custom regular expression
     *
     */
    init(textColor: UIColor = .black, textFont: UIFont = kFont(16), textLineSpacing: CGFloat = 5, textAlignment: NSTextAlignment = .left, replaceTextColor: UIColor = kColor(0, 127, 255), replaceTextFont: UIFont = kFont(16), replaceIconImage: UIImage?, replaceIconSize: CGSize = CGSize(width: 15, height: 15), iconImageLocation: SKImageIconLocation = .left, customRegularExpression: String) {
        self.textColor = textColor
        self.textFont = textFont
        self.textLineSpacing = textLineSpacing
        self.textAlignment = textAlignment
        self.replaceTextColor = replaceTextColor
        self.replaceTextFont = replaceTextFont
        self.replaceIconImage = replaceIconImage
        self.replaceIconSize = replaceIconSize
        self.iconImageLocation = iconImageLocation
        self.customRegularExpression = customRegularExpression
    }
    
    /** Initialization RegularText [Custom regular expression & No icon]
     *
     *  @param  textColor                   Plain text color. Default black color
     *  @param  textFont                    Plain text font. Default 16
     *  @param  textLineSpacing             Text line spacing. Default 5
     *  @param  textAlignment               Text alignment. Default left
     *  @param  replaceTextColor            The text color of the replaced part. Default RGB 0/127/255 color
     *  @param  replaceTextFont             The text font of the replaced part. Default 16
     *  @param  customRegularExpression     Custom regular expression
     *
     */
    init(textColor: UIColor = .black, textFont: UIFont = kFont(16), textLineSpacing: CGFloat = 5, textAlignment: NSTextAlignment = .left, replaceTextColor: UIColor = kColor(0, 127, 255), replaceTextFont: UIFont = kFont(16), customRegularExpression: String) {
        self.textColor = textColor
        self.textFont = textFont
        self.textLineSpacing = textLineSpacing
        self.textAlignment = textAlignment
        self.replaceTextColor = replaceTextColor
        self.replaceTextFont = replaceTextFont
        self.customRegularExpression = customRegularExpression
    }
    
    /** Replaces the content of the text that matches the condition of the regular expression with the specified character, returns a replacement NSAttributedString instance, and calls back a tuple containing the location information of the replaced content and the original text.
     *
     *  @param  originalText    Original text.
     *  @param  replaceText     Replace the text content of the URL link.
     *  @param  completeBlock   Calls back a tuple containing the location information of the replaced content and the original text.
     *
     */
    public func convertLinkRichText(originalText: String?, replaceText: String, completeBlock: (((highlightAreaRanges: [NSValue], highlightContents: [String])) -> ())?) -> NSAttributedString? {
        guard let content = originalText else {
            return nil
        }
        textContent = kAttributedStyle(content, textFont, textColor, textAlignment, textLineSpacing)
        originalTextContent = textContent // Save original content
        defer {
            if let block = completeBlock { block((replaceAreaRanges.reversed(), replaceContents.reversed())) }
        }
        regularMatched { [weak self] (matchedRanges) in
            guard let strongSelf = self else {
                return
            }

            for value in matchedRanges {
                let matchedRange: NSRange = (value as AnyObject).rangeValue
                // Match the starting position of the text to be replaced, and the length of the text
                strongSelf.textContent = strongSelf.replaceTextContetx(raplaceStr: replaceText, range: matchedRange)
            }
            strongSelf.replaceAreaRanges = matchedRanges
        }
        
        return textContent
    }
    
    deinit {
        printLog(NSStringFromClass(self.classForCoder) + " has been destroyed !")
    }
}

private extension SKRegularText {
    private struct SKRegularExpression {
        // Automatically ignore email addresses
        static let noEmailLink = "htt(p|ps)://[a-zA-Z0-9+&@#/%?=~_\\-|!:,\\.;]*[\\-a\\-zA\\-Z0\\-9+&@#/%;=?~._|]*"
    }
    
    private func configRegularExpression() -> String {
        guard let custom = customRegularExpression else {
            return SKRegularExpression.noEmailLink
        }
        return custom
    }
    
    // Regular match
    private func regularMatched(_ matchedRanges: ([NSValue]) -> ()) {
        var rangesM = [NSValue]()
        let regularStr = configRegularExpression()
        
        do {
            let regex = try NSRegularExpression(pattern: regularStr, options: NSRegularExpression.Options(rawValue: 0))
            guard let attributedText = textContent else {
                return
            }
            regex.enumerateMatches(in: attributedText.string, options: .withoutAnchoringBounds, range: NSMakeRange(0, attributedText.length)) { (result, flags, stop) in
                guard let checkingResult = result else {
                    return
                }
                rangesM.append(NSValue(range: checkingResult.range))
            }
            let reverseM = rangesM.reversed().map { $0 }
            rangesM = reverseM
            
            matchedRanges(rangesM)
        } catch  {
            #if DEBUG
            assertionFailure("expression unexpectedly raised an error: " + regularStr)
            #endif
        }
    }
    
    // Replace the specified text content
    private func replaceTextContetx(raplaceStr: String, range: NSRange) -> NSMutableAttributedString? {
        guard let attributedText = textContent else {
            return nil
        }
        
        let replacedText = interceptReplacedText(range)
        replaceContents.append(replacedText)
        printLog("The text content to be replaced is: \(replacedText)")
        
        let raplaceText = kAttributedStyle(raplaceStr, replaceTextFont, replaceTextColor, textAlignment, textLineSpacing)
        var highlightLength = raplaceText.length
        
        let contentText = NSMutableAttributedString(attributedString: attributedText)
        contentText.replaceCharacters(in: range, with: raplaceText)
        
        if let iconImage = replaceIconImage {
            let fontHeight = replaceTextFont.ascender - replaceTextFont.descender
            let yOffset = fontHeight * 0.5 - replaceIconSize.height * 0.5
            
            // The yOffset: positive value up, negative value down
            let attachment = NSTextAttachment()
            attachment.bounds = CGRect(x: 0, y: -yOffset, width: replaceIconSize.width, height: replaceIconSize.height)
            attachment.image = iconImage
            
            let insertLocation = iconImageLocation == .left ? range.location : range.location + highlightLength
            let icon = NSAttributedString(attachment: attachment)
            contentText.insert(icon, at: insertLocation)
            highlightLength = highlightLength + 1
        }
        
        //        contentText.yy_setTextHighlight(NSRange(location: range.location, length: highlightLength),
        //                                        color: replaceTextColor,
        //                                        backgroundColor: .white) { (view, string, range, rect) in
        //                                            tapAction(urlStr)
        //        }
        
        return contentText
    }
    
    // Intercept the replaced text
    private func interceptReplacedText(_ range: NSRange) -> String {
        guard let originalString = originalTextContent else {
            return ""
        }
        
        let result = originalString.attributedSubstring(from: range)
        return result.string
    }
}
