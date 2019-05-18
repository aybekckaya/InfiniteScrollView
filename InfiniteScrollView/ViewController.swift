//
//  ViewController.swift
//  InfiniteScrollView
//
//  Created by aybek can kaya on 17.05.2019.
//  Copyright © 2019 aybek can kaya. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    private var bannerView:BannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpBannerView()
    }
    
    private func setUpUI() {
        self.view.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.2431372549, blue: 0.3137254902, alpha: 1)
        
        bannerView = BannerView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: 200))
        self.view.addSubview(bannerView)
       
        bannerView.backgroundColor = UIColor.green
        
    }
    
    private func setUpBannerView() {
      
        bannerView.reloadData(configuration: nil, numberOfItems: 5) { (bannerView, index) -> (UIView) in
           
           return self.itemView(at: index)
        }
    }
    
    private func itemView(at index:Int)->UIImageView {
        let urls:[String] = ["https://images.pexels.com/photos/236047/pexels-photo-236047.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            "https://cdn.pixabay.com/photo/2015/12/01/20/28/fall-1072821__340.jpg",
            "https://images.pexels.com/photos/257360/pexels-photo-257360.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            "https://cdn.pixabay.com/photo/2017/04/09/09/56/avenue-2215317__340.jpg",
            "https://images.unsplash.com/photo-1500622944204-b135684e99fd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"]
        let itemImageView:UIImageView = UIImageView(frame: .zero)
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.setImage(path: urls[index])
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = UIView.ContentMode.scaleAspectFill
       
        return itemImageView
    }


}

extension UIImageView {
    
    func setImage(path:String) {
        guard let url:URL = URL(string: path) else { return }
        DispatchQueue.global(qos: .background).async {
            guard let data:Data = try? Data(contentsOf: url) , let image:UIImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    
}



