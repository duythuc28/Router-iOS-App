//
//  SharingHelper.swift
//  Experfi
//
//  Created by iOSDev on 8/24/16.
//  Copyright © 2016 Allan. All rights reserved.
//

import UIKit
import Social
import MessageUI
import SafariServices
import MobileCoreServices

protocol SharingHelperDelegate : class {
    func didSharedLinkedInComplete (success: Bool)
}

class SharingHelper: NSObject {
    
    enum ShareSocialTypes {
        case Facebook
        case Twitter
        case Email
        case SMS
        case WhatsApp
        case More
    }
    weak var delegate : SharingHelperDelegate?
    static let sharedInstance = SharingHelper()
    
    let whatsAppURL : String = "whatsapp://send?text="
    let linkedInShareURL : String = "https://api.linkedin.com/v1/people/~/shares"
    
    var interactionController: UIDocumentInteractionController?
    
    private override init() {
//        super.init()
    }
    
    func shareWhatsAppText(shareText: String , shareImage : UIImage?, inView:UIView) {
        let urlRString = whatsAppURL + shareText
        if let urlStringEncoded = urlRString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            if let whatsappURL = NSURL(string: urlStringEncoded) {
                if UIApplication.sharedApplication().canOpenURL(whatsappURL) {
//                    if let imageData = UIImageJPEGRepresentation(shareImage!, 1.0) {
//                        let tempFile = NSURL(fileURLWithPath: NSHomeDirectory()).URLByAppendingPathComponent("Documents/shareImage.wai")
//                        do {
//                            try imageData.writeToURL(tempFile, options: .DataWritingAtomic)
//                            interactionController = UIDocumentInteractionController(URL: tempFile)
//                            interactionController!.UTI = "public.image"
//                            interactionController!.presentOpenInMenuFromRect(CGRectZero, inView: inView, animated: true)
//                        } catch {
//                            print(error)
//                        }
//                    }
                    UIApplication.sharedApplication().openURL(whatsappURL)
                    
                    
                } else {
                    // Cannot open whatsapp
                    print("Not installl app")
                }
            }
        }
    }
    
    func shareContent(types: ShareSocialTypes, sharingContent : String, sharingImage: UIImage?, sharingLink:NSURL?, presentingViewController : UIViewController) {
        switch types {
        case .Facebook:
            let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookComposeVC.setInitialText(sharingContent)
            if sharingImage != nil {
                facebookComposeVC.addImage(sharingImage!)
            }
            if sharingLink != nil {
                facebookComposeVC.addURL(sharingLink)
            }
            presentingViewController.presentViewController(facebookComposeVC, animated: true, completion: nil)
            break
        case .Twitter:
            let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterComposeVC.setInitialText(sharingContent)
            if sharingImage != nil {
                twitterComposeVC.addImage(sharingImage!)
            }
            if sharingLink != nil {
                twitterComposeVC.addURL(sharingLink)
            }
            presentingViewController.presentViewController(twitterComposeVC, animated: true, completion: nil)
            break
        case .Email:
            let mailComposeViewController = configuredMailComposeViewController("", messageBody: sharingContent,contentImage:sharingImage!)
            if MFMailComposeViewController.canSendMail() {
                presentingViewController.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            break
        case .SMS:
            let smsComposeViewController = configureSMSComposeViewController(sharingContent,contentImage: sharingImage!)
            if MFMessageComposeViewController.canSendText() {
                presentingViewController.presentViewController(smsComposeViewController, animated: true, completion: nil)
            } else {
                showSendSMSErrorAlert()
            }
            break
        case .WhatsApp:
            shareWhatsAppText(sharingContent, shareImage: sharingImage!, inView: presentingViewController.view)
            break
        case .More:
            let activityViewController = UIActivityViewController(activityItems: [sharingContent,sharingImage!], applicationActivities: nil)
                presentingViewController.presentViewController(activityViewController, animated: true, completion: nil)
            break
        }
    }
}

// MARK: Mail controller
extension SharingHelper : MFMailComposeViewControllerDelegate {
    
    func configuredMailComposeViewController(subject: String , messageBody: String, contentImage: UIImage) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
//        mailComposerVC.setToRecipients(["nurdin@gmail.com"])
        mailComposerVC.setSubject(subject)
        mailComposerVC.addAttachmentData(UIImageJPEGRepresentation(contentImage, CGFloat(1.0))!, mimeType: "image/jpeg", fileName:  "game.jpeg")
        mailComposerVC.navigationBar.tintColor = UIColor.whiteColor()
        mailComposerVC.setMessageBody(messageBody, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
}

// MARK: SMS Controller 
extension SharingHelper : MFMessageComposeViewControllerDelegate {
    func configureSMSComposeViewController (contentMessage: String, contentImage: UIImage) -> MFMessageComposeViewController {
        let messageController = MFMessageComposeViewController()
        messageController.body = contentMessage
        messageController.addAttachmentData(UIImageJPEGRepresentation(contentImage, CGFloat(1.0))!, typeIdentifier: kUTTypeJPEG as String, filename:  "game.jpeg")
        messageController.navigationBar.tintColor = UIColor.whiteColor()
//        controller.recipients = [phoneNumber.text]
        messageController.messageComposeDelegate = self
        return messageController
    }
    
    func showSendSMSErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send SMS", message: "Your device could not send SMS", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMessageComposeViewControllerDelegate
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension SharingHelper : SFSafariViewControllerDelegate {
    @available(iOS 9.0, *)
    func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        if didLoadSuccessfully {
            print("Success")
        }
    }
}