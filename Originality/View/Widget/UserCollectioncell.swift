//
//  UserCollectioncell.swift
//  Originality
//
//  Created by suze on 16/2/1.
//  Copyright © 2016年 suze. All rights reserved.
//

import UIKit

class UserCollectioncell: UICollectionViewCell {
           //设置数据项，不在界面中显示，但是在跳转到下一级界面中作为数据源
        var singlePictureId:String!
        var userId:String!
        var tagId:Int!
        
        
        var topContentView:UIView = UIView()
        
        var imageView:UIImageView = UIImageView()
        var textlabel:UIView = UIView()
        var titleLabel:UILabel = UILabel()
        var detailLabel:UILabel = UILabel()
        //detailLabel上放置收藏，点赞，评论的数量
        var voteView:UIImageView = UIImageView()
        var voteLabel:UILabel = UILabel()
        
            var collectionView:UIImageView = UIImageView()
            var collectionLabel:UILabel = UILabel()
    
        var commentView:UIImageView = UIImageView()
        var commentLable:UILabel = UILabel()
        
    
    
    
    
        
        var filename:String? {
            
            willSet{
                
            }
            didSet{
                let home = NSHomeDirectory() as NSString
                let path = home.stringByAppendingPathComponent("Library/Caches/DownloadFile") as NSString
                let imagePath = path.stringByAppendingPathComponent(filename!)
                let isExits:Bool = NSFileManager.defaultManager().fileExistsAtPath(imagePath)
                let image = UIImage(contentsOfFile: imagePath)
                if isExits && image != nil{
                    print("111111")
                    self.imageView.image = image
                }
                else {
                    print("222222")
                    
                    var url:NSURL!
                    BmobProFile.getFileAcessUrlWithFileName(filename) { (file, error) -> Void in
                        if error != nil {
                            print("error:\(error)")
                        }else{
                            url = NSURL(string: file.url)
                            print("url::::\(url)")

                            let request = NSURLRequest(URL: url)
                            let session = NSURLSession.sharedSession()
                            
                            let dataTask = session.dataTaskWithRequest(request,
                                completionHandler: {(data, response, error) -> Void in
                                    //将获取到的数据转化成图像
                                    if data != nil {
                                        let image = UIImage(data: data!)
                                        //对UI的更新必须在主队列上完成
                                        NSOperationQueue.mainQueue().addOperationWithBlock({
                                            () -> Void in
                                            //将已加载的图像赋予图像视图
                                            self.imageView.image = image
                                            //图像视图可能已经因为新图像而改变了尺寸
                                            //所以需要重新调整单元格的布局
                                            self.setNeedsLayout()
                                        })
                                    }
                                    else{
                                        self.imageView.image = UIImage(named:"bg6")
                                    }
                                    
                            }) as NSURLSessionTask
                            
                            //使用resume方法启动任务
                            dataTask.resume()
                        }
                        
                        
                    }
                }
            }
        }
        
        
        override func drawRect(rect: CGRect) {
            
            topContentView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height  )
            
            imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: topContentView.frame.height * 4 / 5 )
            
            
            
            
            textlabel.frame = CGRect(x: 10, y: topContentView.frame.height * 4 / 5 , width: self.frame.width - 20, height: topContentView.frame.height * 1 / 5 )
            
            
            titleLabel.frame = CGRect(x: 0, y: 0, width: textlabel.frame.width , height: textlabel.frame.height * 2 / 3)
            //titleLabel.backgroundColor = UIColor.redColor()
            titleLabel.textAlignment = NSTextAlignment.Left
            titleLabel.font = nomalFont
            titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            titleLabel.numberOfLines = 0
            titleLabel.textColor = titleCorlor
            
            
            
            detailLabel.frame = CGRect(x: 0, y: textlabel.frame.height * 2 / 3 + 2, width: textlabel.frame.width , height: textlabel.frame.height * 1 / 3 - 5)
            commentView.frame = CGRect(x: 0, y: 0, width: detailLabel.frame.height, height: detailLabel.frame.height)
            let width = (detailLabel.frame.width - 5) / 3 - 10 - commentView.frame.width
            
            commentLable.frame = CGRect(x: detailLabel.frame.height + 5, y: 0, width: width , height: detailLabel.frame.height)
            commentView.image = UIImage(named: "cm2_operbar_icn_rename")
            
            commentLable.textAlignment = NSTextAlignment.Left
            commentLable.font = smallFont
            commentLable.textColor = detailCountColor
            
            voteView.frame = CGRect(x:commentLable.frame.width + commentLable.frame.origin.x + 5, y: 0, width: detailLabel.frame.height, height: detailLabel.frame.height)
            voteLabel.frame = CGRect(x: voteView.frame.width + voteView.frame.origin.x + 5, y: 0, width: commentLable.frame.width , height: detailLabel.frame.height)
            voteView.image = UIImage(named: "vote")
            
            voteLabel.textAlignment = NSTextAlignment.Left
            voteLabel.font = smallFont
            voteLabel.textColor = detailCountColor
            
            collectionView.frame = CGRect(x: voteLabel.frame.width + voteLabel.frame.origin.x + 5, y: 0, width: detailLabel.frame.height, height: detailLabel.frame.height)
            collectionLabel.frame = CGRect(x: collectionView.frame.width + collectionView.frame.origin.x + 5, y: 0, width: commentLable.frame.width , height: detailLabel.frame.height)
            collectionView.image = UIImage(named: "cl")
            
            collectionLabel.textAlignment = NSTextAlignment.Left
            collectionLabel.font = smallFont
            collectionLabel.textColor = detailCountColor
            
            self.detailLabel.addSubview(commentView)
            self.detailLabel.addSubview(commentLable)
            self.detailLabel.addSubview(voteView)
            self.detailLabel.addSubview(voteLabel)
                    self.detailLabel.addSubview(collectionView)
                    self.detailLabel.addSubview(collectionLabel)
            
            
            
            self.contentView.backgroundColor = contentColor
            
            self.contentView.addSubview(topContentView)
            self.topContentView.addSubview(imageView)
            self.topContentView.addSubview(textlabel)
            
            
            self.textlabel.addSubview(titleLabel)
            self.textlabel.addSubview(detailLabel)
            
            
            
            
        }
        
}
