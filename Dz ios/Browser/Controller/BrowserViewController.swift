//
//  BrowserViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 14.Jun.22.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {
    
    @IBOutlet weak private var textField: UITextField!
    
    @IBOutlet weak private var webView: WKWebView!
    
    private var urlTextField: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest(url: "www.google.com/")
        textField.delegate = self
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
        textField.endEditing(true)
    }
    
    @IBAction func forwardButton(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
        textField.endEditing(true)
    }
    
    @IBAction func reloadButton(_ sender: UIButton) {
        webView.reload()
        textField.endEditing(true)
    }
    
    @IBAction func editTextDidChanged(_ sender: UITextField) {
        urlTextField = sender.text
    }
    
    private func loadRequest(url: String) {
        guard let url = URL(string: "https://"+url) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}

extension BrowserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if let text = textField.text {
            loadRequest(url: text)
        }
        return true
    }
}
