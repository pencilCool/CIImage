//
//  ViewController.swift
//  CoreImageFun
//
//  Created by tangyuhua on 2017/4/23.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var originImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.originImageView.image = UIImage(named: "image");
        
        // Do any additional setup after loading the view, typically from a nib.
        let fileURL = Bundle.main.url(forResource: "image" , withExtension: "png")
        let beginImage = CIImage(contentsOf: fileURL!)
        
        let filter = CIFilter(name: "CISepiaTone") // 棕色色调
        filter?.setValue(beginImage, forKey: kCIInputImageKey)
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        
        // 自动创建CIContext ，每次都创建所以有弊端
        let newImage = UIImage(ciImage: (filter?.outputImage)!)
        self.imageView.image = newImage
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

