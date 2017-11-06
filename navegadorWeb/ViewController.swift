//
//  ViewController.swift
//  navegadorWeb
//
//  Created by Abrahzan on 20/10/17.
//  Copyright © 2017 Abrahzan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var bAtras: UIButton!
    @IBOutlet weak var bSiguiente: UIButton!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var tfNombre: UITextField!
    var ref:DatabaseReference?
    @IBOutlet weak var bAdd: UIButton!
    @IBOutlet weak var tabla: UITableView!
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        tfNombre.addTarget(self, action: #selector(tfAction(_:)), for: .editingChanged)
        bAdd.isEnabled=false
        bAtras.isEnabled=false
        bSiguiente.isEnabled=false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func agregar(_ sender: UIButton) {
        if tfNombre.text != "" {
            ref?.child("webs").childByAutoId().setValue(tfNombre.text)
            var s = "http://"
            s += tfNombre.text!
            webView.loadRequest(URLRequest(url: URL(string: s)!))
        }
    }
    
    @objc func tfAction(_ textField: UITextField) {
        if webView.canGoBack {
            bAtras.isEnabled=true
            
        }
        else {
            bAtras.isEnabled=false
        }
        
        if webView.canGoForward {
            bSiguiente.isEnabled=true
            
        }
        else {
            bSiguiente.isEnabled=false
        }
        
        if (tfNombre.text?.characters.count)! > 0 {
            bAdd.isEnabled=true
        }
        else {
            bAdd.isEnabled=false
        }
        
    }
    @IBAction func bSiguiente(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func bAtras(_ sender: Any) {
        webView.goBack()
    }
    
}


