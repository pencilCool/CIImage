//
//  ViewController.swift
//  CoreImageFun
//
//  Created by tangyuhua on 2017/4/23.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import UIKit
import AssetsLibrary


class ViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet weak var originImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var amountSlider: UISlider!
    
    
    var context: CIContext!
    var filter: CIFilter!
    var beginImage: CIImage!
    
    var orientation: UIImageOrientation = .down
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.originImageView.image = UIImage(named: "image");
        
        // Do any additional setup after loading the view, typically from a nib.
        let fileURL = Bundle.main.url(forResource: "image" , withExtension: "png")
        beginImage = CIImage(contentsOf: fileURL!)
        
        filter = CIFilter(name: "CISepiaTone") // 棕色色调
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        filter.setValue(0.5, forKey: kCIInputIntensityKey)
        
        // 自动创建CIContext ，每次都创建所以有弊端
        //let newImage = UIImage(ciImage: (filter?.outputImage)!)
 
         context = CIContext(options:nil)
        
        // 2
        let cgimg = context.createCGImage(filter!.outputImage!, from: filter!.outputImage!.extent)
        
        // 3
        let newImage = UIImage(cgImage: cgimg!)
        self.imageView.image = newImage
 
        
        
    }

   
    @IBAction func amountSliderValueChanged(_ sender: UISlider)
    {
        let sliderValue = sender.value
        
        filter.setValue(sliderValue, forKey: kCIInputIntensityKey)
        let outputImage = filter.outputImage
        
        let cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
        
        let newImage = UIImage(cgImage: cgimg!, scale: 1, orientation: orientation);
        self.imageView.image = newImage
        
    }
    
 

    @IBAction func loadPhoto(_ sender: Any) {
        
        let pickerC = UIImagePickerController()
        pickerC.delegate = self
        self.present(pickerC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func savePhoto(_ sender: Any) {
        // 1
        let imageToSave = filter.outputImage
        
        // 2
        let softwareContext = CIContext(options:[kCIContextUseSoftwareRenderer: true])
        
        // 3
        let cgimg = softwareContext.createCGImage(imageToSave!, from:imageToSave!.extent)
        
        // 4
        let library = ALAssetsLibrary()
        library.writeImage(toSavedPhotosAlbum: cgimg,metadata:imageToSave!.properties,
                                             completionBlock:nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil);
        print(info);
        
        
        let gotImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        orientation = gotImage.imageOrientation
        beginImage = CIImage(image:gotImage)
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        self.amountSliderValueChanged(amountSlider)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




