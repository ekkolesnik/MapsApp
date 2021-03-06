//
//  LoginController.swift
//  MaspApp
//
//  Created by Evgeny Kolesnik on 02.10.2020.
//

import UIKit
import RealmSwift

class LoginController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    
//    var realm: Realm?
    var user: Results<User>?
    
    var login = ""
    var pass = ""
    
    var realmLogin = ""
    var realmPass = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Определяем текст и цвет у loginTextField
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Имя пользователя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        
        //Определяем текст и цвет у passTextField
        passTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        
        //закругление кнопок
        enterButton.clipsToBounds = true
        enterButton.layer.cornerRadius = loginTextField.bounds.width / 15
        
        registrationButton.clipsToBounds = true
        registrationButton.layer.cornerRadius = loginTextField.bounds.width / 15
        
    }
    
    func showAuthError() {
        //формируем сам алерт
        let alertVC = UIAlertController(title: "Ошибка", message: "Не верный пароль или логин", preferredStyle: .alert)
        //формируем кнопку к алерту
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        //добавдяем кнопку к алерту
        alertVC.addAction(action)
        
        //выводим на экран
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func enterActionButton(_ sender: Any) {
  
        guard let login = loginTextField.text, let pass = passTextField.text else {return}
        
        self.login = login
        self.pass = pass
        
        do {
            let realm = try Realm()
            let user = realm.objects(User.self).filter("login = '\(String(describing: self.login))' AND password = '\(String(describing: self.pass))'")

            self.user = user
        } catch {
            print(error)
        }

        realmLogin = ""
        realmPass = ""

        for i in self.user! {
            realmLogin = i.login
            realmPass = i.password
        }

        if login != realmLogin || pass != realmPass || login == ""  {
            showAuthError()
        } else {
            UserDefaults.standard.setValue(true, forKey: "isLogin")
            performSegue(withIdentifier: "enterSegua", sender: AnyObject.self)
        }
    }
    
    @IBAction func registrationActionButton(_ sender: UIButton) {
    }
}
