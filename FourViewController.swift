//
//  FourViewController.swift
//  QueueProject
//
//  Created by Мельник Дмитрий on 01.08.2022.
//

import Foundation
import Photos
import PhotosUI

class Cell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}

class FourViewController: UIViewController, PHPickerViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var images: [UIImage] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.register(Cell.self, forCellWithReuseIdentifier: "cell")
        vc.backgroundColor = .systemGreen
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhotoDidTapped))
        title = "Photo peaker"
        view.backgroundColor = .systemMint
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        
    }
    
    @objc func addPhotoDidTapped() {
        var photoConfiguration = PHPickerConfiguration(photoLibrary: .shared())
        photoConfiguration.selectionLimit = 5
        photoConfiguration.filter = .images
        
        let phPeackerVC = PHPickerViewController(configuration: photoConfiguration)
        present(phPeackerVC, animated: true) {
            print("ph PeackerVC was presented")
        }
        phPeackerVC.delegate = self
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true) {
            print("ph PeackerVC was dismissed")
        }
        let group = DispatchGroup()
        results.forEach { result in
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                defer {
                    group.leave()
                }
                guard let photo = reading as? UIImage, error == nil else { return }
                self.images.append(photo)
                print(photo)
            }
        }
        group.notify(queue: .main) {
            self.collectionView.reloadData()
            print(self.images.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell else { fatalError() }
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    
    
}
