//
//  PushViewController.swift
//  cl2329_p3
//
//  Created by Cindy Liang on 3/13/23.
//
import UIKit
import FirebaseStorage

class PushViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
    private let storage = Storage.storage().reference()

    let buttonUpload = UIButton()
    let imageOut = UIImageView()
    //let labelURL = UILabel()
    
    var newSongHeader = UILabel()
    var songTitleNew = UITextField()
    
    var newPicButton = UIButton()
    
    var saveButton = UIBarButtonItem()
    
    
    
    
    
    weak var delegate: addSongDelegate?
    
    init(inputDelegate: addSongDelegate) {
        delegate = inputDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = saveButton
        saveButton.title = "Save"
        saveButton.style = .plain
        saveButton.action = #selector(createSong)
        saveButton.target = self
        
        
        buttonUpload.addTarget(self, action: #selector(tapUploadButton), for: .touchUpInside)
        buttonUpload.translatesAutoresizingMaskIntoConstraints = false
        buttonUpload.setTitleColor(.black, for: .normal)
        buttonUpload.setImage(UIImage(named: "chooseImage"), for: .normal)
        //buttonUpload.setTitle("Upload Clothing Image", for: .normal)
        view.addSubview(buttonUpload)
        
        
        imageOut.translatesAutoresizingMaskIntoConstraints = false
        imageOut.contentMode = .scaleAspectFit
        view.addSubview(imageOut)
        
        
//        labelURL.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelURL)
        
        newSongHeader.text = "Clothing Upload"
        newSongHeader.font = UIFont(name:"Helvetica-Bold", size:32)
        newSongHeader.textColor = .black
        newSongHeader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newSongHeader)
        
        songTitleNew.textColor = .black
        songTitleNew.placeholder = "Enter the type of clothing"
        songTitleNew.font = .systemFont(ofSize: 20, weight: .bold)
        songTitleNew.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(songTitleNew)
        
        
        
        //get the text through a networking request
        
        //calls a function to get request for weather
        //parses what the outfit should be depending on weather
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else{
            return
        }
        //labelURL.text = urlString
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            DispatchQueue.main.async{
                let image = UIImage(data: data)
                self.imageOut.image = image
            }
        })
        
        task.resume()
        setupConstraints()
    }
    
    func setupConstraints() {
    
        NSLayoutConstraint.activate([
            newSongHeader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            newSongHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            imageOut.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageOut.topAnchor.constraint(equalTo: newSongHeader.bottomAnchor, constant: 15),
            imageOut.widthAnchor.constraint(equalToConstant: 350),
            imageOut.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            buttonUpload.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonUpload.topAnchor.constraint(equalTo: imageOut.bottomAnchor, constant: 15),
            buttonUpload.widthAnchor.constraint(equalToConstant: 114),
            buttonUpload.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        
//        NSLayoutConstraint.activate([
//            labelURL.leadingAnchor.constraint(equalTo: buttonUpload.leadingAnchor),
//            labelURL.topAnchor.constraint(equalTo: imageOut.bottomAnchor, constant: 15)
//        ])
        
//        NSLayoutConstraint.activate([
//            newSongHeader.leadingAnchor.constraint(equalTo: buttonUpload.leadingAnchor),
//            newSongHeader.topAnchor.constraint(equalTo: labelURL.bottomAnchor, constant: 15)
//        ])
        
        NSLayoutConstraint.activate([
            songTitleNew.leadingAnchor.constraint(equalTo: imageOut.leadingAnchor, constant: 10),
            songTitleNew.topAnchor.constraint(equalTo: buttonUpload.bottomAnchor, constant: 15)
        ])
       
      
        
    }

    @objc func createSong() {
        var newSong = Clothes(imageName: self.imageOut.image ?? UIImage(named: "box")!, clothesTypeEntered: self.songTitleNew.text ?? "Other")
        delegate?.addSong(song: newSong)
        self.navigationController?.popViewController(animated: true)
        
    }
    
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
           picker.dismiss(animated: true, completion: nil)
           guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
               return
           }
           guard let imageData = image.pngData() else{
               return
           }

           storage.child("images/files.png").putData(imageData, metadata: nil, completion: {_, error in
               guard error == nil else{
                   print("Failed to upload")
                   return
               }
               self.storage.child("images/files.png").downloadURL(completion: {url, error in
                   guard let url = url, error == nil else{
                       return
                   }
                   
                   let urlString = url.absoluteString
                   DispatchQueue.main.async{
                       //self.labelURL.text = urlString
                       self.imageOut.image = image
                   }

                   print("Download URL: \(urlString)")
                   UserDefaults.standard.set(urlString, forKey: "url")
               })
               
           })
           //upload image data
           //get download url
           //save download url to userDefaults
           
       }


       func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
           picker.dismiss(animated: true, completion: nil)
       }
       
       
       @objc func tapUploadButton(){
           let picker = UIImagePickerController()
           picker.sourceType = .photoLibrary
           picker.delegate = self
           picker.allowsEditing = true
           present(picker, animated: true)
       }
       
    


  

    
}
protocol addSongDelegate: UIViewController {
    func addSong(song: Clothes)
}
