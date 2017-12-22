import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate{
    var text1: UITextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
    var text2: UITextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
    let sc = UIScrollView();
    
    var txtActiveField = UITextField()
    var csvData=[[String]]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sc.frame = self.view.frame;
        sc.backgroundColor = UIColor.cyan;
        sc.delegate = self;
        
        //textfileの位置を指定する
        sc.contentSize = CGSize(width: 250,height: 1000)
        self.view.addSubview(sc);
        
        // 表示する文字を代入する.
        text1.text = ""
        text2.text = ""
        
        // Delegateを設定する.
        text1.delegate = self
        text2.delegate = self
        
        //CSVデータの作成
        csvData.append(["text1","text2"])
        
        
        // 枠を表示する.
        text1.borderStyle = UITextBorderStyle.roundedRect
        text2.borderStyle = UITextBorderStyle.roundedRect
        
        // UITextFieldの表示する位置を設定する.
        text1.layer.position = CGPoint(x:self.view.bounds.width/2,y:100);
        text2.layer.position = CGPoint(x:self.view.bounds.width/2,y:200);
        
        self.view.addSubview(text1)
        self.view.addSubview(text2)
        
        
        //button1の設定
        let button1: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        
        button1.setTitle("送信する", for: .normal)    //UIButtonに表示されるテキスト
        
        button1.setTitle("送信する", for: .highlighted) //タップした状態のテキスト
        
        button1.setTitleColor(UIColor.gray, for: .highlighted)   //タップした状態の色
        
        button1.setTitleColor(UIColor.black, for: .normal) //テキストの色
        
        button1.backgroundColor = UIColor.white  //背景色
        
        button1.layer.position = CGPoint(x:self.view.bounds.width/2,y:400); //UIButtonの表示する位置を設定する.
        
        button1.addTarget(self, action: #selector(button1WasTapped), for: .touchUpInside)
        
        
        self.view.addSubview(button1)
        
        // Viewに追加する
        sc.addSubview(text1)
        sc.addSubview(text2)
        
    }
    
    @objc private func button1WasTapped(){
        print("Event button1WasTapped")
        let csvText = "\(String(describing: text1.text)),\(String(describing: text2.text))"
        let activityVC =
            UIActivityViewController(activityItems: [csvText], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    //改行ボタンが押された際に呼ばれる.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //UITextFieldが編集された直後に呼ばれる.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        txtActiveField = textField
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func handleKeyboardWillShowNotification(_ notification: Notification) {
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        var txtLimit = txtActiveField.frame.origin.y + txtActiveField.frame.height + 8.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        print("テキストフィールドの下辺：(\(txtLimit))")
        print("キーボードの上辺：(\(kbdLimit))")
        
        if txtLimit >= kbdLimit {
            sc.contentOffset.y = txtLimit - kbdLimit
        }
    }
    
    @objc func handleKeyboardWillHideNotification(_ notification: Notification) {
        sc.contentOffset.y = 0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
