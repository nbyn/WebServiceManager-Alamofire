//
//  WebServiceManager.swift
//  WebServiceManager
//
//  Created by Malik Wahaj Ahmed on 10/04/2017.
//  Copyright © 2017 Malik Wahaj Ahmed. All rights reserved.
//

import Foundation

import Alamofire

class WebServiceManager {

    static let kBaseURL = "https://jsonplaceholder.typicode.com/"

    static let sharedInstance: WebServiceManager = WebServiceManager()
    
    func getRequest(urlString: String,
                    paramDict:[String : AnyObject]? = nil,
                    completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        
        Alamofire.request(urlString, method: .get, parameters: paramDict)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    completionHandler(JSON as? NSDictionary, nil)
                case .failure(let error):
                    completionHandler(nil, error as NSError?)
                }
        }
    }
    
    func postRequest(urlString: String,
                     paramDict: [String : AnyObject]? = nil,
                     completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        
        Alamofire.request(urlString, method:.post , parameters: paramDict)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    completionHandler(JSON as? NSDictionary, nil)
                case .failure(let error):
                    completionHandler(nil, error as NSError?)
                }
        }
    }
    
    
    func postRequestWithImage(urlString: String,
                              paramDict:[String : AnyObject]? = nil,
                              imageParams:[[String : AnyObject]]? = nil,
                              completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                for imageInfo in imageParams! {
                    
                    let image = imageInfo["image"] as? UIImage
                    let imageKey = imageInfo["image_key"] as? String
                    let imageType = ImageType(rawValue: (imageInfo["image_type"] as? String)!)
                    let imageCompression = imageInfo["image_compression"] as? CGFloat
                    
                    if let imageData = imageType == ImageType.png ? UIImagePNGRepresentation(image!) : UIImageJPEGRepresentation(image!, imageCompression!) {
                        
                        multipartFormData.append(imageData, withName:imageKey!, fileName: imageKey!+"."+(imageType?.name)!, mimeType: "image/"+(imageType?.name)!)
                    }
                }
                
                for (key, value) in paramDict! {
                    let valueStr = value as! String
                    multipartFormData.append(valueStr.data(using: .utf8)!, withName: key)
                }
        },
        to: urlString,
        encodingCompletion:
        { encodingResult in
            switch encodingResult
            {
            case .success(let upload, _, _):
                upload.responseJSON
                    { response in
                        switch response.result
                        {
                        case .success(let JSON):
                            completionHandler(JSON as? NSDictionary, nil)
                        case .failure(let error):
                            completionHandler(nil, error as NSError?)
                        }
                }
            case .failure(let encodingError):
                completionHandler(nil, encodingError as NSError)
            }
        })
    }
    
    func downloadImageFromURL(imageURL: NSURL,
                              completionHandler: @escaping (Bool?, UIImage?) -> ()) {
        
        Alamofire.download(imageURL.absoluteString!)
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.result.value {
                    let image = UIImage(data: data)
                    completionHandler(true,image)
                }
                else {
                    completionHandler(false,nil)
                }
        }
    }
}
