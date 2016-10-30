//
//  NoteDetailViewController.swift
//  Notes
//
//  Created by Robert White on 10/18/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import UIKit
import UserNotifications

class NoteDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dueDateField: UITextField!
    @IBOutlet weak var dueTimeField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var priorityField: UITextField!
    @IBOutlet weak var prioritySelect: UISegmentedControl!
  
  
   
    
    var empty = ""
    var priority = ["High", "Medium", "Low"]
    
    @IBAction func notification(_ sender: AnyObject) {
        let content = UNMutableNotificationContent()
        content.title = "test"
        content.subtitle = "test2"
        content.body = "test3"
        content.badge = 1
        content.categoryIdentifier = "noteCategory"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: true)
        
        let requestIdentifier = "test4"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            
        })
    }
  
    var priSubmit = 0
    var category = ["Grocery", "School", "Chores", "Work", "Gaming"]
    var catSubmit = 0
    var gestureRecognizer: UITapGestureRecognizer!
    
    
    
    
    
    var task = Note()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   UNUserNotificationCenter.current().delegate = self
        
        //  noteTitleField.text = task.title
        noteTextField.text = task.text
        dueDateField.text = task.dueDate
        dueTimeField.text = task.dueTime
        categoryPicker.delegate = self
        categoryPicker.delegate = self
        switchLabel.text = task.complete
        priorityField.text = task.priority
        
        
        
        
        if let image = task.image {
            imageView.image = image
            addGestureRecognizer()
        }else{
            imageView.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchPressed(_ sender: AnyObject) {
        if mySwitch.isOn{
            switchLabel.text = "Completed"
        }else {
            switchLabel.text = "Incomplete"
        }
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func priorityChange(_ sender: UISegmentedControl) {
        switch prioritySelect.selectedSegmentIndex{
        case 0:
            priorityField.text = "High"
        case 1:
            priorityField.text = "Medium"
        case 2:
            priorityField.text = "Low"
        default:
            priorityField.text = "Priority"
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    @IBAction func categorySubmit(_ sender: AnyObject) {
        if (catSubmit == 0){
            noteTitleField.text = "Grocery"
        }
        else if(catSubmit == 1){
            noteTitleField.text = "School"
        }
        else if(catSubmit == 2){
            noteTitleField.text = "Chores"
        }
        else if(catSubmit == 3){
            noteTitleField.text = "Work"
        }
        else if(catSubmit == 4){
            noteTitleField.text = "Gaming"
            print("LOL")
        }else{
            category.insert("This String", at: 0)
        }
    }
 
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        catSubmit = row
    }
    
    
    func addGestureRecognizer(){
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func viewImage() {
        if let image = imageView.image {
            NoteStore.shared.selectedImage = image
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageNavController")
            present(viewController, animated: true, completion: nil)
        }
    }
    
    fileprivate func showPicker(_ type: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        task.title = noteTitleField.text!
        task.text = noteTextField.text
        task.dueDate = dueDateField.text!
        task.dueTime = dueTimeField.text!
        task.date = Date()
        task.due = datePicker.date
        task.image = imageView.image
        task.complete = switchLabel.text!
        task.priority = priorityField.text!
        
        
        
        
    }
    
    // MARK: IBActions
    
    @IBAction func choosePhoto(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Picture", message: "Choose a picture type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler:{
            (action) in
            self.showPicker(.camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:{
            (action) in
            self.showPicker(.photoLibrary)
        }))
        present(alert, animated: true, completion: nil)
    }
}


extension NoteDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            let maxSize: CGFloat = 512
            let scale = maxSize / image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: maxSize, height: newHeight))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            imageView.image = resizedImage
        }
        
    }
    
}
/*extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void){
        completionHandler([.alert, .sound])
    }
}*/
