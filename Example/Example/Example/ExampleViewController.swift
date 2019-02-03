//
//  ExampleViewController.swift
//  Example
//
//  Created by ShevaKuilin on 2019/2/3.
//  Copyright © 2019 ShevaKuilin. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {

    private var exampleLabel1: UILabel!
    private var exampleLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initConfig()
        initElements()
    }
}

private extension ExampleViewController {
    private func initConfig() {
        self.title = "EXAMPLE"
        self.view.backgroundColor = .white
    }
    
    private func initElements() {
        let originText1 = "示例1：替换文中出现的URL\n测试文本：末尾出现url：想看技术文章请访问https://juejin.im/collection/5c1e3cdde51d453f6715733b\n文首出现：https://juejin.im/collection/5c1e3cdde51d453f6715733b这是一个很不错的博客\n文中出现：想看类似https://juejin.im/collection/5c1e3cdde51d453f6715733b这种的技术博客吗，请联系我的邮箱shevakuilin@gmail.com，谢谢！"
        let regularText1 = SKRegularText(textColor: .black,
                                        textFont: kFont(16),
                                        textLineSpacing: 5,
                                        textAlignment: .left,
                                        replaceTextColor: kColor(0, 127, 255),
                                        replaceTextFont: kFont(16),
                                        replaceIconImage: UIImage(named: "link"),
                                        replaceIconSize: CGSize(width: 15, height: 15),
                                        iconImageLocation: .left)
        self.exampleLabel1 = UILabel()
        self.exampleLabel1.frame = CGRect(x: 14, y: 88, width: UIScreen.main.bounds.size.width - 28, height: 300)
        self.exampleLabel1.numberOfLines = 0
        self.exampleLabel1.attributedText = regularText1.convertLinkRichText(originalText: originText1, replaceText: "网页链接", completeBlock: { (arg0) in
            let (highlightAreaRanges, highlightContents) = arg0
            for i in 0..<highlightAreaRanges.count {
                printLog("高亮区域: \(highlightAreaRanges[i]), 高亮区域被替换的内容 = \(highlightContents[i])")
            }
        })
        self.exampleLabel1.sizeToFit()
        self.view.addSubview(self.exampleLabel1)
        
        let originText2 = "示例2：替换文中出现的中国移动手机号码\n你好，有事情请拨打：13522310153，如果这个号码打不通换成18862730094也行，打我联通也行:13146917777,要不然15223180299这个是我的，欢迎访问我的这个博客https://juejin.im/post/5c106d2af265da61171c9408，你要是还联系不到我，这个新申请的应该可以17890283502，以上号码和地址纯属虚构"
        let regularText2 = SKRegularText(customRegularExpression: "1(34[0-8]|(3[5-9]|5[0127-9]|8[23478]|7[8]|9[8])\\d)\\d{7}")
        self.exampleLabel2 = UILabel()
        self.exampleLabel2.frame = CGRect(x: 14, y: 300, width: UIScreen.main.bounds.size.width - 28, height: 200)
        self.exampleLabel2.numberOfLines = 0
        self.exampleLabel2.attributedText = regularText2.convertLinkRichText(originalText: originText2, replaceText: "中国移动📱", completeBlock: { (arg0) in
            let (highlightAreaRanges, highlightContents) = arg0
            for i in 0..<highlightAreaRanges.count {
                printLog("高亮区域: \(highlightAreaRanges[i]), 高亮区域被替换的内容 = \(highlightContents[i])")
            }
        })
        self.exampleLabel2.sizeToFit()
        self.view.addSubview(self.exampleLabel2)
    }
}
