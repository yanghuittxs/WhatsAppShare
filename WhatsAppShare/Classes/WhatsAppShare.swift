


import UIKit

public class WhatsAppShare: NSObject {
    public static let shared = WhatsAppShare()
    private var documentInteractionController : UIDocumentInteractionController?
    
    /// 分享文本
    ///
    /// WhatsApp分享文本, 文本和链接拼接. 链接直接拼接在文本后面,WhatsApp会自动识别链接分享,并获取链接中的图片,title,description等,形成图文分享
    ///
    /// - Parameter txt: 文本/链接
    public func shareText(_ txt : String) {
        let whatsShareUrl = String.init(format: "whatsapp://send?text=%@", txt).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let url = URL.init(string: whatsShareUrl), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    /// 分享图片
    /// - Parameters:
    ///   - img: 图片
    ///   - showVC: 展示分享的视图
    public func showImg(_ img : UIImage, showVC : UIViewController) {
        if let url = URL.init(string: "whatsapp://app"), UIApplication.shared.canOpenURL(url) {
            let savePath = NSString.init(string: NSTemporaryDirectory()).appendingPathComponent("whatsAppTmp.wai")
            do {
                try img.jpegData(compressionQuality: 1.0)!.write(to: URL.init(fileURLWithPath: savePath))
                documentInteractionController = UIDocumentInteractionController.init(url: URL.init(fileURLWithPath: savePath))
                documentInteractionController?.uti = "net.whatsapp.image"
                documentInteractionController?.delegate = self
                documentInteractionController?.presentOpenInMenu(from: .zero, in: showVC.view, animated: true)
            } catch {
                debugPrint("保存分享图片错误:%@", error.localizedDescription)
            }
            
        }
    }
    
    /// 分享视频
    /// - Parameters:
    ///   - data: 视频数据
    ///   - showVC: 展示分享的视图
    public func showVideo(_ data : Data, showVC : UIViewController) {
        if let url = URL.init(string: "whatsapp://app"), UIApplication.shared.canOpenURL(url) {
            let savePath = NSString.init(string: NSTemporaryDirectory()).appendingPathComponent("whatsAppTmp.mp4")
            do {
                try data.write(to: URL.init(fileURLWithPath: savePath))
                documentInteractionController = UIDocumentInteractionController.init(url: URL.init(fileURLWithPath: savePath))
                documentInteractionController?.uti = "net.whatsapp.movie"
                documentInteractionController?.delegate = self
                documentInteractionController?.presentOpenInMenu(from: .zero, in: showVC.view, animated: true)
            } catch {
                debugPrint("保存分享视频错误:%@", error.localizedDescription)
            }
            
        }
    }
}

extension WhatsAppShare : UIDocumentInteractionControllerDelegate {
    
}
