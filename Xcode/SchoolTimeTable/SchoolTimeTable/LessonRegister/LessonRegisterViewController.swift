//
//  LessonRegisterViewController.swift
//  SchoolTimeTable
//
//  Created by student on 2023/05/17.
//

import UIKit
import PhotosUI

protocol LessonRegisterDelegate: AnyObject {
    
    func close()
    
}

class LessonRegisterViewController: UIViewController {
    
    weak var delegate: LessonRegisterDelegate?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var teacherTextField: UITextField!
    
    @IBOutlet weak var summaryTextView: UITextView!
    
    @IBOutlet var previewImageViews: [UIImageView]!
    
    @IBOutlet var clearButtons: [UIButton]!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var albumButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func didTapedCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapedCameraButton(_ sender: UIButton) {
        let pickerViewController = UIImagePickerController()
        pickerViewController.sourceType = .camera
        pickerViewController.delegate  =  self
        self.present(pickerViewController, animated: true)
    }
    
    @IBAction func didTapedAlbumButton(_ sender: UIButton) {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let pickerView = PHPickerViewController(configuration: config)
        pickerView.delegate = self
        present(pickerView, animated: true)
    }
    
    @IBAction func didTapedRegisterButton(_ sender: UIButton) {
        guard let title = titleTextField.text,
              let teacher = teacherTextField.text,
              !title.isEmpty,
              !teacher.isEmpty else {
                  return
              }
        
        let viewModel: LessonDetailViewModel = .init(
            title: title,
            teacher: teacher,
            images: images,
            summary: summaryTextView.text)
        TimeTableDataStore.shared.add(item: viewModel, dayOfWeek: .monday)
        delegate?.close()
        dismiss(animated: true)
    }
    
    @IBAction func didTapedClearButton(_ sender: UIButton) {
        clearPreviewImage(index: sender.tag)
    }

    var images: [UIImage] = [] {
        didSet {
            for index in 0..<previewImageViews.count {
                let imageView = previewImageViews[index]
                let clearButton = clearButtons[index]
                if images.indices.contains(index) {
                    let image = images[index]
                    imageView.image = image
                    clearButton.isHidden = false
                } else {
                    imageView.image = nil
                    clearButton.isHidden = true
                }
            }
            cameraButton.isEnabled = isCanImageAdd()
            albumButton.isEnabled = isCanImageAdd()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBorder(view: summaryTextView)
        for imageView in previewImageViews {
            setupBorder(view: imageView)
        }
        for button in clearButtons {
            setupBorder(view: button)
        }
        images = []
    }
    
    func setupBorder(view: UIView) {
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.separator.cgColor
        view.layer.cornerRadius = 5.0
    }
        
//        summaryTextView.layer.borderWidth = 1.0
//        summaryTextView.layer.borderColor = UIColor.lightGray.cgColor
//        summaryTextView.layer.cornerRadius = 5.0
//        registerButton.layer.borderWidth = 1.0
//        registerButton.layer.borderColor = UIColor.lightGray.cgColor
//        registerButton.layer.cornerRadius = 5.0
//
//        for imageView in previewImageViews {
//            imageView.layer.borderWidth = 1.0
//            imageView.layer.borderColor = UIColor.separator.cgColor
//            imageView.layer.cornerRadius = 5.0
//    }
//
//        cameraButton.layer.borderWidth = 1.0
//        cameraButton.layer.borderColor = UIColor.lightGray.cgColor
//        cameraButton.layer.cornerRadius = 5.0
//
//        albumButton.layer.borderWidth = 1.0
//        albumButton.layer.borderColor = UIColor.lightGray.cgColor
//        albumButton.layer.cornerRadius = 5.0
//
//    }
    
}

extension LessonRegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        setPreviewImage(image: image)
        picker.dismiss(animated: true)
    }
    
    func isCanImageAdd() -> Bool  {
        return (images.count < 3)
    }

    func setPreviewImage(image: UIImage) {
        guard isCanImageAdd() else {
            return
        }
        images.append(image)
    }
    
    func clearPreviewImage(index: Int) {
        images.remove(at: index)
    }
    
}

extension LessonRegisterViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let firstItem = results.first,
              firstItem.itemProvider.canLoadObject(ofClass: UIImage.self) else {
            return
        }
        firstItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { image, error in
            guard let image = image as? UIImage else {
                return
            }
            DispatchQueue.main.async {
                self.setPreviewImage(image: image)
            }
        })
    }
    
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
