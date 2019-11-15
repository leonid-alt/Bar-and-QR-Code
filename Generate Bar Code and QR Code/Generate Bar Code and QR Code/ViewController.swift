//
//  ViewController.swift
//  Generate Bar Code and QR Code
//
//  Created by Leonid Stepanov on 10.06.18.
//  Copyright © 2018 Leonid Stepanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var imageDisplay: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func generateBarcode(sender: AnyObject) {
        
        imageDisplay.image = generateBarcodeFromString(tfInput.text!)
        
        // При клике на кнопке клавиатура исчезает
        view.endEditing(true)
    }
    
    @IBAction func generateQrcode(sender: AnyObject) {
        
        imageDisplay.image = generateQrcodeFromString(tfInput.text!)
        
        // При клике на кнопке клавиатура исчезает
        view.endEditing(true)
    }
    
        
    //--- Вызывается, когда пользователь кликает на view (за пределами textField)--
    // outlets textField и textField2, UITextFieldDelegate
    // и textField.delegate = ... не нужны
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    //--- Вызывается, когда нажимается клавиша Return -----
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        //view.endEditing(true)
        return true
        
    }
    
    
    
    func generateBarcodeFromString(string : String) -> UIImage?{
        let data = string.dataUsingEncoding(NSASCIIStringEncoding)
        let filter = CIFilter(name : "CICode128BarcodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransformMakeScale(10, 10)
        
        let output = filter?.outputImage?.imageByApplyingTransform(transform)
        if(output != nil){
            return UIImage(CIImage: output!)
        }
        return nil;
    }
    
    func generateQrcodeFromString(string : String) -> UIImage?{
        let data = string.dataUsingEncoding(NSASCIIStringEncoding)
        let filter = CIFilter(name : "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransformMakeScale(10, 10)
        
        let output = filter?.outputImage?.imageByApplyingTransform(transform)
        if(output != nil){
            return UIImage(CIImage: output!)
        }
        return nil;
    }
    
    
}

